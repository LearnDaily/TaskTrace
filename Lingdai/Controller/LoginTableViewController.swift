//
//  LoginTableViewController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/11.
//
//

import UIKit



typealias SignInCallBack = (success:Bool) -> Void


class LoginTableViewController: UITableViewController {
    
    var loadingView:AMTumblrHud!
    var signInCallBack: SignInCallBack?
    weak var weakSelf:LoginTableViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        weakSelf = self
        
        
        
      

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    static var instance:LoginTableViewController = {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginTableViewController") as! LoginTableViewController
    }()

    
    @IBAction func submitTapped(sender: AnyObject) {
        
        if let callback = signInCallBack{
            callback(success: true)
        }
        
        self.view.userInteractionEnabled = false
        
        loadingView =  AMTumblrHud(frame: CGRectMake((CGFloat) ((self.view.frame.size.width - 55) * 0.5),
            (CGFloat) ((self.view.frame.size.height - 20) * 0.5), 55, 20))
        
        loadingView.hudColor = UIColor.lightGrayColor()
        
        self.view.addSubview(loadingView)
        
        
        loadingView.showAnimated(true)

        
        var timer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: "login:", userInfo: nil, repeats: false)


    }
    
    func login(sender:AnyObject){
                
        weakSelf?.view.userInteractionEnabled = true
        weakSelf?.loadingView.showAnimated(false)
        weakSelf?.loadingView.removeFromSuperview()
        weakSelf?.dismissViewControllerAnimated(true, completion: nil)
    }
    
  
    override func viewDidDisappear(animated: Bool) {

        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        loadingView.removeFromSuperview()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
