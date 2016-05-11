//
//  ColleagueTableViewController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/12.
//
//

import UIKit
import Alamofire

protocol AssignTask {
    func assignTo(assignees:[EmployeeModel]?);
}

class EmployeeTableViewController: UITableViewController {
    
    
    var delegate:AssignTask?
    var contactsDBManager = ContactsDBManager.instance
    let COLLEAGUE_IDENTIFIER = "Employee"
    var interactionEnable = true
    var employees:[ContactModel]!
    var assignees:[EmployeeModel]!
    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "分配任务"
        
        
        
        if employees == nil {
             employees = [ContactModel]()
        }
        
        if assignees == nil {
            assignees = [EmployeeModel]()
        }
        
   
        
        
      
        
        updateUI()
       
    }
    
    override func viewWillAppear(animated: Bool) {
        loadEmployees()
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        delegate?.assignTo(assignees)
        
    }
    
    func updateUI(){
       
        self.tableView.tableFooterView?.hidden = !employees.isEmpty
  
        
    }
    
    
    func loadEmployees(){
     
        weak var weakSelf = self
        var parameter = [String:AnyObject]();
        parameter["Operation"] = "GetContact"
        parameter["start"] = 0;
        parameter["size"] = 20
        
//        if isLoading == true{
//            return
//        }

//        isLoading = true
//        Alamofire.request(Router.GetContacts(parameter)) .responseJSON { response in
//            
//            weakSelf?.isLoading = false
//            
//            
//            
//        }

        contactsDBManager.findAll(
        {
                (contacts) -> Void in
                weakSelf?.employees.removeAll()
//                if self.employees.count > 0{
//                    var newContacts = [ContactModel]()
//                    
//                    
//                    for e in self.employees {
//                        
//                        var find = false
//                        
//                        for contact in contacts{
//                            if e.isEqual(compareTo: contact){
//                                find = true
//                                break;
//                            }
//                        }
//                        if(find == false){
//                            newContacts.append(e)
//                        }
//                        
//                    }
//                    
//                    
//                    for contact in newContacts {
//                        self.employees.append(contact)
//                    }
//                    
//
//                }
//                else
//                {
            
                    for contact in contacts {
                        self.employees.append(contact)
                    }

//                 }
                
                weakSelf?.tableView.reloadData()
             
            }
        )
    }
    

    @IBAction func inviteContacts(sender: AnyObject) {
        
        addEmployees(sender)
    }
    

    
    @IBAction func addEmployees(sender: AnyObject) {
        

            var vc = ContactTableViewController.getInstance()
            vc.friends = self.employees
            self.navigationController?.pushViewController(vc, animated: true)

        
    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0{
                addEmployees(self)
            }
            else if indexPath.row == 1{
                 self.navigationController?.pushViewController(InviteFriednViewController.instance, animated: true)
            }
            
            
        }
        else if indexPath.section == 1{
            
            
            var cell = tableView.cellForRowAtIndexPath(indexPath) as! EmployeeTableViewCell
            
            if(cell.isChecked == false){
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                var exists = false
                for assignee in assignees {
                    if assignee.isEqual(compareTo: cell.employee) {
                        
                        exists = true
                        break;
                    }
                }
                if(exists == false){
                    assignees.append(cell.employee)
                }
                
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryType.None
                
                var index = -1
                for assignee in assignees{
                    index++
                    if assignee.number == cell.employee.number{
                        break;
                    }
                }
                if index != -1
                {
                    assignees.removeAtIndex(index)
                    
                }
                
                
            }
            
            cell.isChecked = !cell.isChecked
        }
       
        
      
        
        
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        
        return employees.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var viewCell = tableView.dequeueReusableCellWithIdentifier("EmployeeTableViewCell")
        
        if indexPath.section == 0
        {
            let contactCell:ContactTableViewCell = tableView.dequeueReusableCellWithIdentifier("contactTableCellIdentifier", forIndexPath: indexPath) as! ContactTableViewCell
            
            if indexPath.row == 0 {
                contactCell.configureContactCell(UIImage(named: "contact")!, content: "通讯录好友")
                contactCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                return contactCell
            }
            else if indexPath.row == 1{
                contactCell.configureContactCell(UIImage(named: "inviteFriend")!, content: "增加好友")
                contactCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                return contactCell
            }
            
            
        }
        else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCellWithIdentifier(COLLEAGUE_IDENTIFIER, forIndexPath: indexPath) as! EmployeeTableViewCell
            
            print("employee: \(employees[indexPath.row].name)")
            cell.configureCell(employees[indexPath.row])
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            for assignee in assignees {
                if( assignee.isEqual(compareTo:employees[indexPath.row]))
                {
                    cell.isChecked = true
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                    break;
                }
                else{
                    cell.isChecked = false
                    cell.accessoryType = UITableViewCellAccessoryType.None
                    break;
                }
            }
            return cell
        }
        
        return viewCell!
    }
    
  
}

//extension EmployeeTableViewController:ContactDectector{
//    func onAdd(contacts: [EmployeeModel]?) {
//        
//        if let backedContacts = contacts{
//            for employee in backedContacts {
//                employees.append(employee)
//                print("assignee: \(employee.name)")
//            }
//            interactionEnable = true
//           
//            updateUI()
//            self.tableView.reloadData()
//        }
//        
//    }
//}

