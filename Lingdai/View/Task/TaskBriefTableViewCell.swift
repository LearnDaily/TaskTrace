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
        self.selectionStyle = .None
    
    }
    
    static func getCellHeight(model:TaskBriefModel)->CGFloat{
        
        let attribute = [NSFontAttributeName:UIFont.systemFontOfSize(14)]
        let option:NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let title: NSString = NSString(CString: model.title!.cStringUsingEncoding(NSUTF8StringEncoding)!,encoding: NSUTF8StringEncoding)!
        let titleFrame:CGRect = title.boundingRectWithSize(CGSizeMake(SCREEN_WIDTH-20, 3000), options: option, attributes: attribute, context: nil)

        return titleFrame.size.height + 70;
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
    
    func setData(model:TaskBriefModel,closure:CheckStatusClosure){
        briefView.model = model
        briefView.closure = closure
    }

    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
