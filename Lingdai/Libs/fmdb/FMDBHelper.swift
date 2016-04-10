//
//  FMDBHelper.swift
//  FMDataBaseHelper
//
//  Created by 钟其鸿 on 16/1/29.
//  Copyright © 2016年 LearnDaily. All rights reserved.
//

import UIKit
//根据程序名字建sqlite表
let databaseFileName = "\(NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String).sqlite"


class DatabaseManager: NSObject {
    var isInitialize = false
    var isOpened = false
    var dataPath:String!
    var databaseQueue: FMDatabaseQueue!
    
    class var currentManager: DatabaseManager{
        struct Static {static let currentManager = DatabaseManager()}
        
        return Static.currentManager
    }
    
    func openDataBase() {
        //print("数据地址:\(dataPath)")
        databaseQueue = FMDatabaseQueue(path: documentPath(databaseFileName))
        
        if databaseQueue == 0x00 {
            isOpened = false
            return
        }
        isOpened = true
        databaseQueue.inDatabase { (db) -> Void in
            db.setShouldCacheStatements(true)
            print("打开数据库成功!")
        }
    }
    
    func closeDataBase() {
        if !isOpened {
            print("未打开,或打开失败,关闭数据库失败!")
        }
        databaseQueue.close()
        isOpened = false
        print("关闭数据库成功!")
    }
}

func documentPath(fileName:String)->String {
    let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
    if path.count > 0 {
        return  (path[0] as NSString).stringByAppendingPathComponent(fileName)
    }
    //    let alert = UIAlertView(title: "提醒", message: "获取文件路径失败!", delegate: nil, cancelButtonTitle: "确定")
    //    alert.show()
    return ""
}

public class DataBaseHelper:NSObject{
    
    var className: String = "\(self.dynamicType)"
    
    var databaseQueue = DatabaseManager.currentManager.databaseQueue
    
    
    public convenience init(tableName:String) {
        self.init()
        self.className = tableName
        if !DatabaseManager.currentManager.isOpened {
           
            DatabaseManager.currentManager.openDataBase()
            databaseQueue = DatabaseManager.currentManager.databaseQueue
//            if databaseQueue != nil {
//                createDataTables()
//            }
        }
        if DatabaseManager.currentManager.isOpened && databaseQueue != nil {
            createDataTables()
        }
    }
    
    public override init() {
        super.init()
    }
    
    func update(sql:String,arguments:[AnyObject],callback:(success:Bool)->Void){
        autoreleasepool { () -> () in
            databaseQueue.inDatabase({ (db) -> Void in
                
               // let sql = "update \(self.className) set deletedTime = ? where lesionId=\(lesion.lesionId)"
                
                let res = db.executeUpdate(sql, withArgumentsInArray: arguments)
                
                callback(success: res)
                
            })
        }
    }
//    /**
//     增加数据
//     - parameter callBack: 回调success = true为数据操作成功
//     */
//    func addUser(user:User,callBack:(success:Bool)->Void) {
//        
//        databaseQueue.inDatabase { (db) -> Void in
//            
//            let sql = "INSERT INTO \(self.className)(account) values(?)"
//            let res = db.executeUpdate(sql, withArgumentsInArray :[NSNumber(integer: 20)])
//            
//            print("数据写入\(res ? "成功" : "失败")")
//            callBack(success: res)
//        }
//    }
    
    
    
    /*
    *创建表格
    */
    public func createDataTables() {
        autoreleasepool { () -> () in
            
            databaseQueue.inTransaction({ (db, rollback) -> Void in
                let sql = "CREATE TABLE IF NOT EXISTS \(self.className) ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,'account' INTEGER)"
                
                db.executeStatements(sql)
                
            })
        }
    }
    /*
    *删除表格
    */
    func dropTable(callBack:(success:Bool)->Void){
        
        databaseQueue.inDatabase { (db) -> Void in
            let sql = "DROP TABLE \(self.className)"
            let res = db.executeUpdate(sql, withArgumentsInArray: [])
            print("删除表格\(res ? "成功" : "失败")")
            callBack(success: res)
        }
        
    }
    
    /**
     删除数据本类的表的所有数据
     - parameter callBack: 操作结果回调
     */
    func removeAll(callBack:(success:Bool)->Void) {
        databaseQueue.inDatabase { (db) -> Void in
            let sql = "DELETE FROM \(self.className)"
            let res = db.executeUpdate(sql, withArgumentsInArray: [])
            print("数据全部删除\(res ? "成功" : "失败")")
            callBack(success: res)
        }
    }
    
    /**
     获取表中的数据总数
     - parameter callBack: 操作结果回调
     */
    func count(callBack:(num: Int32) -> Void) {
        databaseQueue.inDatabase { (db) -> Void in
            let sql = "SELECT COUNT(*) FROM \(self.className)"
            let results:FMResultSet? = db.executeQuery(sql,withArgumentsInArray: nil)
            if let results = results where results.next() {
                callBack(num: results.intForColumnIndex(0))
            }else {
                callBack(num: 0)
            }
            results?.close()
        }
    }
    
    /**
     根据ID删除数据
     
     - parameter id:       传入数据ID
     - parameter callBack: 删除结果
     */
    func removeBy(id:String?, callBack:(success:Bool)->Void) {
        if id == nil{
            callBack(success: false)
            return
        }
        
        databaseQueue.inDatabase { (db) -> Void in
            let sql = "DELETE FROM \(self.className) WHERE id = ?"
            let res = db.executeUpdate(sql, withArgumentsInArray: [id!])
            print("数据删除\(res ? "成功" : "失败")")
            callBack(success: res)
        }
    }
    
    
    
    
    
    
}
func convertStringArrayToData(str:[String]?) ->NSData{
    if str == nil {
        return NSData()
        
    }
    
    return  NSKeyedArchiver.archivedDataWithRootObject(str!)
    
}

func convertDataToStringArray(data:NSData?) ->[String]{
    if(data == nil){
        return [String]()
    }
    
    return   NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! [String]
}

