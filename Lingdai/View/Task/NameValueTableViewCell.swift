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
    
    
    var CELL_TYPE:NAME_VALUE_CELL_TYPE = .Base
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var valueLabel: UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        self.nameLabel.text = name
        self.valueLabel.text = value
    }
    
    func setColors(nameColor:UIColor?,valueColor:UIColor?){
        if(nameColor != nil){
            nameLabel.textColor = nameColor
        }
        if(valueColor != nil){
            valueLabel.textColor = valueColor!
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
    
    func setNameColor(){
        nameLabel.textColor = defaultColor
    }
    
    func setNameRed(){
        nameLabel.textColor = UIColor.redColor()
    }
    
}
