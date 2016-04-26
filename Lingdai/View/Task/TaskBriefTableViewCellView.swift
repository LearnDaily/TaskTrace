//
//  TaskBriefTableViewCellView.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/4/13.
//
//

import UIKit

class TaskBriefTableViewCellView: UIView {
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var parentTaskLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDeadline: UILabel!
    @IBOutlet weak var parentTask: UILabel!
    var model: TaskBriefModel? {
        
        didSet{
            taskTitle.text = model?.title
            parentTask.text = model?.parentTask
            taskDeadline.text = model?.deadline
        }
    }
    
   
    
  
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    

}
