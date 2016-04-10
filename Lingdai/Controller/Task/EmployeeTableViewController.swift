//
//  ColleagueTableViewController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/12.
//
//

import UIKit


protocol AssignTask {
    func assignTo(assignees:[EmployeeModel]?);
}

class EmployeeTableViewController: UITableViewController {
    
    
    var delegate:AssignTask?
    var contactsDBManager = ContactsDBManager.instance
    let COLLEAGUE_IDENTIFIER = "Employee"
    var interactionEnable = true
    var employees:[EmployeeModel]!
    var assignees:[EmployeeModel]!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "分配任务"
        
        
        
        if employees == nil {
             employees = [EmployeeModel]()
        }
        
        if assignees == nil {
            assignees = [EmployeeModel]()
        }
        
        setupData()
        
        loadEmployees()
        
        updateUI()
       
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        delegate?.assignTo(assignees)
        
    }
    
    func updateUI(){
       
        self.tableView.tableFooterView?.hidden = !employees.isEmpty
  
        
    }
    
    
    func loadEmployees(){
        contactsDBManager.findAll(
            {
                (contacts) -> Void in
                
                if self.employees.count > 0{
                    var newContacts = [EmployeeModel]()
                    
                    
                    for e in self.employees {
                        
                        var find = false
                        
                        for contact in contacts{
                            if e.id == contact.id{
                                find = true
                                break;
                            }
                        }
                        if(find == false){
                            newContacts.append(e)
                        }
                        
                    }
                    
                    
                    for contact in newContacts {
                        self.employees.append(contact)
                    }
                    

                }
                else{
                    
                    for contact in contacts {
                        self.employees.append(contact)
                    }

                }
                
                
             
            }
        )
    }
    

    
    func setupData(){
        
//        if(interactionEnable == false){
//            for assignee in assignees{
//                 employees.append(assignee)
//            }
//          
//
//        }
//        else{
//            employees.append(EmployeeModel(number: "111", name: "黎明"))
//            employees.append(EmployeeModel(number: "222", name: "张学友"))
//            employees.append(EmployeeModel(number: "333", name: "刘德华"))
//            employees.append(EmployeeModel(number: "333", name: "王菲"))
//        }
        
       
   
    }
    
    @IBAction func addEmployees(sender: AnyObject) {
        
        
        if #available(iOS 9.0, *) {
            var vc = ContactTableViewController.getInstance()
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
        }
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if interactionEnable == false
        {
            return
        }
        
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! EmployeeTableViewCell
        
        if(cell.isChecked == false){
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            var exists = false
            for assignee in assignees {
                if assignee.number == cell.employee.number {
                    
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

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return employees.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(COLLEAGUE_IDENTIFIER, forIndexPath: indexPath) as! EmployeeTableViewCell

        print("employee: \(employees[indexPath.row].name)")
        cell.configureCell(employees[indexPath.row])
       // cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        for assignee in assignees {
            if assignee.number == employees[indexPath.row].number {
                cell.isChecked = true
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                break;
            }
        }
        
       
        //cell.configureName("aaa")

        return cell
    }
    
  
}

extension EmployeeTableViewController:ContactDectector{
    func onAdd(contacts: [EmployeeModel]?) {
        
        if let backedContacts = contacts{
            for employee in backedContacts {
                employees.append(employee)
                print("assignee: \(employee.name)")
            }
            interactionEnable = true
            setupData()
            updateUI()
            self.tableView.reloadData()
        }
        
    }
}

