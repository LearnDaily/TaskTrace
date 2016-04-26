//
//  LoginTableViewController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/11.
//
//

import UIKit

import Alamofire

typealias SignInCallBack = (success:Bool) -> Void


class LoginTableViewController: UITableViewController {
    
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var loadingView:AMTumblrHud!
    var signInCallBack: SignInCallBack?
    weak var weakSelf:LoginTableViewController?
    var isStart = false
    var account:String!
    var password:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        weakSelf = self
        
        
    }
    
    
    static var instance:LoginTableViewController = {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginTableViewController") as! LoginTableViewController
    }()
    
    
    @IBAction func submitTapped(sender: AnyObject) {
        
        account = accountTextField.text
        password = passwordTextField.text
        
//        
//        if accountTextField.text!.isEmpty || accountTextField.text?.length<6{
//            
//            return ;
//        }
//        
//        if passwordTextField.text!.isEmpty || accountTextField.text?.length<6{
//            return ;
//        }
        
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

        
        startLoading()
        if isStart == true {
            return
        }
        Alamofire.request(Router.Login(account: accountTextField.text!, password: passwordTextField.text!)) .responseJSON { response in
            
            self.weakSelf?.isStart = false
            print("response \(response.result.value)")
            self.weakSelf?.stopLoading()
            if response.result.isFailure {
                
                
                let alert = UIAlertView(title: "提醒", message: "网络异常，请检查网络", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                
                return
            }
            
            
            let json = response.result.value
            
            let value = JSON(json!).dictionaryValue
            
            
            
            if value["response"]?.stringValue == "error"{
               
                let alert = UIAlertView(title: "提醒", message: "输入数据格式不正确", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                
                return
                
            }
            else{
             
                var result = value["result"]!.dictionaryValue
                var state = result["state"]?.boolValue
                var code = result["code"]?.intValue
                var text = result["text"]?.stringValue
                var data = result["data"]?.dictionaryValue
                
                print("state: \(state),code:\(code),text:\(text),data:\(data)")
                
                if(code == 1){
                    
                    UserModel.setAccount(self.weakSelf?.accountTextField.text);
                    UserModel.setPassword(self.weakSelf?.passwordTextField.text!);
                    var me = ContactModel(id: KeychainWrapper.stringForKey(USER_ACCOUNT)!)
                    ContactsDBManager.instance.addContacts([me])
                    
                    if let callback = self.weakSelf?.signInCallBack{
                        callback(success: true)
                    }
                    
                    
                    let alert = UIAlertView(title: "提醒", message: "登陆成功", delegate: nil, cancelButtonTitle: "确定")
                    alert.show()
                    self.weakSelf?.dismissViewControllerAnimated(true, completion: nil)
                }
                else{
                    let alert = UIAlertView(title: "提醒", message: "用户名或密码不正确", delegate: nil, cancelButtonTitle: "确定")
                    alert.show()
                }
            }
            
        }
        
        
        //            var timer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: "login:", userInfo: nil, repeats: false)
        
        
    }
    
    
    
    func startLoading(){
        
        self.view.userInteractionEnabled = false
        
        loadingView =  AMTumblrHud(frame: CGRectMake((CGFloat) ((self.view.frame.size.width - 55) * 0.5),
            (CGFloat) ((self.view.frame.size.height - 20) * 0.5), 55, 20))
        
        loadingView.hudColor = UIColor.lightGrayColor()
        
        self.view.addSubview(loadingView)
        
        
        loadingView.showAnimated(true)
    }
    
    func stopLoading(leave:Bool = false){
        weakSelf?.view.userInteractionEnabled = true
        weakSelf?.loadingView.showAnimated(false)
        weakSelf?.loadingView.removeFromSuperview()
        if leave == true {
            weakSelf?.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        loadingView.removeFromSuperview()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
