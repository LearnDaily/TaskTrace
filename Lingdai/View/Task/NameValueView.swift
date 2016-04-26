//
//  NameValueView.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/14.
//
//

import UIKit

class NameValueView: UIView {
    

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    func setNameValue(name:String,value:String){
//        
        nameLabel.text = name
        valueLabel.text = value
    }
    
    func setTextColor(nameColor:UIColor, valueColor:UIColor){
        nameLabel.textColor = nameColor
        valueLabel.textColor = valueColor
    }
    
    func setNameColor(color:UIColor){
        nameLabel.textColor = color
    }
    
    func setValueColor(color:UIColor){
        valueLabel.textColor = color
    }
    
    
    
    

}
