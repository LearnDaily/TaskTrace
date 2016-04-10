//
//  MainTabBarController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/24.
//
//

import UIKit



class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = defaultColor
        setItemsImage()
        
        if KeychainWrapper.stringForKey(USER_ACCOUNT) == nil {
            KeychainWrapper.setString("88888888", forKey: USER_ACCOUNT)
            var me = ContactModel(id: KeychainWrapper.stringForKey(USER_ACCOUNT)!)
            ContactsDBManager.instance.addContacts([me])
        }
      
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("goLogin:"), name: GO_TO_LOGIN, object: nil)
        
        print("xxxxxx")
    }
    
    
    func goLogin(sender:AnyObject){
        
        //if User.sharedInstance.token == nil{
            let nvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("WelcomeViewController") as!
        RootNavigationController
        
            let welcomeVC = nvc.viewControllers.first as! WelcomeViewController
//            
//            loginVC.initSignInCallBack({ (success) -> Void in
//                if success {
//                    if let index = notification.object as? Int {
//                        self.selectedIndex =  index
//                    }
//                }
//            })
        
            presentViewController(nvc, animated: true, completion: { () -> Void in
                self.selectedIndex = 0
            })
      //  }

        
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setItemsImage() {
        let images = ["dashboard","task","person"]
        var count = 0
        for item in tabBar.items! {
            item.image = UIImage(named: images[count])?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            //item.selectedImage = UIImage(named: images[count] + "-h")?.imageWithRenderingMode(.AlwaysOriginal)
            count++
        }
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
