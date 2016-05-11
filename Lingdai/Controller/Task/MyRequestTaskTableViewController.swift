//
//  MyRequestTaskTableViewController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/23.
//
//

import UIKit

class MyRequestTaskTableViewController: UITableViewController {

    lazy var taskManager = TaskDBManager.sharedInstance
    var tasks = [TaskModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskManager.findAll { (tasks) -> Void in
            if tasks.count > 0{
                
                for task in tasks {
                    self.tasks.append(task)
                }
//                if let table = self.tableView {
//                    self.tableView.reloadData()
//                }
            }
        }

        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
     
        
    }
    
    class func  getInstance() ->MyRequestTaskTableViewController{
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MyRequestTaskTableViewController") as! MyRequestTaskTableViewController
        
        
        return vc;
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:NameValueTableViewCell = tableView.dequeueReusableCellWithIdentifier("nameValueIdentifer", forIndexPath: indexPath) as! NameValueTableViewCell

//        if indexPath.row == 0
//        {
//            cell.configureCell("埃尔克森", value: "前锋至少进一个球")
//        }
//        else if indexPath.row == 1 {
//            cell.configureCell("吴磊", value: "助攻前锋射门")
//        }
//        else if indexPath.row == 2{
//            cell.configureCell("孙英权", value: "后卫严厉防守")
//        }
        
        if(indexPath.row < tasks.count){
            
            if tasks[indexPath.row].assignees != nil && tasks[indexPath.row].assignees!.count > 0 {

                   cell.configureCell(tasks[indexPath.row].assignees .first!.name, value: tasks[indexPath.row].title)
                
                
            }
            else{
                cell.configureCell("未指定", value:tasks[indexPath.row].title)
            }
            
            
            cell.setNameColor()
            // Configure the cell...
            
            
            
           

        }
        
        
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
