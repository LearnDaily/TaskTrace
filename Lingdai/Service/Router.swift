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

  
    
    case Login(account:String,password:String)
    case Signup([String: AnyObject])
    case AddTask([String:AnyObject])
    case GetTasks(start:Int,size:Int)
    case addContacts([String:AnyObject])

    static var token: String?
    
    
    var method: Alamofire.Method {
        switch self {
        case .Login:
            return .GET
        case .GetTasks:
            return .GET
        case .Signup:
            return .POST
        case .AddTask:
            return .POST
        case .addContacts:
            return .POST
        default:
            return .GET
        }
        
    }
//
//    
    var path: String {
        switch self {
            case .GetTasks(let start,let size):
                return RequestApi.getTasks(start, size: size)
            case .Login(let account,let password):
                return RequestApi.login(account,password: password)
            case .Signup(_):
            return RequestApi.signup()
        case .AddTask(_):
            return RequestApi.addTask()
        case .addContacts(_):
            return RequestApi.addContacts()
        default:
            return ""
        }
    }
    
    
    var URLRequest: NSMutableURLRequest {
        
        let URL = NSURL(string: path)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = method.rawValue
        
        
        print("mutableURLRequest \(mutableURLRequest)")
        
       
        
        if let token = Router.token {
            mutableURLRequest.setValue("\(token)", forHTTPHeaderField: "token")
        }
//
        mutableURLRequest.setValue("com.swiftmi.app", forHTTPHeaderField: "clientid")
        mutableURLRequest.setValue("1.0", forHTTPHeaderField: "appversion")
        
        switch self {
            
        case .Signup(let parameters):
             return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        case .AddTask(let parameters):
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        case .addContacts(let parameters):
                return  Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0

        default:
            return mutableURLRequest
        }
    }

}
