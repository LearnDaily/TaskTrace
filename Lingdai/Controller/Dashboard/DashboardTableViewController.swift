//
//  DashboardTableViewController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/23.
//
//

import UIKit
import Alamofire
class DashboardTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Alamofire.request(.GET, "https://www.baidu.com") .responseString { response in
            print("Response String: \(response.result.value)")
            }
            .responseJSON { response in
                print("Response JSON: \(response.result.value)")
        }

       

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
         netTest()
        tabBarController?.tabBar.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func netTest(){
//        
//        Alamofire.request(Router.FetchTasks(lastId: "100000", count: 10)).responseJSON{
//            closureResponse in
//            
//            if closureResponse.result.isFailure {
//                
//                print("net failed...")
//                //self.notice("网络异常", type: NoticeType.error, autoClear: true)
//                return
//            }
//            
//            
//            let json = closureResponse.result.value
//            
//            print(json)
//            
////            let result = JSON(json!)
////            
////            if result["isSuc"].boolValue {
////                
////                self.notice("评论成功!", type: NoticeType.success, autoClear: true)
////                
////                self.webView.stringByEvaluatingJavaScriptFromString("article.addComment("+result["result"].rawString()!+");")
////                
////                
////                
////            } else {
////                
////                self.notice("评论失败!", type: NoticeType.error, autoClear: true)
////            }
//        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0
        {
            if indexPath.row == 0 {
                var vc = DecomposeTaskTableViewController.getInstance()
                vc.taskOperator = TaskOperator.Create
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 1{
                if #available(iOS 9.0, *) {
                    self.navigationController?.pushViewController(ContactTableViewController.getInstance(), animated: true)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
    // MARK: - Table view data source
//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
