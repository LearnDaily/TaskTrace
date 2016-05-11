//
//  String+Extension.swift
//  iBreast
//
//  Created by YUYE on 15/12/24.
//  Copyright © 2015年 YUYE. All rights reserved.
//

import UIKit

extension String {
    public func toInt() -> Int? {
        
        if let num = NSNumberFormatter().numberFromString(self) {
            return num.integerValue
        } else {
            return nil
        }
    }
    
    public func toDouble() -> Double? {
        if let num = NSNumberFormatter().numberFromString(self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    
    public func toFloat() -> Float? {
        if let num = NSNumberFormatter().numberFromString(self) {
            return num.floatValue
        } else {
            return nil
        }
    }
    
    public var length: Int { return self.characters.count }
    
    public var toNSString: NSString { get { return self as NSString } }
    
    ///插入字符串
    public mutating func insertString(aString: String, atIndex loc: Int) -> String {
        if self.isEmpty {
            self = aString
            return aString
        }else {
            let str = NSMutableString(string: self)
            str.insertString(aString, atIndex: loc)
            self = "\(str)"
            return "\(str)"
        }
    }
    
    ///删除指定位置字符串
    public mutating func deleteCharactersInRange(range: NSRange) -> String {
        if self.isEmpty {
            return ""
        }else {
            let str = NSMutableString(string: self)
            str.deleteCharactersInRange(range)
            self = "\(str)"
            return "\(str)"
        }
    }
    
    
    /**
    字符串比较
    - parameter find:          要比较的字符串
    - parameter compareOption: 
        CaseInsensitiveSearch       不区分大小写
        LiteralSearch               区分大小写
        BackwardsSearch             从尾部开始比较
        AnchoredSearch              搜索限制范围的字符串
        NumericSearch               按照字符串里的数字大小比较
        DiacriticInsensitiveSearch  忽略"-"符号比较
        WidthInsensitiveSearch      忽略长度
        ForcedOrderingSearch        忽略不区分大小写比较的选项，并强制返回 NSOrderedAscending 或者 NSOrderedDescending
    */
    public func contains(find: String, compareOption: NSStringCompareOptions = .LiteralSearch) -> Bool {
        NSStringCompareOptions.AnchoredSearch
        return self.rangeOfString(find, options: compareOption) != nil
    }
    
    ///下标获取字符
    public subscript(integerIndex: Int) -> Character {
        let index = startIndex.advancedBy(integerIndex)
        return self[index]
    }
    
    ///下标截取字符串
    public subscript(integerRange: Range<Int>) -> String {
        let start = startIndex.advancedBy(integerRange.startIndex)
        let end = startIndex.advancedBy(integerRange.endIndex)
        let range = start..<end
        return self[range]
    }

    
    /// 首字母大写
    public var capitalizeFirst: String {
        var result = self
        result.replaceRange(startIndex...startIndex, with: String(self[startIndex]).capitalizedString)
        return result
    }

    
    /// 去掉空格和换行
    public mutating func trim() {
        self = self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    //判断是否只有空格和换行
    public mutating func isOnlyEmptySpacesAndNewLineCharacters() -> Bool {
        let newText = self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return newText.isEmpty
    }
    
    public func isNull()->Bool{
        return self.isEmpty || self == NULL
    }
    
    /**
    计算字符串高度
    - parameter width:     字符串显示最大宽度
    - parameter font:      字体
    - parameter maxHeight: 最大高度
    - returns: 字符串高度
    */
    func heightComputation(width:CGFloat,font:UIFont = UIFont.systemFontOfSize(14),maxHeight:CGFloat = 999) -> CGFloat{
        return (self as NSString).boundingRectWithSize(CGSizeMake(width, maxHeight), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName :font], context: nil).size.height
    }


}

//正则判断
extension String {
    ///判断是否手机号码
    func isTelNumber()->Bool{
        let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluateWithObject(self) == true)
            || (regextestcm.evaluateWithObject(self)  == true)
            || (regextestct.evaluateWithObject(self) == true)
            || (regextestcu.evaluateWithObject(self) == true)){
                return true
        }
        else{
            return false
        }
    }
    
    ///判断是否为中英文
    func isChineseOrEnglish() -> Bool {
        
        for(var i = 0; i <  self.length; i++) {
            let a = self.toNSString.characterAtIndex(i)
            if a > 0x4e00 && a < 0x9fff || a >= 0x41 && a <= 0x5a || a >= 0x61 && a <= 0x7a {
                
            } else {
                return false
            }
        }
        return true
    }
    //判断首字母是否为中英文
    
    var isFirstLetterChineseOrEnglish:Bool{
        
        get{
            let a = self.toNSString.characterAtIndex(0)
            if a > 0x4e00 && a < 0x9fff || a >= 0x41 && a <= 0x5a || a >= 0x61 && a <= 0x7a {
                return true
            } else {
                return false
            }

        }
    }
    
    ///验证身份证
    func validateIdentityCard() ->Bool {
        
        let regex = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let identityCardPredicate = NSPredicate(format: "SELF MATCHES %@",regex)
        
        return identityCardPredicate.evaluateWithObject(self)
    }
    
    
    ///验证邮箱
    func validateEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@",regex)
        return emailTest.evaluateWithObject(self)
    }
    
    
    ///验证银行卡
    func validateBankCard() -> Bool {
        let regex = "^([0-9]{16}|[0-9]{19})$"
        let Card = NSPredicate(format: "SELF MATCHES %@",regex)
        return Card.evaluateWithObject(self)
    }
}


extension String {
    ///沙盒路径
    static func documentPath(fileName:String) -> String {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)

        return  (path[0] as NSString).stringByAppendingPathComponent(fileName)
    }
}

