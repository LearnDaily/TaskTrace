//
//  PersonTableViewController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/18.
//
//

import UIKit

class PersonTableViewController: UITableViewController {
   //  let kImageOriginHight:CGFloat = 200;
     let kTempHeight:CGFloat = 80.0;
    
    static let headerHeight =  SCREEN_WIDTH/3*2+80
    
    let kImageOriginHight = CGFloat(100)
    
    lazy var profileHeader:ProfileHeaderView = {
        
         var header = UINib(nibName: "ProfileHeader", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! ProfileHeaderView
         header.frame = CGRectMake(0, 0,  SCREEN_WIDTH,headerHeight )
        header.setupViews()
        
        return header
        
    }()
    
    lazy var transImage:UIImage = {
        var image = UIImage(named: "transbg")
        
        return image!
    }()
    
    lazy var normalImage:UIImage = {
        var image = UIImage(named: "nav")
        
        return image!
    }()
    
    lazy var photoPicker: UIImagePickerController = {
        let pick: UIImagePickerController = UIImagePickerController()
        pick.view.backgroundColor = UIColor.grayColor()
        pick.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        pick.delegate = self
   
        return pick
    }()
    
    lazy var cameraPicker: UIImagePickerController = {
        let pick: UIImagePickerController = UIImagePickerController()
        pick.view.backgroundColor = UIColor.grayColor()
        pick.sourceType = UIImagePickerControllerSourceType.Camera
        pick.allowsEditing = true
        pick.delegate = self
   
        return pick
    }()
    
   
    
    lazy var alert: UIAlertController = {
        let alertCon = UIAlertController(title: "图片选取方式", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        return alertCon
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        
        automaticallyAdjustsScrollViewInsets = false
        
     
       
      
        
        self.tableView.tableHeaderView = profileHeader
        
        self.tableView.frame = CGRect(x: 0, y: -64, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height+64)

        
    }
    
    
    
    func initViews(){
        // 设置状态栏颜色为白色
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        // 去除NavigationBar底部黑线
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //设置NavigationBar背景为透明
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "transbg"), forBarMetrics: UIBarMetrics.Default)
        
        alert.addAction(UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
            self.cameraClick()
        }))
        alert.addAction(UIAlertAction(title: "从手机相册取", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
            self.photoLibraryClick()
        }))
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: { (alert) -> Void in
            //self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        profileHeader.headerImage.userInteractionEnabled = true
        profileHeader.userImage.userInteractionEnabled = true
        
        let userImagePanGesture = UITapGestureRecognizer(target: self, action: "userImgClicked:")
        profileHeader.userImage.addGestureRecognizer(userImagePanGesture)
        
        
        let headerImagePanGesture = UITapGestureRecognizer(target: self, action: "headImgClicked:")
        profileHeader.headerImage.addGestureRecognizer(headerImagePanGesture)
        


    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(transImage, forBarMetrics: UIBarMetrics.Default)
        self.tabBarController?.tabBar.hidden = false
         
    }
    
    
    override func viewWillDisappear(animated: Bool) {
      
          super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(normalImage, forBarMetrics: UIBarMetrics.Default)
    }

       // MARK: - Table view data source

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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 2{
            if #available(iOS 9.0, *) {
                self.navigationController?.pushViewController(ContactTableViewController.getInstance(), animated: true)
            } else {
                // Fallback on earlier versions
            }
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
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
      
        let contentOffSet: CGFloat = self.tableView.contentOffset.y
        if(contentOffSet < 72) {
            self.navigationController?.navigationBar.setBackgroundImage(transImage, forBarMetrics: UIBarMetrics.Default)
        }else {
            self.navigationController?.navigationBar.setBackgroundImage(normalImage, forBarMetrics: UIBarMetrics.Default)
        }
        
      
        
        
    }
}

// MARK: - ViewController控制器的事件处理

extension PersonTableViewController {
    
    func headImgClicked(sender: UITapGestureRecognizer) {
        cameraPicker.view.tag = 1
        photoPicker.view.tag = 1
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func userImgClicked(sender: UITapGestureRecognizer){
        cameraPicker.view.tag = 2
        photoPicker.view.tag = 2
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    /**
     选取拍照
     */
    func cameraClick() {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            NSLog("支持相机")
            self.presentViewController(cameraPicker, animated: true, completion: nil)
        }else {
            NSLog("不支持拍照")
        }
    }
    
    /**
     选取相册
     */
    func photoLibraryClick() {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)) {
            NSLog("支持图库")
            self.presentViewController(photoPicker, animated: true, completion: nil)
        }else {
            NSLog("不支持图库")
        }
    }
}

// MARK: - UIImagePickerControllerDelegate代理实现
extension PersonTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    /**
     点击图片
     
     - parameter picker: picker
     - parameter info:   图片
     */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        NSLog("info: \(info)")
        let image: UIImage = NSDictionary(dictionary: info).objectForKey("UIImagePickerControllerOriginalImage") as! UIImage
        
        // 更换图片
        self.dismissViewControllerAnimated(true) { () -> Void in
            
            if picker.view.tag == 1 {
               // self.profileHeader.headerImage.image = image
                 self.profileHeader.headerImage.image = image
            }
            else if picker.view.tag == 2{
                self.profileHeader.userImage.image = image
            }
          
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        NSLog("select")
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        NSLog("cancel")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}


