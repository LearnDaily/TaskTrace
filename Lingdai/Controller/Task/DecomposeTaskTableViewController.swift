//
//  DecomposeTaskTableViewController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/12.
//
//

import UIKit

protocol DeriveSubTask {
    func deriveSubTask(task:TaskModel)
}

public enum TaskOperator:Int{
    case Create = 1
    case Divide = 2
}
class DecomposeTaskTableViewController: UITableViewController {
    var taskOperator:TaskOperator = .Divide
    var task:TaskModel?
    var delegate:DeriveSubTask?
    var taskManager =  TaskDBManager.sharedInstance
    var parentTaskId = ""
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var assigneeLabel: UILabel!
    @IBOutlet weak var titleLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if taskOperator == .Create {
            self.title = "创建新任务"
        }
        
        else if taskOperator == .Divide {
            self.title = "拆分任务"
        }
        
        
        if let workingTask = task {
            titleLabel.text = workingTask.title
            assigneeLabel.text = workingTask.assignees.first?.name
            deadlineLabel.text = workingTask.deadline
        }
        else{
            makeEmptyTask()
        }
        
        tabBarController?.tabBar.hidden = true
        
        if UserModel.userAccount == NULL || UserModel.userPassword == NULL {
            NSNotificationCenter.defaultCenter().postNotificationName(GO_TO_LOGIN, object: 1)
        }

    }
    
    
    
   
    class func  getInstance() ->DecomposeTaskTableViewController{
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DecomposeTaskTableViewController") as! DecomposeTaskTableViewController
        
        
        return vc;
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitTask(sender: AnyObject) {
      
        if !titleLabel.text!.isEmpty
        {
            task!.title = titleLabel.text
            task!.pId = parentTaskId
            delegate?.deriveSubTask(task!)
            taskManager.addTask(task!, callback: { (taskId) -> Void in
               //TaskDBManager.taskChanged(taskId)
                
                 NSNotificationCenter.defaultCenter().postNotificationName(TaskDBManager.Notification.TaskChanged, object: taskId)
            })
            
            
        }
        
      
        
        tabBarController?.tabBar.hidden = false
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "assignToEmployee")
        {
            var employeeTableViewController = segue.destinationViewController as! EmployeeTableViewController
            employeeTableViewController.delegate = self
            employeeTableViewController.assignees = task?.assignees
        }
        else if(segue.identifier == "setDeadline"){
            var deadlineTableViewController = segue.destinationViewController as! DeadLineCalendarViewController
            deadlineTableViewController.delegate = self
            deadlineTableViewController.deadline = task?.deadline
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func configureTask(title:String){
        
        task?.title = title
    }
    
    func makeEmptyTask(){
        if task == nil {
            task = TaskModel()
        }
    }
    


}

extension DecomposeTaskTableViewController:AssignTask,DeadlineSetting{
    
    func assignTo(assignees: [EmployeeModel]?) {
        
        makeEmptyTask()
        
        if(assignees != nil && assignees!.count > 0){
             assigneeLabel.text = assignees![0].name
            
            
            if let newAssignees = assignees{
                if task!.assignees == nil {
                    task!.assignees = [EmployeeModel]()
                }
                task!.assignees.removeAll(keepCapacity: false)
                for assignee in newAssignees {

                    task!.assignees.append(assignee)
                }
            }

        }
      
        
    }
    
    func setDeadline(time: String?) {
        
        if let deadline = time {
            deadlineLabel.text = deadline
            task!.deadline = deadline
        }
        
        
       
    }
}
