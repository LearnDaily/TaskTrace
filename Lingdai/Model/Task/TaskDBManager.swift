//
//  TaskDBManager.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/24.
//
//

import UIKit

class TaskDBManager: NSObject {
    
    var newTaskId:String = ""
    static var taskListeners:Set<TaskListener> = Set<TaskListener>()
    
    var taskDatabase:TaskDatabaseHelper = TaskDatabaseHelper(tableName: "TaskDatabase")
    

    
    // 单例模式
    class var sharedInstance: TaskDBManager {
        struct Static {
            static var instance: TaskDBManager?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Static.token) { // 该函数意味着代码仅会被运行一次，而且此运行是线程同步
            Static.instance = TaskDBManager()
        }
        return Static.instance!
    }

    
    
    
    func addTask(task:TaskModel,callback:(String) ->Void){
        
        taskDatabase.insertTask(task,callback:callback)
        
        
    }
    
    func updateTask(parentId:String,subTasks:[TaskModel]){
        taskDatabase.updateSubTask(parentId, subTasks: subTasks, callback: {
            (success) in
            
            print("add subtask succeed")
        })
    }
//
//    func addContacts(employees:[EmployeeModel]){
//        taskDatabase.insertEmployees(employees)
//        
//        // contactsDatabase.insertEmployee(employees.first!)
//        
//        
//    }
//    
    func findAll(cb:(tasks:[TaskModel])->Void){
        
        taskDatabase.queryTask( callback: cb )
    }
//
    class TaskDatabaseHelper:DataBaseHelper{
        
        
        
        /*
        *创建表格
        */
        override func createDataTables() {
            autoreleasepool { () -> () in
                
                print("create table:\(self.className)")
                
                
                databaseQueue.inTransaction({ (db, rollback) -> Void in
                    let sql = "CREATE TABLE IF NOT EXISTS \(self.className) ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,'taskId' VARCHAR(30) ,'taskTitle' VARCHAR(30),'deadline' VARCHAR(30),'parentId' VARCHAR(30),'subTasks' BLOB, 'assignees' BLOB )"
                    print(sql)
                    db.executeStatements(sql)
                    
                })
            }
        }
        
        func insertTask(task:TaskModel,callback:(id:String)->Void){
            autoreleasepool { () -> () in
                
                
                databaseQueue.inDatabase({ (db) -> Void in
                    var subTasks:[String] = []
                    let sql = "insert into \(self.className)('taskId','taskTitle','parentId','deadline','subTasks','assignees') values (?,?,?,?,?,?)"
                    if task.children.count > 0{
                        for child in task.children {
                            subTasks.append(child.id)
                        }
                    }
                    let res = db.executeUpdate(sql, withArgumentsInArray: [task.id,task.title,task.pId!,task.deadline,convertStringArrayToData(subTasks), self.asigneesConvertToData(task.assignees)
                        ])
                    var taskId = NULL
                    if res == true {
                        taskId = task.id
                    }
                   
                    callback(id: taskId)
                    print("insert task:\(task.title)")
                    
                })
                
            }
        }
        
        func asigneesConvertToData(employees :[EmployeeModel]?) -> NSData {
            
            if(employees == nil){
                
                return NSData()
            }
            
            return  NSKeyedArchiver.archivedDataWithRootObject(employees!)
        }
        
        func dataConvertToAsignees(data:NSData?)->[EmployeeModel]?{
            if(data == nil){
                return [EmployeeModel]()
            }
            
            return   NSKeyedUnarchiver.unarchiveObjectWithData(data!) as? [EmployeeModel]
        }

        
//        func insertEmployees(TASK:[EmployeeModel]){
//            autoreleasepool { () -> () in
//                databaseQueue.inTransaction({ (db, rollback) -> Void in
//                    
//                    var sql = "insert into \(self.className)('employeeId','employeeName','phoneNumber')"
//                    for index in 0...employees.count-1 {
//                        var employee = employees[index]
//                        //employee.name = "werew"
//                        if(index > 0){
//                            sql += " union"
//                        }
//                        sql += " select '\(employee.id)', '\(employee.name)','\(employee.phoneNumber)'"
//                    }
//                    
//                    
//                    print("\(sql)")
//                    
//                    db.executeStatements(sql)
//                    
//                })
//            }
//        }
        
