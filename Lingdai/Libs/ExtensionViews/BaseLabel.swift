//
//  BaseLabel.swift
//  researchCity
//
//  Created by chaogao on 10/13/14.
//  Copyright (c) 2014 chaogao. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {
    
    @IBInspectable var cornerRound: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRound
            layer.masksToBounds = true
        }
    }

}
