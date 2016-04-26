//
//  NameValueTableViewCell.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/14.
//
//

import UIKit

enum NAME_VALUE_CELL_TYPE:Int {
    case Base = -1
    case Participator = 0
    case ParentTask = 1
    case Status = 2
}


class NameValueTableViewCell: UITableViewCell {
    
    var nameValueView:NameValueView!
    
    var CELL_TYPE:NAME_VALUE_CELL_TYPE = .Base
    
 
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameValueView =   UINib(nibName: "NameValueView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! NameValueView
        
        nameValueView.frame = CGRectMake(0, 0, self.width, 44)
        
        self.contentView.addSubview(nameValueView)
    }

    required init?(coder aDecoder: NSCoder) {
        
        //fatalError("init(coder:) hs not been implemented")
        super.init(coder: aDecoder)
    }
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(name:String?,value:String?){
        nameValueView.setNameValue(name!, value: value!)
       
    }
    
    func setLightColor(){
      
        
        nameValueView.setTextColor(themeTextColor, valueColor: themeTextColor)
    }
    
    func setColors(nameColor:UIColor?,valueColor:UIColor?){
        if(nameColor != nil){
            nameValueView.setNameColor(nameColor!)
        }
        if(valueColor != nil){
            nameValueView.setValueColor(valueColor!)
        }
        
    }
    
    func setCellType(type:NAME_VALUE_CELL_TYPE){
        self.CELL_TYPE = type
    }
    
    var cellType:NAME_VALUE_CELL_TYPE{
        get{
            return CELL_TYPE
        }
    }
//    
    func setNameColor(){
       nameValueView.setNameColor(defaultColor)
    }
    
    func setNameRed(){
        nameValueView.setValueColor(UIColor.redColor())
    }
    
    static var identifier = "NameValueTableViewCell"
    
    class func getNameValueCell(tableView:UITableView) ->NameValueTableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? NameValueTableViewCell
        if cell == nil {
            cell = NameValueTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
        
        return cell!
    }
}
