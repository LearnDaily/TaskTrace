//
//  CommonTextFieldTableViewCell.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/4/3.
//
//

import UIKit



class CommonTextFieldTableViewCell: UITableViewCell,UITextFieldDelegate{
   
    
 
    
    @IBOutlet weak var textField: UITextField!
    
    typealias CommonTextFieldCallback =  (text:String,tag:Int) ->Void
    
    var delegate:CommonTextFieldCallback?
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
        textField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
//    func textFieldDidEndEditing(textField: UITextField){
//        
//        delegate?(text: textField.text!,tag: self.contentView.tag)
//    }
    
    func setTextPlaceholder(placeholder:String,type:UIKeyboardType){
        textField.placeholder = placeholder
        textField.keyboardType = type
    }
    
    func textFieldDidChange(sender:AnyObject){
          delegate?(text: textField.text!,tag: self.contentView.tag)
    }
}
