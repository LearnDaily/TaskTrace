//
//  PublishStatusViewController.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/5/5.
//
//

import UIKit
public let LFBGlobalBackgroundColor = UIColor.colorWithCustom(239, g: 239, b: 239)
class PublishStatusViewController: UIViewController {
    
    
    var feedLabel:UILabel!
    var feedButton:UIButton!
    var completeLabel:UILabel!
    var completeButton:UIButton!
    var promptLabel: UILabel!
     private var statusTextView: PlaceholderTextView!
     private let margin: CGFloat = 15

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = true
        view.backgroundColor = LFBGlobalBackgroundColor
        buildPlaceholderLabel()
        createCheckItems()
        buildIderTextView()
        buildRightItemButton()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func buildIderTextView() {
        statusTextView = PlaceholderTextView(frame: CGRectMake(margin, CGRectGetMaxY(completeButton.frame) + 10, SCREEN_WIDTH - 2 * margin, 100))
        statusTextView.placeholder = "请输进度描述(300字以内)"
        view.addSubview(statusTextView)
    }
    
    private func buildPlaceholderLabel() {
        
        promptLabel = UILabel(frame: CGRectMake(margin, 70, SCREEN_WIDTH - 2 * margin, 50))
        promptLabel.text = "选择'发表到状态'，老板才能及时看到你的努力哦!"
        promptLabel.numberOfLines = 2;
        promptLabel.textColor = UIColor.blackColor()
        promptLabel.font = UIFont.systemFontOfSize(15)
        view.addSubview(promptLabel)
        
        
        let lineView = UIView(frame: CGRectMake(margin, 115, SCREEN_WIDTH - margin, 0.5))
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.1
        self.view.addSubview(lineView)
    }
    

    private func buildRightItemButton() {
       navigationItem.rightBarButtonItem = UIBarButtonItem.barButton("提交", titleColor: UIColor.colorWithCustom(100, g: 100, b: 100), target: self, action: "rightItemClick")
    }
    
    func createCheckItems(){
        
        
        
        feedLabel = UILabel(frame: CGRectMake(20,115,65,40))
        feedLabel?.text = "发表到状态"
        feedLabel.font = UIFont.systemFontOfSize(13)
        feedLabel.textColor = UIColor.blackColor()
        feedLabel.textAlignment = .Right
        self.view.addSubview(feedLabel)
        
        feedButton = UIButton(frame: CGRectMake(80,115,40,40))
        feedButton.setImage(UIImage(named: "v2_noselected"), forState: UIControlState.Normal)
        feedButton.setImage(UIImage(named: "v2_selected"), forState: UIControlState.Selected)
        feedButton.addTarget(self, action: "feedSelected:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(feedButton)
        
        
        completeLabel = UILabel(frame: CGRectMake(145,115,65,40))
        completeLabel?.text = "完成任务"
        completeLabel.font = UIFont.systemFontOfSize(13)
        completeLabel.textColor = UIColor.blackColor()
        completeLabel.textAlignment = .Right
        self.view.addSubview(completeLabel)
        
        completeButton = UIButton(frame: CGRectMake(205,115,40,40))
        completeButton.setImage(UIImage(named: "v2_noselected"), forState: UIControlState.Normal)
        completeButton.setImage(UIImage(named: "v2_selected"), forState: UIControlState.Selected)
        completeButton.addTarget(self, action: "completeSelected:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(completeButton)

        
      
    }
    
    func feedSelected(sender:AnyObject){
        feedButton.selected = !feedButton.selected
    }
    
    func completeSelected(sender:AnyObject){
        completeButton.selected = !completeButton.selected
    }
    
    // MARK: - Action
    func rightItemClick() {
        
        if statusTextView.text == nil || 0 == statusTextView.text?.characters.count {
            ProgressHUDManager.showImage(UIImage(named: "v2_star_on")!, status: "请输入意见,心里空空的")
        } else if statusTextView.text?.characters.count < 5 {
            ProgressHUDManager.showImage(UIImage(named: "v2_star_on")!, status: "请输入超过5个字啊亲~")
        } else if statusTextView.text?.characters.count >= 300 {
            ProgressHUDManager.showImage(UIImage(named: "v2_star_on")!, status: "说的太多了,臣妾做不到啊~")
        } else {
            ProgressHUDManager.showWithStatus("发送中")
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                self.navigationController?.popViewControllerAnimated(true)
                //self.mineVC?.iderVCSendIderSuccess = true
                ProgressHUDManager.dismiss()
            })
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
