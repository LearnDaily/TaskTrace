//
//  ContactModel.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/29.
//
//

import UIKit

class ContactModel: EmployeeModel {

    var avatarUrl:String!
    //是否新朋友
    var isStrange = true
    
    override init() {
        super.init()
    }
    
    convenience init(employee:EmployeeModel) {
        self.init()
        
        self.id = employee.id
        self.name = employee.name
        self.number = employee.number
        self.phoneNumber = employee.phoneNumber
    }
    
    convenience init(id:String) {
        self.init()
        
        self.id = id
        self.name = "自己"

    }
    
    
    

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
