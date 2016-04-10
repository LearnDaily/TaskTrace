//
//  ContactTableViewCell.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/18.
//
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    
    @IBOutlet weak var iconImageView: BaseImageView!
    
    
    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureContactCell(icon:UIImage,content:String){
        self.iconImageView.image = icon
        self.contentLabel.text = content
    }
    

}
