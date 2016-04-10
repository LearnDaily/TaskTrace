//
//  UIColor+Extension.swift
//  iBreast
//
//  Created by YUYE on 15/12/22.
//  Copyright © 2015年 YUYE. All rights reserved.
//

import UIKit

extension UIColor{
    
    convenience  init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0){
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    convenience  init(hex:Int, alpha: CGFloat = 1.0){
        let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
        let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
        let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.stringByReplacingOccurrencesOfString("0x", withString: "")
        formatted = formatted.stringByReplacingOccurrencesOfString("#", withString: "")
        if let hex = Int(formatted, radix: 16) {
            self.init(hex: hex, alpha: alpha)
        } else {
            return nil
        }
    }
    
    

    class func Gray(gray: CGFloat) -> UIColor {
        return UIColor(r: gray, g: gray, b: gray)
    }
    

    class func Gray(gray: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(r: gray, g: gray, b: gray, a: alpha)
    }
    

    var redComponent: Int {
        var r: CGFloat = 0
        getRed(&r, green: nil, blue: nil, alpha: nil)
        return Int(r * 255)
    }
    

    var greenComponent: Int {
        var g: CGFloat = 0
        getRed(nil, green: &g, blue: nil, alpha: nil)
        return Int(g * 255)
    }
    
    var blueComponent: Int {
        var b: CGFloat = 0
        getRed(nil, green: nil, blue: &b, alpha: nil)
        return Int(b * 255)
    }
    
    var alpha: Int {
        var a: CGFloat = 0
        getRed(nil, green: nil, blue: nil, alpha: &a)
        return Int(a)
    }
}
