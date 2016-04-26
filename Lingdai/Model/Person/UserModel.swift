//
//  UserModel.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/29.
//
//

import UIKit

class UserModel: ContactModel {
    

    static var visitorAccount = NULL
    static var visitorPassword = NULL
    
    override init() {
        super.init()
        
        self.id = KeychainWrapper.stringForKey(USER_ACCOUNT)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   class var userAccount:String{
        get{
            if KeychainWrapper.stringForKey(USER_ACCOUNT) != nil {
                return KeychainWrapper.stringForKey(USER_ACCOUNT)!
            }
            else{
                return NULL
            }
        }
    }
    
   class var userPassword:String{
        get{
            if KeychainWrapper.stringForKey(USER_PASSWORD) != nil {
                return KeychainWrapper.stringForKey(USER_PASSWORD)!
            }
            else{
                return NULL
            }
        }
    }
    
    class func setAccount(account:String?) ->Bool{
        if account == NULL {
            return false
        }
        return KeychainWrapper.setString(account!, forKey: USER_ACCOUNT)
    }
    
    class func setPassword(password:String?) ->Bool{
        if password == NULL {
            return false
        }
        return KeychainWrapper.setString(password!, forKey: USER_PASSWORD)
    }
    
    class func saveUser(){
        setAccount(visitorAccount)
        setPassword(visitorPassword)
    }
    
    class func setUserAsVisitor(account:String?,password:String?){
        if let acc = account{
             visitorAccount = acc
        }
        else{
            return
        }
        
        if let psw = password{
            visitorPassword = psw
        }
        
    }
    

    
    // 单例模式
    class var sharedInstance: UserModel {
        struct Static {
            static var instance: UserModel?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Static.token) { // 该函数意味着代码仅会被运行一次，而且此运行是线程同步
            Static.instance = UserModel()
        }
        return Static.instance!
    }
    class var isLogin:Bool{
        get{
            if UserModel.userAccount == NULL || UserModel.userPassword == NULL {
                NSNotificationCenter.defaultCenter().postNotificationName(GO_TO_LOGIN, object: 1)
                
                return false
            }
            return true
        }
    }
    

    
    
}
