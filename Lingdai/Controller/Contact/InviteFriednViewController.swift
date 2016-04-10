//
//  InviteFriednViewController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/23.
//
//

import UIKit

class InviteFriednViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    class var instance:InviteFriednViewController {
        get {
            return UIStoryboard(name: "Contacts", bundle: nil).instantiateViewControllerWithIdentifier("InviteFriednViewController") as! InviteFriednViewController
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
