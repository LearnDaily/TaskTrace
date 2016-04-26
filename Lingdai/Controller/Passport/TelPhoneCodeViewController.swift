//
//  TelPhoneCodeViewController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/4/3.
//
//

import UIKit
import Alamofire
class TelPhoneCodeViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var code1Label: UILabel!

    
    @IBOutlet weak var code2Label: UILabel!
    
    @IBOutlet weak var code3Label: UILabel!

    @IBOutlet weak var code4Label: UILabel!
    
    var tempText = ""
    var isLoading = false
    override func viewDidLoad() {
        super.viewDidLoad()
        var fakeTF = UITextField(frame: CGRectMake(0,0,0,0))
        fakeTF.delegate = self
        fakeTF.keyboardType = .NumberPad
        fakeTF.addTarget(self, action: "textfiledDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        self.view.addSubview(fakeTF)
        
        
        if fakeTF.becomeFirstResponder() == false {
            fakeTF.becomeFirstResponder()
        }
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "提交", style: .Bordered, target: self, action: Selector("submit:"))
        

    }
    
    class func  getInstance() ->TelPhoneCodeViewController{
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TelPhoneCodeViewController") as! TelPhoneCodeViewController
        
        
        return vc;
        
    }
    
    func submit(sender:AnyObject){
        
        if isLoading == true{
            return
        }
        if tempText == "1024" {
            
            
            var account = UserModel.visitorAccount
            var password = UserModel.visitorPassword
            
            if !account.isNull() && !password.isNull() {
                
                
                //
                
                
                var parameters = [String:AnyObject]()
                parameters["account"] = account
                parameters["password"] = password
                weak var weakSelf = self
                
                isLoading = true
                Alamofire.request(Router.Signup(parameters))
                    .responseJSON { response in
                        
                        weakSelf?.isLoading = false
                        if response.result.isFailure {
                            let alert = UIAlertView(title: "提醒", message: "网络异常，请检查网络设置", delegate: nil, cancelButtonTitle: "确定")
                            alert.show()
                            return
                        }
                        
                        print("Response JSON: \(response.result.value)")
                        
                        let json = response.result.value
                        
                        let value = JSON(json!).dictionaryValue
                        
                        
                        if isDataError(value) == true{
                            return ;
                        }
                        else{
                            
                            var result = value["result"]!.dictionaryValue
                            var state = result["state"]?.boolValue
                            var code = result["code"]?.intValue
                            var text = result["text"]?.stringValue
                            var data = result["data"]?.dictionaryValue
                            
                            print("state: \(state),code:\(code),text:\(text),data:\(data)")
                            
                            if(code == 1){
                                
                                UserModel.saveUser()
                                
                              
                                let alert = UIAlertView(title: "提醒", message: "注册成功", delegate: nil, cancelButtonTitle: "确定")
                                alert.show()
                                
                                self.dismissViewControllerAnimated(true, completion:nil )
                                
                                
                            }
                            else{
                                let alert = UIAlertView(title: "提醒", message: "该用户已经存在", delegate: nil, cancelButtonTitle: "确定")
                                alert.show()
                            }
                        }
                        
                }
            }
                

        }
        else {
            var alert = UIAlertView(title: "提示", message: "请输入正确的验证码", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
 
        
       
    }
    
    func textfiledDidChange(sender:AnyObject?){
        
        
        var textField = sender as! UITextField
        var text  = textField.text!
        text.trim()
        switch text.length {
            case 0:
                code1Label.text = ""
                code2Label.text = ""
                code3Label.text = ""
                code4Label.text = ""
                break
            case 1:
                print("textfield text length: \(0)")
                code1Label.text = textField.text
                code2Label.text = ""
                code3Label.text = ""
                code4Label.text = ""
            break
            
            case 2:
                let from = text.startIndex.advancedBy(1)
                code2Label.text = text.substringFromIndex(from)
                code3Label.text = ""
                code4Label.text = ""
                break
            case 3:
                let from = text.startIndex.advancedBy(2)
                code3Label.text = text.substringFromIndex(from)
                code4Label.text = ""
                break
            case 4:
                let from = text.startIndex.advancedBy(3)
                code4Label.text = text.substringFromIndex(from)
                tempText = text
                break

            default:
                
               
                
                textField.text = tempText
            break
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
