//
//  ContactsDBManager.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/21.
//
//

import UIKit




class ContactsDBManager: NSObject {

    static var  contactsDBManagerInstance:ContactsDBManager!
    var contactsDatabase = ContactsDatabaseHelper(tableName: "ContactsDatabase")
    
    class var instance:ContactsDBManager{
        get{
            if contactsDBManagerInstance == nil{
                contactsDBManagerInstance =  ContactsDBManager()
            }
            return contactsDBManagerInstance
        }
    }
    
    
    func addContact(employee:EmployeeModel){
        if employee.number.isEmpty {
            employee.number = "-1"
        }
        contactsDatabase.insertEmployee(employee)
    }
    
    func addContacts(employees:[EmployeeModel]){
       contactsDatabase.insertEmployees(employees)
        
       // contactsDatabase.insertEmployee(employees.first!)
        
       
    }
    
    func findAll(cb:(employees:[ContactModel])->Void){
        
         contactsDatabase.queryEmployees( callback: cb )
    }
    
    class ContactsDatabaseHelper:DataBaseHelper{
        
        
        
        /*
        *创建表格
        */
        override func createDataTables() {
            autoreleasepool { () -> () in
                
                print("create table:\(self.className)")
                
                
                
                
                databaseQueue.inTransaction({ (db, rollback) -> Void in
                    let sql = "CREATE TABLE IF NOT EXISTS \(self.className) ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,'employeeId' VARCHAR(30) ,'employeeName' VARCHAR(30),'employeeNumber' VARCHAR(30),'phoneNumber' VARCHAR(30) )"
                    
                    db.executeStatements(sql)
                    
                })
            }
        }
        
        func insertEmployee(employee:EmployeeModel){
            autoreleasepool { () -> () in
              
                
                databaseQueue.inDatabase({ (db) -> Void in
                    let sql = "insert into \(self.className)('employeeId','employeeName','employeeNumber','phoneNumber') values (?,?,?,?)"
                    db.executeUpdate(sql, withArgumentsInArray: [employee.id,employee.name,employee.number,employee.phoneNumber
                        ])
                      print("insert employeeId:\(employee.id) name: \(employee.name) phone:\(employee.phoneNumber)")
                    
                })
                
            }
        }
        
        func insertEmployees(employees:[EmployeeModel]){
            autoreleasepool { () -> () in
                databaseQueue.inTransaction({ (db, rollback) -> Void in
                    
                    var sql = "insert into \(self.className)('employeeId','employeeName','phoneNumber')"
                    for index in 0...employees.count-1 {
                        var employee = employees[index]
                        //employee.name = "werew"
                        if(index > 0){
                            sql += " union"
                        }
                        sql += " select '\(employee.id)', '\(employee.name)','\(employee.phoneNumber)'"
                    }
                    
                    
                    print("\(sql)")
                    
                    db.executeStatements(sql)
                    
                })
            }
        }
        
        func queryEmployees(page:Int=0,num:Int=20,employeeIds:[String]=[],callback:([ContactModel])->Void?){
            autoreleasepool { () -> () in
             databaseQueue.inDatabase({ (db) -> Void in
                var rs:FMResultSet!
                var employees = [ContactModel]()
                var sql:String  = "select * from \(self.className)"
                    if(employeeIds.count>0){
                        var idString = ""
                        for id in employeeIds {
                         idString += "\(id),"
                        }
                        idString = (idString as NSString).substringToIndex(idString.characters.count - 1)
                        sql = "select * from \(self.className) where employeeId in(\(idString))"
                    }
                //
                //
                    if page != 0 {
                        sql += "limit \(num*(page-1)), \(page)"
                    }
                //
                    print("query sql:\(sql)")
                //
                    rs = db.executeQuery(sql, withArgumentsInArray: [])
                //
                    while(rs.next()){
                        let employee = ContactModel()
                        employee.id = rs.stringForColumn("employeeId")
                        if(rs.stringForColumn("employeeName") != nil){
                            employee.name = rs.stringForColumn("employeeName")
                        }
                        if(rs.stringForColumn("phoneNumber") != nil){
                            employee.phoneNumber = rs.stringForColumn("phoneNumber")
                        }
                        
                        //employee.phoneNumbers = rs.stringForColumn("deletedTime")
                        //lesion.indexForList = Int64(NSNumber(int: rs.intForColumn("indexForList")).intValue)
      
                        print("##########")
                        print("employeeId: \(employee.id) ,employeeName: \(employee.name)")
             
                        employees.append(employee)
                    }
                     callback(employees)
              })
                
               
            }
        }
        
        func updateLesion(employee:EmployeeModel,callback:(success:Bool)->Void){
//            autoreleasepool { () -> () in
//                databaseQueue.inDatabase({ (db) -> Void in
//                    
//                    let sql = "update \(self.className) set deletedTime = ? where lesionId=\(lesion.lesionId)"
//                    
//                    let res = db.executeUpdate(sql, withArgumentsInArray: [lesion.deletedTime])
//                    
//                    callback(success: res)
//                    
//                })
//            }
        }
        
        func queryLesion(page:Int=0,num:Int=20,lesionIds:[String]=[],callback:([EmployeeModel])->Void){
//            
//            autoreleasepool { () -> () in
//                databaseQueue.inDatabase({ (db) -> Void in
//                    var rs:FMResultSet!
//                    var lesions = [Lesion]()
//                    var sql:String  = "select * from \(self.className)"
//                    if(lesionIds.count>0){
//                        
//                        var idString = ""
//                        for id in lesionIds {
//                            idString += "\(id),"
//                        }
//                        
//                        
//                        
//                        idString = (idString as NSString).substringToIndex(idString.characters.count - 1)
//                        
//                        sql = "select * from \(self.className) where lesionId in(\(idString))"
//                    }
//                    
//                    
//                    if page != 0 {
//                        sql += "limit \(num*(page-1)), \(page)"
//                    }
//                    
//                    print("query sql:\(sql)")
//                    
//                    rs = db.executeQuery(sql, withArgumentsInArray: [])
//                    
//                    while(rs.next()){
//                        let lesion = Lesion()
//                        lesion.lesionId = rs.stringForColumn("lesionId")
//                        lesion.reportTime = rs.stringForColumn("reportedTime")
//                        lesion.deletedTime = rs.stringForColumn("deletedTime")
//                        lesion.indexForList = Int64(NSNumber(int: rs.intForColumn("indexForList")).intValue)
//                        
//                        if(rs.dataForColumn("infos") != nil) {
//                            lesion.infos = dataConvertToLesionInfo(rs.dataForColumn("infos"))
//                            
//                        }
//                        print("##########")
//                        print("query result:[ id =\(lesion.lesionId),reportedTime =\(lesion.reportTime),deletedTime=\(lesion.deletedTime),indexForList=\(lesion.indexForList)")
//                        if let infos = lesion.infos{
//                            for info in infos
//                            {
//                                print("position =\(info.position),size=\(info.size),firmness=\(info.firmness),editime=\(info.editedTime)")
//                            }
//                        }
//                        
//                        lesions.append(lesion)
//                    }
//                    
//                    
//                    
//                    
//                })
//            }
        }
        
        
        
        func getLesions(employeeIds:[Int64]){
            
            let sqlString = "Select * from \(self.className) where id in(?)"
            let params = employeeIds
            
        }
        
    }
    

}
