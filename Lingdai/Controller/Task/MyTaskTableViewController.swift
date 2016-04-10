//
//  MyTaskTableViewController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/23.
//
//

import UIKit
var rootTask = [TaskModel]()
class MyTaskTableViewController: BaseTableViewController {
    
    
   
    
  //  var allTasks:[TaskModel] = [TaskModel]()
    var taskManager = TaskDBManager.sharedInstance
    var reloadTaskIfNeed = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        
//        var uuid = NSUUID().UUIDString
//        print(uuid)

//      
//        TaskDBManager.bindAndFireTaskListener("MyTaskTableViewController") { (taskId) -> Void in
//            self.loadData()
//            
//            print("MyTaskTableViewController reloadData")
//        }
//        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "taskChanged:", name: TaskDBManager.Notification.TaskChanged, object: nil)
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if reloadTaskIfNeed == true {
            loadData()
        }
    }
  
   
    func loadData(){
       
        weak var weakSelf = self
        taskManager.findAll { (tasks) -> Void in
//            rootTask.clearSubTasks()
//            for task in tasks {
//                rootTask.addSubTask(task)
//            }
            rootTask = tasks
            weakSelf?.tableView.reloadData()
            weakSelf?.reloadTaskIfNeed = false
        }
    }
    
    func taskChanged(notification: NSNotification){
        print("MyTaskTableViewController reloadData")
        if let id = notification.object as? String {
            print("id: \(id)")
            reloadTaskIfNeed = true
            //loadData()
        }
    }
    
    class var instance:MyTaskTableViewController{
        
        get{
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MyTaskTableViewController") as! MyTaskTableViewController
            
            return vc;
            
            
        }
    }
    
    


    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rootTask.count
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = TaskDetailTableViewController.instance
        vc.task = rootTask[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
        //performSegueWithIdentifier("MyTaskTableViewController", sender: nil)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:NameValueTableViewCell  = tableView.dequeueReusableCellWithIdentifier("nameValueIdentifer", forIndexPath: indexPath) as!NameValueTableViewCell
        
        let task = rootTask[indexPath.row]
        if(task.assignees.count > 1){
             cell.configureCell((task.assignees.first?.name)! + "等", value:task.title)
        }
        else if (task.assignees.count == 1){
             cell.configureCell(task.assignees.first?.name, value:task.title)
        }
        else {
             cell.configureCell("未指定", value:task.title)
        }
        cell.setNameColor()
        // Configure the cell...

       return cell
    }




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}