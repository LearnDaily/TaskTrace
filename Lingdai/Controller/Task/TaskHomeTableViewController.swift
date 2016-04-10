//
//  TaskHomeTableViewController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/23.
//
//

import UIKit

class TaskHomeTableViewController: UITableViewController {
    
    var controllers:[UIViewController]!
    var pageController:UIPageViewController!
    
    
    @IBOutlet weak var controllersSegmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        createPageController()
        
        automaticallyAdjustsScrollViewInsets = false
    }

    @IBAction func changeWorkBench(sender: UISegmentedControl) {
        setShowViewController(sender.selectedSegmentIndex)
        
       
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - pageController
    func createPageController() {
        
        let myTaskViewController = MyTaskTableViewController.instance
        
        let myRequestTaskViewController = MyRequestTaskTableViewController.getInstance()
        
        controllers = [myTaskViewController,myRequestTaskViewController]
        
        let options = [UIPageViewControllerOptionSpineLocationKey : NSNumber(integer: UIPageViewControllerSpineLocation.None.rawValue)]
        pageController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: options)
        pageController.dataSource = self
        pageController.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113)
        
        //pageController.view.userInteractionEnabled = false
        setShowViewController(0)
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
//
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
//MARK: - UIPageViewControllerDataSource
extension TaskHomeTableViewController:UIPageViewControllerDataSource {
    
    func viewControllerAt(index:Int) -> UIViewController {
        return controllers[index]
    }
    
    func indexOfViewController(viewController: UIViewController) -> Int {
        return  controllers.indexOf(viewController)!
    }
    
    func setShowViewController(index:Int) {
        pageController.setViewControllers([viewControllerAt(index) ], direction: UIPageViewControllerNavigationDirection(rawValue: index%2)!, animated: true, completion: nil)
        addChildViewController(pageController)
        view.addSubview(pageController.view)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController)
        if index == 0 {
            index = controllers.count
        }
        controllersSegmentedControl.selectedSegmentIndex = index%controllers.count
        index--
        
        return viewControllerAt(index%controllers.count)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController)
        controllersSegmentedControl.selectedSegmentIndex = index%controllers.count
        index++
        return viewControllerAt(index%controllers.count)
    }
    
}

