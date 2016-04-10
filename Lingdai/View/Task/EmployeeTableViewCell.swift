//
//  EmployeeTableViewCell.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/13.
//
//




import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var isChecked:Bool = false
    var employee:EmployeeModel!
    
 
    
    func configureCell(model:EmployeeModel){
        employee = EmployeeModel()
        employee.number = model.number
        employee.name = model.name
        isChecked = false
        print("name:\(model.name)")
        nameLabel.text = model.name
        
    }
    
    func configureName(name:String){
        nameLabel.text = name
    }
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
