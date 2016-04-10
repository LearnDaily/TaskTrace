//
//  TeamModel.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/18.
//
//

import UIKit

class TeamModel: EmployeeModel {

    var admin:EmployeeModel!
    var adminPhone:String?
    var adminEmail:String?
    var buildTime:String!
    var members:[EmployeeModel]?
    
    override init() {
        super.init()
        self.type = .Team
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class TeamAttribute{
        
    }
    
}
