//
//  NewContactTableViewCell.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/5/6.
//
//

import UIKit


typealias InviteContactClosure = (contact:ContactModel,cell:NewContactTableViewCell)->Bool

class NewContactTableViewCell: UITableViewCell {
 
    
    @IBOutlet weak var inviteBtn: BaseButton!
    var closure:InviteContactClosure!
    
    var contactModel:ContactModel!{
        didSet{
            //self.contactAvatar.image = contactModel.avatarUrl
            self.contactName.text = contactModel.name
            self.contactPhone.text = contactModel.phoneNumber
            if contactModel.isStrange {
                inviteBtn.hidden = false
            }
            else{
                  inviteBtn.hidden = true
            }
        }
    }
    
    var isStrange:Bool!{
        didSet{
            if isStrange == true {
                inviteBtn.hidden = false
            }
            else{
                inviteBtn.hidden = true
            }
        }
    }
    
       
    @IBOutlet weak var contactName: UILabel!
    
    @IBOutlet weak var contactAvatar: BaseImageView!

    @IBOutlet weak var contactPhone: UILabel!

    @IBAction func inviteContact(sender: AnyObject) {
        closure(contact: contactModel,cell: self)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func configureContactCell(icon:UIImage,name:String,phone:String){
//        self.contactAvatar.image = icon
//        self.contactName.text = name
//        self.contactPhone.text = phone
//    }
    

}
