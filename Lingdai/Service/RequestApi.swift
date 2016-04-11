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
    
    internal class func getTasks(lastId:String,count:Int) -> String {
        
       // var str = "\(host)/LoginServlet"
        var str = "wwww.baidu.com"
        print(str)
        
        return str

        
        //"\(host)/LoginServlet/\(lastId)/\(count)"
    }

    
    internal class func getSubtasks(parentTask:String,maxId:Int,count:Int) -> String {
        
        return "\(host)/api/topic/list2/\(maxId)/\(count)"
    }

    
    

}
