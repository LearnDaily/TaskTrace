//
//  TaskDetailTableViewController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/12.
//
//

import UIKit

func createNameValue(name:String,value:String) ->NameValueView{
    let nameValueView = UINib(nibName: "NameValueView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! NameValueView
    nameValueView.setNameValue(name, value: value)
    
    return  nameValueView
    
}

let  defaultColor = UIColor(r: 32, g: 154, b: 208)

typealias replyTo =  (text:String,to:String)->Void


class TaskDetailTableViewController: BaseTableViewController {
    
    let textInputBar = ALTextInputBar()
    let keyboardObserver = ALKeyboardObservingView()
    
    var task:TaskModel = TaskModel()
    var subTask:TaskModel?
    
    let SECTION_ID_SUBTASK = 2
    let SECTION_ID_FEED = 3
    let SECTION_ID_BASE = 1
    let SECTION_TASK_STATUS = 4
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.hidden = true
      
        //setupData()
    }
    
    
    class var instance:TaskDetailTableViewController{
        
        get{
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TaskDetailTableViewController") as! TaskDetailTableViewController
            
            
            return vc;
            
            
        }
    }

    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        textInputBar.removeFromSuperview()
    }
    
    @IBAction func goBack(sender:AnyObject){
        
        tabBarController?.tabBar.hidden = false
        navigationController?.popViewControllerAnimated(true)
    }

   
    func setupData(){
        
        let reply = ReplyModel()
        reply.commentContent = "sdfdf放到放到放到发地方 的放到发地方地方额发分饿分发分分饿分发饿分分发饿分发分分饿分发分饿发多发点放到分发分分饿分发分饿分发饿分发分分饿分分水电费大幅度发大幅度发水电费的房顶上第三方大幅度第三方第三方第三方第三方第三方地方分"
        reply.replyContent =  "多发点放到分发分分饿分发分饿分发饿分发分分饿分分水电费大幅度发大幅度发水电费的房顶上第三方大幅度第三方第三方第三方第三方第三方地方分"
        task.reply?.append(reply)
        
        
        let reply1 = ReplyModel()
        reply1.commentContent = "发分分饿分发分饿发"
        reply1.replyContent = "多发点放到分发分分饿分发分饿"
        task.reply?.append(reply1)
        
        var assignee = EmployeeModel()
        assignee.name = "王宝强"
        task.assignees.append(assignee)
        
        var assignee1 = EmployeeModel()
        assignee1.name = "郭富城"
        task.assignees.append(assignee1)
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
//
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section == 0)
        {
            return 1
        }
        else if(section == SECTION_ID_BASE ){
            
            if let assignees = task.assignees{
                
                if assignees.count > 0{
                      return 4
                }
              
            }
            return 3
        }
        else if(section == SECTION_ID_SUBTASK){
            
            if task.children.count > 0 {
                return task.children.count
            }
            else{
                return 1
            }
            
        }
        else if(section == SECTION_ID_FEED ){
            if let reply = task.reply {
                return reply.count
            }
        }
        
        return 0
        
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        
        if(section == SECTION_ID_SUBTASK){
            
            return createSubTaskHeader()
        }
        else if(section == SECTION_ID_FEED){
            return createFeedsHeader()
        }
        else{
            return super.tableView(tableView, viewForHeaderInSection: section)
        }
        
        
    }
    //22 134 200
    func createDelSectionView(leftTitle:String,rightTtitle:String,action:Selector?)->UIView?{
        
        let sectionView = UIView(frame: CGRectMake(0,0,SCREEN_WIDTH,20))
        let delButton = UIButton()
        sectionView.addSubview(delButton)
        delButton.titleLabel?.font =  UIFont.systemFontOfSize(13)
        delButton.setTitleColor(UIColor(r: 22, g: 134, b: 200), forState: UIControlState.Normal)
        delButton.translatesAutoresizingMaskIntoConstraints = false
        delButton.setTitle(rightTtitle, forState: UIControlState.Normal)
        
        if let act = action{
               delButton.addTarget(self, action: act, forControlEvents: UIControlEvents.TouchUpInside)
        }
        else {
            delButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        }
        
     

        let btnTopConstraint =  NSLayoutConstraint(item: delButton, attribute: .Top, relatedBy: .Equal, toItem: sectionView, attribute: .Top, multiplier: 1, constant: 4)
        
         let btnButtomConstraint =  NSLayoutConstraint(item: delButton, attribute: .Bottom, relatedBy: .Equal, toItem: sectionView, attribute: .Bottom, multiplier: 1, constant: -6)
        
        let btnRightConstraint = NSLayoutConstraint(item: delButton, attribute: .Right, relatedBy: .Equal, toItem: sectionView, attribute: .Right, multiplier: 1, constant: -10)
    
        NSLayoutConstraint.activateConstraints([btnTopConstraint,btnButtomConstraint,btnRightConstraint])
        
        


        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFontOfSize(13)
        titleLabel.textColor = UIColor.Gray(100)
        sectionView.addSubview(titleLabel)
        titleLabel.text = leftTitle
        let labelTopConstraint =  NSLayoutConstraint(item: titleLabel, attribute: .Top, relatedBy: .Equal, toItem: sectionView, attribute: .Top, multiplier: 1, constant: 4)
        
        let labelButtomConstraint =  NSLayoutConstraint(item: titleLabel, attribute: .Bottom, relatedBy: .Equal, toItem: sectionView, attribute: .Bottom, multiplier: 1, constant: -6)
        
        let labelLeftConstraint = NSLayoutConstraint(item: titleLabel, attribute: .Left, relatedBy: .Equal, toItem: sectionView, attribute: .Left, multiplier: 1, constant: 10)
        
        NSLayoutConstraint.activateConstraints([labelButtomConstraint,labelLeftConstraint,labelTopConstraint])
        
        
        
        return sectionView
        
        
    }
    
    func createSubTaskHeader() ->UIView?{
        if UserModel.sharedInstance.belongTo(compareTo: task.assignees) == true{
              return createDelSectionView("任务细分",rightTtitle: "分解任务",action: #selector(TaskDetailTableViewController.assignTask(_:)))
        }
        else {
              return createDelSectionView("任务细分",rightTtitle: "分解任务",action: nil)
        }
     
    }
    
    func createFeedsHeader() ->UIView?{
        return createDelSectionView("动态",rightTtitle: "写留言",action: #selector(TaskDetailTableViewController.comment(_:)))
    }
    
    func comment(sender:AnyObject){
        configureInputBar()
    }
    
    

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //if(indexPath.section == 1)
        //{
            if editingStyle == .Delete {
                
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            } else if editingStyle == .Insert {
                
            }
       // }
      
    }
    
    
    func showParticiptors(sender:AnyObject){
        performSegueWithIdentifier("toParticipator", sender: sender)
    }

    
    func assignTask(sender:AnyObject){
        //self.navigationController?.pushViewController(DecomposeTaskTableViewController.getInstance(), animated: true)
        self.subTask = nil
        
        var vc = DecomposeTaskTableViewController.getInstance()
        vc.parentTaskId = task.id
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)

       // performSegueWithIdentifier("deriveSubTask", sender: sender)
    }
    
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if(indexPath.section == 0){
            
            
            let cell:SimpleLabelTableViewCell = tableView.dequeueReusableCellWithIdentifier("projectNameIndentifier", forIndexPath: indexPath) as! SimpleLabelTableViewCell
            
            cell.setTitile(task.title)
            
            return cell
        }
        else if(indexPath.section == 1){
            
            if(indexPath.row == 0){
                var pTaskTitle = "根项目"
                if !task.pId!.isEmpty && task.pId != NULL {
                   
                    
                   let tempTask =  TreeNodeHelper.sharedInstance.findNodeById(rootTask, id: task.pId!)
                    
                    if tempTask == nil {
                        pTaskTitle = task.pId!
                    }
                    else {
                        pTaskTitle = (tempTask as! TaskModel).title
                    }
                }
                
                let cell = tableView.dequeueReusableCellWithIdentifier("nameValueIdentifer", forIndexPath: indexPath) as! NameValueTableViewCell
                

                
                cell.configureCell("属于项目", value: pTaskTitle)

                return cell
            }
            else if(indexPath.row == 1){
                let cell = tableView.dequeueReusableCellWithIdentifier("nameValueIdentifer", forIndexPath: indexPath) as! NameValueTableViewCell
                
                cell.configureCell("截止时间", value: task.deadline)
                
                return cell
            }
            else if(indexPath.row == 2){
                
                let cell = tableView.dequeueReusableCellWithIdentifier("nameValueIdentifer", forIndexPath: indexPath) as! NameValueTableViewCell
                
                cell.configureCell("查看进度", value: "")
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                cell.setCellType(NAME_VALUE_CELL_TYPE.Status)
                return cell
                            }
            else if(indexPath.row == 3){
                
                let cell = tableView.dequeueReusableCellWithIdentifier("nameValueIdentifer", forIndexPath: indexPath) as! NameValueTableViewCell
                //
                cell.configureCell("合作伙伴", value: task.assignees![0].name)
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                cell.setCellType(NAME_VALUE_CELL_TYPE.Participator)
                return cell

            }
           
         
        }
        else if(indexPath.section == SECTION_ID_SUBTASK){
            
            if  task.children.count > 0
            {
                
                

                
                let subTask:TaskModel
                    
                let tempTask =  TreeNodeHelper.sharedInstance.findNodeById(rootTask, id: (task.children[indexPath.row] as! TaskModel).id)
                
                
                if tempTask == nil
                {
                    subTask = task.children[indexPath.row] as! TaskModel
                }
                else{
                    subTask = tempTask as! TaskModel
                }
                let cell = tableView.dequeueReusableCellWithIdentifier("nameValueIdentifer", forIndexPath: indexPath) as! NameValueTableViewCell
                
                
                
                
                var assigneeName = subTask.assignees.first?.name
                if assigneeName == nil || assigneeName!.isEmpty {
                    assigneeName = "未指派"
                    cell.setNameRed()
                }
                else{
                    cell.setNameColor()
                }
                cell.configureCell(assigneeName, value:subTask.title)
                
               
                
                return cell

            }
            else {
                let cell = tableView.dequeueReusableCellWithIdentifier("nameValueIdentifer", forIndexPath: indexPath) as! NameValueTableViewCell
                
                cell.configureCell("小任务", value: "无")
                
                return cell
            }
            
            

        }
        else if(indexPath.section == SECTION_ID_FEED){
            
            let cell = tableView.dequeueReusableCellWithIdentifier("replyIdentifier", forIndexPath: indexPath) as! ReplyTableViewCell
            cell.configureCell(task.reply![indexPath.row],action: reply)
            
            
            return cell
            
        }

        
        let cell = tableView.dequeueReusableCellWithIdentifier("projectNameIndentifier", forIndexPath: indexPath)
            
        return cell

        
      
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        if( indexPath.section == SECTION_ID_FEED){
            
            if let reply = task.reply{
                if indexPath.row < reply.count {
                    var comment = reply[indexPath.row] as! ReplyModel
                    let height = ReplyTableViewCell.getCellHeight(comment)
                    
                    print("replyCell height:\(height)")
                    
                    return height
                }
                
                
            }
            return 180
        }
    
        
        return 44
       
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == SECTION_ID_SUBTASK){
            
            if task.children.count > 0{
                subTask = task.children[indexPath.row] as! TaskModel
                
//                if UserModel.sharedInstance.belongTo(compareTo: subTask!.assignees) == true {
 //                   print("this task belongs to mind")
                    var taskDetail = TaskDetailTableViewController.instance
                    taskDetail.task = subTask!
                    self.navigationController?.pushViewController(taskDetail, animated: true)
                    
                    return
//                }
//                else{
//                    
//                    performSegueWithIdentifier("deriveSubTask", sender: nil)
//                }
             
           
            }
            else {
                print("no subTask has been derived")
            }
            
        }
        else if(indexPath.section == SECTION_ID_BASE){
            var cell = tableView.cellForRowAtIndexPath(indexPath) as! NameValueTableViewCell
            if cell.cellType == NAME_VALUE_CELL_TYPE.Participator
            {
                 performSegueWithIdentifier("toParticipator", sender: self)
            }
            else if cell.cellType == NAME_VALUE_CELL_TYPE.Status{
                self.navigationController?.pushViewController(TaskStatusTableViewController(), animated: true)
            }
            
        }
    }

  

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "deriveSubTask"){
         
            var vc = segue.destinationViewController as! DecomposeTaskTableViewController
            vc.delegate = self
            if let workingTask = subTask{
                vc.task = workingTask
            }
           
        }
        else if (segue.identifier == "toParticipator"){
            var vc = segue.destinationViewController as! EmployeeTableViewController
            vc.interactionEnable = false
            vc.assignees = task.assignees
            
        }
        
    }
    
    func configureInputBar() {
        let rightButton = UIButton(frame: CGRectMake(0, 0, 44, 44))
        rightButton.setTitle("发表", forState: UIControlState.Normal)
        rightButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        rightButton.addTarget(self, action: Selector("sendComment:"), forControlEvents: UIControlEvents.TouchUpInside)
        keyboardObserver.userInteractionEnabled = false
        textInputBar.showTextViewBorder = true
        textInputBar.rightView = rightButton
        textInputBar.textView.placeholder = "请输入说说!"
        // textInputBar.frame = CGRectMake(0, SCREEN_HEIGHT - textInputBar.defaultHeight - 50, SCREEN_WIDTH, textInputBar.defaultHeight)
        textInputBar.frame = CGRectMake(0, SCREEN_HEIGHT - textInputBar.defaultHeight - 50, SCREEN_WIDTH, textInputBar.defaultHeight)
        textInputBar.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textInputBar.keyboardObserver = keyboardObserver
        view.addSubview(textInputBar)
        
        //textInputBar.becomeFirstResponder()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardFrameChanged:", name: ALKeyboardFrameDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
   

}

