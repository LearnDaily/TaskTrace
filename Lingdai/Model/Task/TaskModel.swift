//
//  TaskModel.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/13.
//
//

import UIKit

class TaskModel: TreeNode {
    
    var title:String!
    var userId:String!
    var deadline:String!
    var postTime:String!
    var assignees:[EmployeeModel]!
  //  var subTasks:[TaskModel]?
    var reply:[ReplyModel]?
    
    override init(desc: String?, id:String , pId: String? , name: String?) {
        super.init(desc: desc, id: id, pId: pId, name: name)
        
        title = "Untitle"
        let now:NSDate! = NSDate()
        deadline = NSDateFormatter.defaultDateFormatter().stringFromDate(now)
        // .dateFormatterWithFormat.stringFromDate(NSDate())
        postTime = "\(NSDate())"
        assignees = [EmployeeModel]()
        reply = [ReplyModel]()
        self.id = "\(NSDate().timeIntervalSince1970)"
        print("id: \(id)")
    }
    
    
    
    convenience  init() {
        self.init(desc: "", id: "", pId: "", name: "")
        
 
    }
    
    convenience init(json:JSON){
        self.init()
        title = json["title"].stringValue
        userId = json["userId"].stringValue
        postTime = json["postTime"].stringValue
        deadline = json["deadLine"].stringValue
        var assigneesString = json["assignee"].arrayValue
        for item in assigneesString {
            assignees.append(EmployeeModel(json:item))
        }
    }
    
    func getJson()->[String:AnyObject]{
        
        var parameter:[String:AnyObject] = [String:AnyObject]()
        parameter["title"] = self.title
        parameter["deadline"] = self.deadline
        if let parentTask = self.parent{
            parameter["parentTask"] = parentTask
        }
        else{
            parameter["parentTask"] = "Root"
        }
        
        parameter["postTime"] = self.postTime
        parameter["userId"] = UserModel.userAccount
        if self.assignees != nil{
            var assigneeIds = [String]()
            for assignee in assignees {
                assigneeIds.append(assignee.id)
                print("id:\(assignee.id)")
            }
            parameter["assignees"] = assigneeIds
        }
        
        return parameter
        
        
        
    }
    
    func addSubTask(task:TaskModel){
   
        children.append(task)
        print("appendTask name:\(task.title)")
    }
    
    func addSubTask(task:TaskModel,index:Int){
        
        children.insert(task, atIndex: index)
       // makeEmptyTasks()
       // subTasks?.insert(task, atIndex: index)
        print("insertTask name:\(task.title)")
    }
    
    func addSubTasks(tasks:[TaskModel]){
       // makeEmptyTasks()
        for task in tasks {
            children.append(task)
            print("appendTask name:\(task.title)")
        }
    }
    
    func removeSubTaskAt(index:Int){
      
            if children.count > index && index >= 0{
                var removedTask = children.removeAtIndex(index)
                print("removedTask name:\((removedTask as! TaskModel).title)")
            }
        
    }
    
//    func makeEmptyTasks(){
//        if(self.subTasks == nil){
//            subTasks = [TaskModel]()
//        }
//
//    }
    
    func clearSubTasks(){
        children.removeAll()
    }

}
