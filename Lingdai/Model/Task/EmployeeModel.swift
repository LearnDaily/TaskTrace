//
//  EmployeeModel.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/13.
//
//

import UIKit

enum EmployeeType:Int {
    
    case Individual = 0
    case Team = 1
}

class EmployeeModel: NSObject {

    public var type:EmployeeType = .Individual
    //系统编号
    var id:String!
    //工号
    var number:String = ""
    //名称
    var name:String = "Jone"
    //电话号码
    var phoneNumber:String = "null"
    
    override init() {
        super.init()
        id =  "\(NSDate().timeIntervalSince1970)"
        phoneNumber = id
         number = id
        
    }
    
    convenience init(phoneNumber:String,name:String) {
        self.init()
        self.name = name
        self.phoneNumber = phoneNumber
    }
    
    
    convenience init(json:JSON){
        self.init()
        
        id = json["id"].stringValue
        phoneNumber = json["phoneNumber"].stringValue
        number = json["number"].stringValue
        name = json["name"].stringValue
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        id = aDecoder.decodeObjectForKey("id") as! String
        number = aDecoder.decodeObjectForKey("number") as! String
        name =  aDecoder.decodeObjectForKey("name") as! String
        type = EmployeeType(rawValue: aDecoder.decodeIntegerForKey("type"))!
        phoneNumber = aDecoder.decodeObjectForKey("phoneNumber") as! String
    }
    
   func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(id, forKey: "id")
        aCoder.encodeObject(number, forKey: "number")
        aCoder.encodeInteger(type.rawValue, forKey: "type")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(phoneNumber,forKey: "phoneNumber")
        
    }
    
    

    
    func appendPhoneNumber(phoneNumber:String){
        
        self.phoneNumber = phoneNumber
        
//        if phoneNumber.isEmpty{
//            return
//        }
//        
//        if phoneNumbers == nil {
//            phoneNumbers = [String]()
//            
//        }
//        phoneNumbers?.append(phoneNumber)
    }
    
    func getJson() ->[String:AnyObject]{
        var parameter = [String:AnyObject]()
        parameter["id"] = self.id
        parameter["name"] = self.name
        parameter["number"] = self.number
        parameter["phoneNumber"] = self.number
        return parameter
    }

    
    func isEqual(compareTo employee:EmployeeModel) -> Bool {
        //如果编号或者电话号码，我们认为是同一个人
        if employee.id == self.id || employee.phoneNumber == self.phoneNumber {
            return true
        }
        else{
            return false
        }
    }
    
    func contains(compareTo others:[EmployeeModel],employee:EmployeeModel) ->Bool{
        
        for other in others {
            if other.isEqual(compareTo: employee){
                return true
            }
        }
        return false
        
    }
    
    func belongTo(compareTo others:[EmployeeModel]) ->Bool{
        
        for other in others {
            if other.isEqual(compareTo: self){
                return true
            }
        }
        return false
        
    }
    
    
    
    
}
