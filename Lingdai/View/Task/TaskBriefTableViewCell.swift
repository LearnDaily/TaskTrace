//
//  TaskBriefTableViewCell.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/4/13.
//
//

import UIKit

class TaskBriefTableViewCell: UITableViewCell {

    
    var briefView :TaskBriefTableViewCellView!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        briefView =   UINib(nibName: "TaskBriefTableViewCell", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! TaskBriefTableViewCellView
        
        briefView.frame = CGRectMake(0, 0, self.width, 44)
       
        self.contentView.addSubview(briefView)
        
    
    }
//
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
      
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }
    
    static var identifier = "TaskBriefTableViewCell"
    
    class func getTaskBriefTableViewCell(tableView:UITableView) ->TaskBriefTableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? TaskBriefTableViewCell
        if cell == nil {
            cell = TaskBriefTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
        
        return cell!
    }
    
    func setData(model:TaskBriefModel){
        briefView.model = model
    }

    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
