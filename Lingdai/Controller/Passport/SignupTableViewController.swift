//
//  SignupTableViewController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/4/3.
//
//

import UIKit
import Alamofire
class SignupTableViewController: UITableViewController {
    
    var account:String = NULL
    var password:String = NULL
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submit(sender: AnyObject) {
        
        print("account: \(account), password:\(password)")
        
        if account.isNull() || account.isTelNumber() == false{
            let alert = UIAlertView(title: "提醒", message: "请输入正确的手机号码格式!", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        if password.isNull() || password.length < 6
        {
            let alert = UIAlertView(title: "提醒", message: "请输入六位以上的密码", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
        UserModel.setUserAsVisitor(account, password: password)
    self.navigationController?.pushViewController(TelPhoneCodeViewController.getInstance(), animated: true)
            
        
    }

    func commonTextFieldCallback(text:String,tag:Int) {
        
        if tag == 0 {
            account = text
        }
        else if tag == 1 {
            password = text
        }
        
    }
    
    func signup(){
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CommonTextFieldTableViewCell = tableView.dequeueReusableCellWithIdentifier("CommonTextFieldTableViewCell", forIndexPath: indexPath) as! CommonTextFieldTableViewCell
        
        if (indexPath.row == 0){
            cell.setTextPlaceholder("输入手机号码",type: UIKeyboardType.NumberPad)
        }
        else {
            cell.setTextPlaceholder("设置密码",type:UIKeyboardType.ASCIICapable)
        }
        cell.contentView.tag = indexPath.row
        cell.delegate = commonTextFieldCallback
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
