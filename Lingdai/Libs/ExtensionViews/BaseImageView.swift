//
//  BaseImageView.swift
//  researchCity
//
//  Created by chaogao on 10/13/14.
//  Copyright (c) 2014 chaogao. All rights reserved.
//

import UIKit

class BaseImageView: UIImageView {
    
    @IBInspectable var cornerRound: CGFloat = 5 {
        didSet {
            layer.cornerRadius = cornerRound
            layer.masksToBounds = true
        }
    }

}
