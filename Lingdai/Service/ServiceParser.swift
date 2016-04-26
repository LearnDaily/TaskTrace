//
//  ServiceParser.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/4/18.
//
//

import UIKit

class ServiceParser: NSObject {

    
    class func parseRequestData(value:[String:JSON]) -> ResponseData{
        
        

        var request = ResponseData()
        var result:[String : JSON]! = value["result"]!.dictionaryValue
        request.response = value["response"]!.stringValue
        request.state = result["state"]!.boolValue
        request.code = result["code"]!.intValue
        request.text = result["text"]!.stringValue
        request.data = result["data"]?.dictionaryValue
        
        
        return request
    }
    
    
    
}

class ResponseData {

    
    var response:String!
    var state:Bool!
    var code:Int!
    var text:String!
    var data:[String:JSON]?
    
}
