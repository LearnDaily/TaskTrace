//
//  RequestApi.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/4/10.
//
//

import UIKit

class RequestApi: NSObject {
    
    static let host = "http://192.168.0.105:8080/OpenMission/servlet"
  
    
    internal class func login(account:String,password:String) -> String {
        
        return "\(host)/LoginServlet?account=\(account)&password=\(password)"
    }

    internal class func signup()->String{
        return "\(host)/SignupServlet"
    }
    
    internal class func getSubtasks(parentTask:String,maxId:Int,count:Int) -> String {
        
        return "\(host)/api/topic/list2/\(maxId)/\(count)"
    }
    
    internal class func addTask()->String{
        return "\(host)/TaskServlet"
    }
    
    internal class func addContacts()->String{
        return "\(host)/ContactServlet"
    }

    internal class func getTasks(start:Int,size:Int)->String{
        
        return "\(host)/SignupServlet/gettask/\(start)/\(size)"
    }
    
    

}
