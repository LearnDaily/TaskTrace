//
//  TaskStatusTableViewController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/4/10.
//
//

import UIKit

class TaskStatusTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    public let NavigationH: CGFloat = 64
    
    private var orderStatuses: [OrderStatus] = [OrderStatus]()
    
    var tableView:BaseTableView!

    override func viewWillAppear(animated: Bool) {
        
        self.view.backgroundColor = UIColor(r: 239, g: 239, b: 239)
        
        loadData()
       
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "进度详情"
        
        setupTableView()
        buildDetailButtonsView()
    }
    
    func loadData(){
       
        var time = "2016-1-10"
        var post_time =  NSDateFormatter.dateFormatterWithFormat("YYYY-MM-dd").dateFromString(time)
            
        
        var status0 = OrderStatus()
        status0.status_title = "钟其鸿"
        status0.status_desc = "完成UI设计"
        
        status0.status_time =  "01-07"
        orderStatuses.insert(status0, atIndex: 0)
        
        var status1 = OrderStatus()
        status1.status_title = "钟其鸿"
        status1.status_desc = "完成App demo开发"
        status1.status_time = "01-20"
        orderStatuses.insert(status1, atIndex: 0)
        
        var status2 = OrderStatus()
        status2.status_title = "钟其鸿"
        status2.status_desc = "完成app 网络框架部署"
        status2.status_time = "02-01"
        orderStatuses.append(status2)
        
        orderStatuses.insert(status2, atIndex: 0)
        
        
        var status3 = OrderStatus()
        status3.status_title = "钟其鸿"
        status3.status_desc = "完成所有功能"
        status3.status_time = "02-13"
        orderStatuses.insert(status3, atIndex: 0)
        
        var status4 = OrderStatus()
        status4.status_title = "钟其鸿"
        status4.status_desc = "修改bug中，预计30号可发布"
        status4.status_time = "03-01"
        orderStatuses.insert(status4, atIndex: 0)
        
        var status5 = OrderStatus()
        status5.status_title = "钟其鸿"
        status5.status_desc = "应用发布完成"
        status5.status_time =  "03-10"
        orderStatuses.insert(status5, atIndex: 0)
        
       // self.tableView.reloadData()
    }
    
    func setupTableView(){
        
        tableView = BaseTableView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), style: .Plain)
        tableView?.backgroundColor = UIColor.whiteColor()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = 80
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView!)
    }
    
    
    private func buildDetailButtonsView() {
        let bottomView = UIView(frame: CGRectMake(0, view.height - 50 , view.width, 1))
        bottomView.backgroundColor = UIColor.grayColor()
        bottomView.alpha = 0.1
        view.addSubview(bottomView)
        
        let bottomView1 = UIView(frame: CGRectMake(0, view.height - 49, view.width, 49))
        bottomView1.backgroundColor = UIColor.whiteColor()
        view.addSubview(bottomView1)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    // MARK: - Table view data source
//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
    
    
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 80
//    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orderStatuses.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = TaskStatusTableViewCell.orderStatusCell(tableView)

         cell.orderStatus = orderStatuses[indexPath.row]
        
        if indexPath.row == 0 {
            cell.orderStateType = .Top
        } else if indexPath.row == orderStatuses.count - 1 {
            cell.orderStateType = .Bottom
        } else {
            cell.orderStateType = .Middle
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
