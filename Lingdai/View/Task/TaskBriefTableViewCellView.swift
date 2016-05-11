//
//  TaskBriefTableViewCellView.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/4/13.
//
//

import UIKit

typealias CheckStatusClosure = ()->Void

class TaskBriefTableViewCellView: UIView {
    
//    @IBOutlet weak var taskTitleLabel: UILabel!
//    @IBOutlet weak var parentTaskLabel: UILabel!
//    @IBOutlet weak var deadlineLabel: UILabel!
//    @IBOutlet weak var taskTitle: UILabel!
//    @IBOutlet weak var taskDeadline: UILabel!
//    @IBOutlet weak var parentTask: UILabel!
    
    var closure :CheckStatusClosure!
    
    
    @IBOutlet weak var assignerName: UILabel!
    @IBOutlet weak var postTime: UILabel!
    
    @IBOutlet weak var taskTitle: UILabel!
    
    @IBOutlet weak var deadline: UILabel!
    
    @IBOutlet weak var status: UIButton!
    
    var model: TaskBriefModel? {
        
        didSet{
            taskTitle.text = model?.title
            postTime.text = model?.postTime
            deadline.text = model?.deadline
            assignerName.text = model?.assignerName
        }
    }
    
    override func awakeFromNib() {
        status.addTarget(self, action: "checkStatus:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func checkStatus(sender:AnyObject){
        
        closure()
//         self.navigationController?.pushViewController(TaskStatusTableViewController(), animated: true)
    }
    
   
    
  
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    

}