extension TaskDetailTableViewController:DeriveSubTask{
    func deriveSubTask(backedTask: TaskModel) {
        
       
       
        //backedTask.parentTask = self.task.id

        var isOldTask = false
        var index = -1;
  
            for task in self.task.children {
                index++
                if task.id == backedTask.id
                {
                    isOldTask = true
                    
                    break;
                }
            }
        
        
        if(isOldTask == true){
           task.removeSubTaskAt(index)
           task.addSubTask(backedTask,index: index)
            
            print("deriveSubTask->old title: \(backedTask.title), deadline: \(backedTask.deadline), assignee: \(backedTask.assignees.first?.name)")
        }
        else{
            self.task.addSubTask(backedTask)
            TaskDBManager.sharedInstance.updateTask(task.id, subTasks: task.children as! [TaskModel])
              print("deriveSubTask->new title: \(backedTask.title), deadline: \(backedTask.deadline), assignee: \(backedTask.assignees.first?.name)")
        }
        
        
        
        
        self.tableView.reloadData()
    }
    
    
}

extension TaskDetailTableViewController {
    // This is how we observe the keyboard position
    override var inputAccessoryView: UIView? {
        get {
            return keyboardObserver
        }
    }
    
    // This is also required
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
 
    
    func sendComment(sender: UIButton) {
        
        // comments.append(textInputBar.textView.text)
        textInputBar.textView.text = nil
        textInputBar.textView.textViewDidChange()
        textInputBar.textView.resignFirstResponder()
        textInputBar.removeFromSuperview()
        // tableView.reloadData()
    }
    
    func keyboardFrameChanged(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            textInputBar.frame.origin.y = frame.origin.y
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            textInputBar.frame.origin.y = frame.origin.y
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            textInputBar.frame.origin.y = frame.origin.y
        }
    }
    
    func reply(text:String,to:String){
        configureInputBar()
    }
}

