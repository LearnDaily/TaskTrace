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

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func setNameValue(name:String,value:String){
        
        nameLabel.text = name
        valueLabel.text = value
    }
    
    
    

}