        func queryTask(page:Int=0,num:Int=20,taskIds:[String]=[],callback:([TaskModel])->Void?){
            autoreleasepool { () -> () in
                databaseQueue.inDatabase({ (db) -> Void in
                    var rs:FMResultSet!
                    var tasks = [TaskModel]()
                    var sql:String  = "select * from \(self.className)"
                    if(taskIds.count>0){
                        var idString = ""
                        for id in taskIds {
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
                    //print("query sql:\(sql)")
                    //
                    rs = db.executeQuery(sql, withArgumentsInArray: [])
                     print("##########")
                    while(rs.next()){
                        let task = TaskModel()
                       
                        if(rs.stringForColumn("taskId") != nil){
                          
                            task.id = rs.stringForColumn("taskId")
                            print("taskid: \(task.id)")
                        }
                        if(rs.stringForColumn("taskTitle") != nil){
                            task.title = rs.stringForColumn("taskTitle")
                        }
                        if(rs.stringForColumn("deadline") != nil){
                            task.deadline = rs.stringForColumn("deadline")
                        }
                        if(rs.stringForColumn("parentId") != nil){
                            task.pId = rs.stringForColumn("parentId")
                            print("parentId: \(task.pId)")
                            
                        }
                        if(rs.dataForColumn("assignees") != nil){
                            task.assignees = self.dataConvertToAsignees(rs.dataForColumn("assignees"))
                            for assign in task.assignees {
                                print("assign:id \(assign.id)")
                            }
                        }
                        if(rs.dataForColumn("subTasks") != nil){
                            var subTaskIds = convertDataToStringArray(rs.dataForColumn("subTasks"))
                        
                            for taskId in subTaskIds {
                                var subTask = TaskModel()
                                subTask.id = taskId
                                subTask.pId = task.id
                                task.children.append(subTask)
                            }
                            
                        }

                       tasks.append(task)
                    }
                    callback(tasks)
                })
                
                
            }
        }

        func updateSubTask(taskId:String,subTasks:[TaskModel],callback:(success:Bool)->Void){
            
            let sql = "update \(self.className) set subTasks = ? where taskId=\(taskId)"
            var taskIds = [String]()
            for subtask in subTasks {
                taskIds.append(subtask.id)
            }
            update(sql, arguments: [convertStringArrayToData(taskIds)], callback:callback)
        }
//
        
        
    }
    

}
func ==(lhs: TaskDBManager.TaskListener, rhs: TaskDBManager.TaskListener) -> Bool {
    return lhs.id == rhs.id
}

extension TaskDBManager{
    
    struct TaskListener: Hashable {
        let id: String
        
        typealias Action = String -> Void
        let action: Action
        
        
        
        var hashValue: Int {
            return id.hashValue
        }
    }

    
    struct Notification {
        static let TaskChanged = "TaskDBManager.Notification.TaskChanged"
    }
    
    class func bindTaskListener(id: String, action: TaskListener.Action) {
        var taskListener = TaskListener(id: id, action: action)
        
        TaskDBManager.taskListeners.insert(taskListener)
    }
    
    class func bindAndFireTaskListener(id: String, action: TaskListener.Action) {
        bindTaskListener(id, action: action)
        action(id)
    }
    
    
    class  func taskChanged(id:String){
        
        NSNotificationCenter.defaultCenter().postNotificationName(Notification.TaskChanged, object: id)
        
        
//        for listener  in TaskDBManager.taskListeners {
//            listener.action(id)
//        }
    }
    
    
    
}