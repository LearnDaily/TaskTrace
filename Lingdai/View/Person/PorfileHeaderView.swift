//
//  PorfileHeaderView.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/24.
//
//

import UIKit

class ProfileHeaderView: UIView {

    @IBOutlet weak var headerImage: UIImageView!
  
    @IBOutlet weak var userImage: UIImageView!
    
//    override init(frame: CGRect) {
//        super.init(frame:frame)
//        
//        //setupViews()
//        
//    }
    
    func setupViews(){
        userImage.layer.cornerRadius = userImage.frame.size.width/2
        userImage.layer.borderWidth = 3
        userImage.layer.borderColor = UIColor.whiteColor().CGColor
        userImage.layer.shadowRadius = 3;
        userImage.layer.shadowOpacity = 0;
        userImage.layer.masksToBounds = true
        headerImage.contentMode = .ScaleAspectFill
        headerImage.clipsToBounds = true
    }

//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//       // setupViews()
//    }
    
    
}
