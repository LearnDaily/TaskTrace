//
//  ContactTableViewController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/18.
//
//

import UIKit
import ContactsUI
import MessageUI
import Alamofire


class ContactTableViewController: UITableViewController{
    
    // var contacts:[EmployeeModel] = [TeamModel]()
    //var newContacts = [EmployeeModel]()
    var contactsDBManager = ContactsDBManager.instance

    var keys = [String]()
    //用于保存已经排序的联系人
    var sortedContacts = [String:[ContactModel]]()
    //存储已经是好友的联系人，这类联系人不允许重复添加，应该把添加按钮黑掉
    var friends = [ContactModel]()
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "通讯录"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("back:"))
        
        loadContacts()

    }
    
    func loadContacts(){
        
        weak var weakSelf = self
        ProgressHUDManager.showWithStatus("获取通讯录中")
        addressBook.addressBookRequestAccessCallBack({ (addressBook) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if addressBook != nil {
                    let contacts:[NSDictionary] = addressBook as! [NSDictionary]
                    for contact in contacts {
                        var phone = contact.objectForKey("phone")
                        var name = contact.objectForKey("name")
                        var trimName:String = ""
                        var trimPhone:String = ""
                        //如果电话号码为空，这种联系人不需要
                        if phone == nil{
                            
                            continue
                        }
                        if name == nil{
                           
                            continue
                        }
                            
                        trimName = name as! String
                        trimName.trim()
                        
                        if trimName.isEmpty {
                            continue
                        }
                        
                        if trimName.isFirstLetterChineseOrEnglish == false{
                            trimName = "#"
                        }
                       
                        
                        trimPhone = phone as! String
                        trimPhone.trim()
                        
                        if trimPhone.isEmpty {
                            continue
                        }
                        
                        let employee = ContactModel(phoneNumber: trimPhone, name: trimName )
       
                        
                        if let selfFriends = weakSelf?.friends{
                            for friend in selfFriends{
                                if employee.isEqual(compareTo: friend){
                                     employee.isStrange = false
                                }
                            }
                        }

                        employee.appendPhoneNumber(trimPhone)
                        weakSelf?.insertContact(employee)
                        
                      //  weakSelf?.newContacts.append(employee)

                    }
                    weakSelf?.sortKeys()
                    weakSelf?.tableView.reloadData()
                    ProgressHUDManager.dismiss()
                }
                else{
                    
                }
                
            })
            
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        tabBarController?.tabBar.hidden = true
    }
    
    
    func back(sender:AnyObject){

        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func addFriend(contact:ContactModel,cell:NewContactTableViewCell)->Bool{
        var contacts = [EmployeeModel]()
        contacts.append(contact)
        print("invite friend: name->\(contact.name), phone->\(contact.phoneNumber)")
        addFriends(contacts,cell: cell)
      
        return true
    }
    
    
    func addFriends(contacts:[EmployeeModel],cell:NewContactTableViewCell){
        
        weak var weakSelf = self
        var contactDic = [[String:AnyObject]]();
        for contact in contacts {
            contactDic.append(contact.getJson())
        }
        
        print("contacts: \(contacts)")
        
        var parameter = [String:AnyObject]()
        parameter["contacts"] = contactDic
        
        cell.isStrange = false
        weakSelf?.contactsDBManager.addContacts(contacts)
        weakSelf?.tableView.reloadData()
        
        
//        if isLoading == true{
//            return
//        }
//        else{
//            isLoading = true
//        }

        
//        Alamofire.request(Router.addContacts(parameter)) .responseJSON { response in
//            
//            weakSelf?.isLoading = false
//            print("response \(response.result.value)")
//            
//            if response.result.isFailure {
//                let alert = UIAlertView(title: "提醒", message: "网络异常，请检查网络", delegate: nil, cancelButtonTitle: "确定")
//                alert.show()
//                
//                return
//            }
//            else{
//                cell.isStrange = false
//                //把新增加的好友加到数据库
//                weakSelf?.contactsDBManager.addContacts(contacts)
//            }
//        }
//        
        
    }
    
    func setupContacts(){
        weak var weakSelf = self
        contactsDBManager.findAll { (employees) -> Void in
            for employee  in employees{
                weakSelf?.insertContact(ContactModel(employee: employee))
                
            }

            weakSelf?.view.userInteractionEnabled = true
        }
        weakSelf?.sortKeys()
        
    }
    
    class func getInstance()->ContactTableViewController {
        var vc = UIStoryboard(name: "Contacts", bundle: nil).instantiateViewControllerWithIdentifier("ContactTableViewController") as! ContactTableViewController
        
        return vc
    }
    
    // MARK: - Table view data source
    //
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return keys.count
    }
    //
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0
        {
            return 2
        }
        
        return sortedContacts[keys[section]]!.count
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 0 && indexPath.row == 0){
            
        }
        else if indexPath.section == 0 && indexPath.row == 1 {
            self.navigationController?.pushViewController(InviteFriednViewController.instance, animated: true)
        }
    }
    
    
    //设置右边的字母索引
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        
        return keys
    }
    
    
    //设置header的view
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return createSectionLabel("    " + (keys[section] as! String == "新" ? "新增朋友" : keys[section] as! String))
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier("newContactTableViewCell") as? NewContactTableViewCell
        
//        
//        if indexPath.section == 0{
//            let contactCell:ContactTableViewCell = tableView.dequeueReusableCellWithIdentifier("contactTableCellIdentifier", forIndexPath: indexPath) as! ContactTableViewCell
//            
//            if indexPath.row == 0 {
//                contactCell.configureContactCell(UIImage(named: "contact")!, content: "通讯录好友")
//                contactCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
//                return contactCell
//            }
//            else if indexPath.row == 1{
//                contactCell.configureContactCell(UIImage(named: "inviteFriend")!, content: "增加好友")
//                contactCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
//                return contactCell
//            }
//            
//            
//            
//            
//        }
//        else {
        
            if cell == nil {
                cell = NewContactTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "newContactTableViewCell")
            }
           
            cell?.selectionStyle = .None
            cell?.closure = addFriend
            cell!.contactModel = (sortedContacts[keys[indexPath.section] as! String])![indexPath.row]
            
   //     }
        
        
        return cell!
        
        
    }
    
    
    func insertContact(contact:ContactModel){
        
        var latter = getFistLetter(contact.name)
        
        if ((keys.contains(latter)) == false){
            
            keys.append(latter)
            var contacts = [ContactModel]()
            contacts.append(contact)
            sortedContacts[latter] = contacts
            
        }
        else{
            sortedContacts[latter]?.append(contact)
        }
        
        
    }
    
    func sortKeys(){
        
//        var index = -1
//        if keys.contains("新"){
//            for key in keys {
//                index++
//                if key == "新"
//                {
//                    break
//                }
//            }
//            
//            keys.removeAtIndex(index)
//            
//            
//        }
//        
//        keys.sortInPlace()
//        keys.insert("新", atIndex: 0)
        
        
        //把#号排在最后面
        
         keys.sortInPlace()
    }
    
}

func createSectionLabel(text:String) -> UILabel {
    
    let label = UILabel(frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:CGFloat(30)))
    label.text = text
    label.font = UIFont.systemFontOfSize(13)
    label.textColor = UIColor.blackColor()
    label.backgroundColor = UIColor.Gray(233)
    
    return label
}

