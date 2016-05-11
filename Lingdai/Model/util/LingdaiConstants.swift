//
//  LingdaiConstants.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/29.
//
//

import UIKit


let GO_TO_LOGIN = "Lingdai.Constants.Login"
let GO_TO_SIGNUP = "Lingdai.Constants.Signup"
let USER_ACCOUNT = "Constants.UserAccount"
let USER_PASSWORD = "Constants.UserPassword"
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
var NULL:String = "NULL"
let themeColor = UIColor(hexString:"#00BDEE")
let themeTextColor = UIColor.colorWithCustom(100, g:100, b: 100)
let RESPONSE_TRING = "response"
let RESPONSE_ERROR = "error"
class LingdaiConstants: NSObject {

}



func getFistLetter(str: String)-> String{
    //转换成可变数据
    var mutableUserAgent = NSMutableString(string: str) as CFMutableString
    //let transform = kCFStringTransformMandarinLatin//NSString(string: "Any-Latin; Latin-ASCII; [:^ASCII:] Remove") as CFString
    //取得带音调拼音
    if CFStringTransform(mutableUserAgent, nil,kCFStringTransformMandarinLatin, false) == true{
        //取得不带音调拼音
        if CFStringTransform(mutableUserAgent,nil,kCFStringTransformStripDiacritics,false) == true{
            
            let str1 = mutableUserAgent as String
            
            let startIndex = str1.startIndex.advancedBy(0) //swift 2.0+
            let endIndex = str1.endIndex.advancedBy(-str1.length+1) //swift 2.0+
            
            var range = Range<String.Index>(start: startIndex,end: endIndex)
            
            
            let s = str1.capitalizedString.substringWithRange(range)
            
            
            return s
        }else{
            return str
        }
    }else{
        return str
    }
}
