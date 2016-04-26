//
//  TaskDetailViewController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/4/16.
//
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    let textInputBar = ALTextInputBar()
    let keyboardObserver = ALKeyboardObservingView()
    var tableView:BaseTableView!
    var task:TaskModel = TaskModel()
    var subTask:TaskModel?
    
    let SECTION_ID_SUBTASK = 1
    let SECTION_ID_FEED = 2
    let SECTION_ID_BASE = 0
    let SECTION_TASK_STATUS = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "任务详情"
        
        tabBarController?.tabBar.hidden = true
        view.backgroundColor = UIColor(r: 239, g: 239, b: 239)
        
        tableView = BaseTableView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), style: .Grouped)
        tableView.separatorStyle = .SingleLine
        tableView.backgroundColor = UIColor(r: 239, g: 239, b: 239)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        configureInputBar()
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        textInputBar.removeFromSuperview()
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
extension TaskDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    //
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == SECTION_ID_BASE ){
            //项目进度 //合作伙伴
            if let assignees = task.assignees{
                
                if assignees.count > 0{
                    return 3
                }
                
            }
            return 2
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
    
    
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        
        if(section == SECTION_ID_SUBTASK){
            
            return createSubTaskHeader()
        }
        else if(section == SECTION_ID_FEED){
            return createFeedsHeader()
        }
        else{
            return UIView()
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
        //configureInputBar()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
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
        else if(indexPath.section == SECTION_ID_BASE && indexPath.row == 0 ){
            return 88
        }
        
        
        return 44
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //if(indexPath.section == 1)
        //{
        if editingStyle == .Delete {
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            
        }
        // }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        //        if(indexPath.section == 0){
        //
        //
        //            let cell:SimpleLabelTableViewCell = tableView.dequeueReusableCellWithIdentifier("projectNameIndentifier", forIndexPath: indexPath) as! SimpleLabelTableViewCell
        //
        //            cell.setTitile(task.title)
        //
        //            return cell
        //        }
        //        else
        if(indexPath.section == SECTION_ID_BASE){
            
            if(indexPath.row == 0){
                //                var pTaskTitle = "根项目"
                //                if !task.pId!.isEmpty && task.pId != NULL {
                //
                //
                //                   let tempTask =  TreeNodeHelper.sharedInstance.findNodeById(rootTask, id: task.pId!)
                //
                //                    if tempTask == nil {
                //                        pTaskTitle = task.pId!
                //                    }
                //                    else {
                //                        pTaskTitle = (tempTask as! TaskModel).title
                //                    }
                //                }
                //
                //                let cell = tableView.dequeueReusableCellWithIdentifier("nameValueIdentifer", forIndexPath: indexPath) as! NameValueTableViewCell
                //
                //
                //
                //                cell.configureCell("属于项目", value: pTaskTitle)
                //
                //                return cell
                
                var model = TaskBriefModel()
                model.deadline = "2016-10-20"
                model.parentTask = "Root"
                model.title = "do do do"
                var cell = TaskBriefTableViewCell.getTaskBriefTableViewCell(tableView)
                
                cell.setData(model)
                
                return cell
            }
                //            else if(indexPath.row == 1){
                //                let cell = tableView.dequeueReusableCellWithIdentifier("nameValueIdentifer", forIndexPath: indexPath) as! NameValueTableViewCell
                //
                //                cell.configureCell("截止时间", value: task.deadline)
                //
                //                return cell
                //            }
            else if(indexPath.row == 1){
                
                //                let cell = tableView.dequeueReusableCellWithIdentifier("nameValueIdentifer", forIndexPath: indexPath) as! NameValueTableViewCell
                
                let cell = NameValueTableViewCell.getNameValueCell(tableView)
                cell.configureCell("查看进度", value: "")
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                cell.setCellType(NAME_VALUE_CELL_TYPE.Status)
                cell.setLightColor()
                return cell
            }
                
            else if(indexPath.row == 2){
                
                //                let cell = tableView.dequeueReusableCellWithIdentifier("nameValueIdentifer", forIndexPath: indexPath) as! NameValueTableViewCell
                
                let cell = NameValueTableViewCell.getNameValueCell(tableView)
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
                //                let cell = tableView.dequeueReusableCellWithIdentifier("nameValueIdentifer", forIndexPath: indexPath) as! NameValueTableViewCell
                
                let cell = NameValueTableViewCell.getNameValueCell(tableView)
                
                cell.configureCell("小任务", value: "无")
                
                return cell
            }
            
            
            
        }
        else if(indexPath.section == SECTION_ID_FEED){
            
            let cell = tableView.dequeueReusableCellWithIdentifier("replyIdentifier", forIndexPath: indexPath) as! ReplyTableViewCell
            // cell.configureCell(task.reply![indexPath.row],action: reply)
            
            
            return cell
            
        }
        
        
        //        let cell = tableView.dequeueReusableCellWithIdentifier("projectNameIndentifier", forIndexPath: indexPath)
        
        let cell = NameValueTableViewCell.getNameValueCell(tableView)
        
        return cell
        
        
        
    }
}
extension TaskDetailViewController{
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
        
        // textInputBar.becomeFirstResponder()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardFrameChanged:", name: ALKeyboardFrameDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
}
