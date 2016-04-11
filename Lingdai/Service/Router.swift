//
//  Router.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/4/10.
//
//

import UIKit
import Alamofire
enum Router :URLRequestConvertible{

  
    
    case Login
    case AddTask
    case AddSubTask
    case FetchTasks(lastId:String,count:Int)
    

    static var token: String?
    
    
    var method: Alamofire.Method {
        switch self {
        case .Login:
            return .POST
        case .FetchTasks:
            return .GET
        default:
            return .GET
        }
        
    }
//
//    
    var path: String {
        switch self {
            case .FetchTasks(let lastId,let count):
                return RequestApi.getTasks(lastId, count: count)
        default:
            return ""
        }
    }
    
    
    var URLRequest: NSMutableURLRequest {
        
        let URL = NSURL(string: path)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = method.rawValue
        
        
        print("mutableURLRequest \(mutableURLRequest)")
        
        return mutableURLRequest
        
//        if let token = Router.token {
//            mutableURLRequest.setValue("\(token)", forHTTPHeaderField: "token")
//        }
//        
//        mutableURLRequest.setValue("com.swiftmi.app", forHTTPHeaderField: "clientid")
//        mutableURLRequest.setValue("1.0", forHTTPHeaderField: "appversion")
        
//        switch self {
////        case .FetchTasks(let lastId,let count):
////            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
////       
//            
//        default:
//            return mutableURLRequest
//        }
    }

}
