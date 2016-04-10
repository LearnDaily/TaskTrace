//
//  BaseButton.swift
//  researchCity
//
//  Created by chaogao on 10/13/14.
//  Copyright (c) 2014 chaogao. All rights reserved.
//

import UIKit

class BaseButton: UIButton {
    
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRound: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRound
        }
    }
}
