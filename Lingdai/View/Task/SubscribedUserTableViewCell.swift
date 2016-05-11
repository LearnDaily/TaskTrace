//
//  SubscribedUserTableViewCell.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/5/5.
//
//

import UIKit

class SubscribedUserTableViewCell: UITableViewCell {
     var scrollView: LDHorizontalScrollView!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
      
        getSubscribedUsers()
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    
    
    //CGRectGetWidth(self.frame)
    
    func getSubscribedUsers(){
        
        let subscribeBtn = UIButton(frame: CGRectMake(2,2,40,40))
        subscribeBtn.setImage(UIImage(named: "v2_star_on"), forState: UIControlState.Normal)
        self.contentView.addSubview(subscribeBtn)
        
        scrollView = LDHorizontalScrollView(frame: CGRectMake(50,2,CGRectGetWidth(self.frame)-50,40))
  
        self.contentView.addSubview(scrollView)
        for i in 1...10{
            scrollView.addItem(createDateView())
        }
        
    }

    
    func createDateView()->UIView{
        
        let dateView = UIView(frame: CGRectMake(0,0,40,40))
      
        
        
        let dateButton = UIButton()
        dateButton.layer.borderColor = UIColor.brownColor().CGColor
        //dateButton.setTitle("\(getDate())", forState:.Normal)
        dateButton.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        dateView.addSubview(dateButton)
        dateButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        let centerXConstraint = NSLayoutConstraint(item: dateButton, attribute: .CenterX, relatedBy: .Equal, toItem: dateView, attribute: .CenterX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: dateButton, attribute: .CenterY, relatedBy: .Equal, toItem: dateView, attribute: .CenterY, multiplier: 1, constant: 0)
        
        let widthConstraint = NSLayoutConstraint(item: dateButton, attribute: .Width, relatedBy: .Equal, toItem: dateView, attribute: .Width, multiplier: 1, constant: -2)
        let heightConstraint = NSLayoutConstraint(item: dateButton, attribute: .Height, relatedBy: .Equal, toItem: dateView, attribute: .Height, multiplier: 1, constant: -2)
        
        //        let dateTopConstraint = NSLayoutConstraint(item: dateButton, attribute: .Top, relatedBy: .Equal, toItem: monthLabel, attribute: .Bottom, multiplier: 1, constant: 5)
        //        let dateCenterXConstraint = NSLayoutConstraint(item: dateButton, attribute: .CenterX, relatedBy: .Equal, toItem: dateView, attribute: .CenterX, multiplier: 1, constant: 0)
        
        //        let dateBottomConstraint = NSLayoutConstraint(item: dateButton, attribute: .Bottom, relatedBy: .Equal, toItem: dateView, attribute: .Bottom, multiplier: 1, constant: -5)
        
        NSLayoutConstraint.activateConstraints([centerXConstraint,centerYConstraint,widthConstraint,heightConstraint])
        
        
        
        dateButton.layer.cornerRadius = 14
        dateButton.layer.borderWidth = 1
        
        
        return dateView
        
        
    }

    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
