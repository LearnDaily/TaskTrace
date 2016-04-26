//
//  ContactTableViewController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/18.
//
//

import UIKit
//import Contacts
import ContactsUI
import MessageUI
import Alamofire
protocol ContactDectector{
    func onAdd(contacts:[EmployeeModel]?)
}

@available(iOS 9.0, *)
class ContactTableViewController: UITableViewController,CNContactPickerDelegate,MFMessageComposeViewControllerDelegate{
    var contactStore = CNContactStore()
    var updateContact = CNContact()
   // var contacts:[EmployeeModel] = [TeamModel]()
    var newContacts = [EmployeeModel]()
    var contactsDBManager = ContactsDBManager.instance
    var delegate:ContactDectector?
    var keys = [String]()
    var sortedContacts = [String:[ContactModel]]()
    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.title = "通讯录"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("back:"))
       // self.view.userInteractionEnabled = false
        askForContactAccess()
        setupContacts()
        
        var latter = getFistLetter("长")
        
        print("latter \(latter)")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        

        
        tabBarController?.tabBar.hidden = true
    }

    
    func back(sender:AnyObject){
        delegate?.onAdd(newContacts)
        
        if newContacts.count > 0 {
          
           contactsDBManager.addContacts(newContacts)
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func addFriends(sender:AnyObject){
    
        weak var weakSelf = self
        var contacts = [[String:AnyObject]]();
        for contact in newContacts {
            var para:[String:AnyObject] = [String:AnyObject]()
            para["contact"] = contact.getJson()
            contacts.append(para)
        }
        
        var parameter = [String:AnyObject]()
        parameter["contacts"] = contacts
        
        if isLoading == true{
            return
        }
        else{
            isLoading = true
        }
        
        Alamofire.request(Router.addContacts(parameter)) .responseJSON { response in
            
            weakSelf?.isLoading = false
            print("response \(response.result.value)")
      
            if response.result.isFailure {
                
                
                let alert = UIAlertView(title: "提醒", message: "网络异常，请检查网络", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                
                return
            }
        }
        
        
    }
    
    func setupContacts(){
         weak var weakSelf = self
        contactsDBManager.findAll { (employees) -> Void in
            for employee  in employees{
                weakSelf?.insertContact(ContactModel(employee: employee))
              
            }
           
         //   weakSelf?.contacts = employees
            weakSelf?.view.userInteractionEnabled = true
        }
        weakSelf?.sortKeys()
       
    }
   
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        
        switch (result.rawValue) {
            case MessageComposeResultCancelled.rawValue:
            print("Message was cancelled")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultFailed.rawValue:
            print("Message failed")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultSent.rawValue:
            print("Message was sent")
            self.dismissViewControllerAnimated(true, completion: nil)
        default:
            break;
        }
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
    
    // MARK: - Contact Access Permission Method
    func askForContactAccess() {
        let authorizationStatus = CNContactStore.authorizationStatusForEntityType(CNEntityType.Contacts)
        
        switch authorizationStatus {
        case .Denied, .NotDetermined:
            self.contactStore.requestAccessForEntityType(CNEntityType.Contacts, completionHandler: { (access, accessError) -> Void in
                if !access {
                    if authorizationStatus == CNAuthorizationStatus.Denied {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let message = "\(accessError!.localizedDescription)\n\nPlease allow the app to access your contacts through the Settings."
                            let alertController = UIAlertController(title: "Contacts", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                            
                            let dismissAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
                            }
                            
                            alertController.addAction(dismissAction)
                            
                            self.presentViewController(alertController, animated: true, completion: nil)
                        })
                    }
                }
            })
            break
        default:
            break
        }
    }
    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
        let contact = contactProperty.contact
        let phoneNumber = contactProperty.value as! CNPhoneNumber
        
        for (key,value) in sortedContacts {
            
            if let array = value as? [ContactModel] {
                for item  in array {
                    
                    if item.phoneNumber == phoneNumber.stringValue {
                        print("the user already exits in the contacts")
                        var alertView = UIAlertView(title: "提示", message: "该用户已经存在您的好友列表中", delegate: self, cancelButtonTitle: "取消")
                        alertView.show()
                        return
                    }

                }
            }
            
        }
     
        var name:String
        
        if contact.givenName.isEmpty && contact.familyName.isEmpty{
            name = phoneNumber.stringValue
        }
        else if  !contact.givenName.isEmpty && !contact.familyName.isEmpty{
            name = contact.familyName+contact.givenName
        }
        else if contact.givenName.isEmpty{
            name = contact.familyName
        }
        else if contact.familyName.isEmpty{
            name = contact.givenName
        }
        else{
            name = phoneNumber.stringValue
        }
        
        var employee = ContactModel(number: phoneNumber.stringValue, name: name)
        employee.appendPhoneNumber(phoneNumber.stringValue)
       // contacts.append(employee)
        insertContact(employee)
        sortKeys()
        newContacts.append(employee)
        self.tableView.reloadData()
        
//        if MFMessageComposeViewController.canSendText(){
//            
//            
//            var messageVC = MFMessageComposeViewController()
//            messageVC.body = "Enter a message";
//            messageVC.recipients = ["Enter tel-nr"]
//            messageVC.messageComposeDelegate = self;
//            
//            self.presentViewController(messageVC, animated: true, completion: nil)
//        }
        
       
        
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 0 && indexPath.row == 0){
            let contactPickerViewController = CNContactPickerViewController()
            contactPickerViewController.delegate = self
            contactPickerViewController.displayedPropertyKeys = [CNContactPhoneNumbersKey]
            presentViewController(contactPickerViewController, animated: true, completion: nil)
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
        var cell:ContactTableViewCell = tableView.dequeueReusableCellWithIdentifier("contactTableCellIdentifier", forIndexPath: indexPath) as! ContactTableViewCell
        
      

        if indexPath.section == 0{
            if indexPath.row == 0 {
                cell.configureContactCell(UIImage(named: "contact")!, content: "通讯录好友")
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                return cell
            }
            else if indexPath.row == 1{
                cell.configureContactCell(UIImage(named: "inviteFriend")!, content: "增加好友")
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                return cell
            }
            
            
        }
//        else if indexPath.section == 1{
//            cell.configureContactCell(UIImage(named: "friend")!, content:contacts[indexPath.row].name)
//               cell.accessoryType = UITableViewCellAccessoryType.None
//        }
        
        
        cell.configureContactCell(UIImage(named: "friend")!, content: ((sortedContacts[keys[indexPath.section] as! String])![indexPath.row] as! ContactModel).name)
        
        
        return cell
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
        
        var index = -1
        if keys.contains("新"){
            for key in keys {
                index++
                if key == "新"
                {
                    break
                }
            }
            
           keys.removeAtIndex(index)
            

        }
      
        keys.sortInPlace()
        keys.insert("新", atIndex: 0)
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

func getFistLetter(str: String)-> String{
    //转换成可变数据
    var mutableUserAgent = NSMutableString(string: str) as CFMutableString
    //let transform = kCFStringTransformMandarinLatin//NSString(string: "Any-Latin; Latin-ASCII; [:^ASCII:] Remove") as CFString
    //取得带音调拼音
    if CFStringTransform(mutableUserAgent, nil,kCFStringTransformMandarinLatin, false) == true{
        //取得不带音调拼音
        if CFStringTransform(mutableUserAgent,nil,kCFStringTransformStripDiacritics,false) == true{
           
            
            
            let str1 = mutableUserAgent as String
            
            let startIndex = str1.startIndex.advancedBy(0) //swift 2.0+
            let endIndex = str1.endIndex.advancedBy(-str1.length+1) //swift 2.0+
            
            var range = Range<String.Index>(start: startIndex,end: endIndex)
            
            
            let s = str1.capitalizedString.substringWithRange(range)
            
            
            return s
        }else{
            return str
        }
    }else{
        return str
    }
}

