//
//  SimpleLabelTableViewCell.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/28.
//
//

import UIKit

class SimpleLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTitile(title:String){
        titleLabel.text = title
    }

}
