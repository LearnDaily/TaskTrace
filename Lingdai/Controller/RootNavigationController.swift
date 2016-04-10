//
//  RootNavigationController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/21.
//
//

import UIKit


class RootNavigationController: UINavigationController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationBar.setBackgroundImage(UIImage(named: "nav")?.imageWithRenderingMode(.AlwaysOriginal), forBarMetrics: .Default)
        navigationBar.barTintColor = themeColor
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor(white: 1.0, alpha: 1.0)]
         navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.barStyle = .Black
        // Do any additional setup after loading the view.
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
