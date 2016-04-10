//
//  ReplyTableViewCell.swift
//  Lingdai
//
//  Created by 钟其鸿 on 16/3/17.
//
//

import UIKit

class ReplyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var replyButton: UIImageView!
    
    @IBOutlet weak var avatarImageVIew: BaseImageView!

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentatorNameLabel: UILabel!
 
    @IBOutlet weak var commentTimeLabel: UILabel!
    @IBOutlet weak var replyTimeLabel: UILabel!

    @IBOutlet weak var replyLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
   
    var callback:replyTo!
   
    var containerView:UIView!
    var reply:ReplyModel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   
    @IBAction func replyDidTap(sender: AnyObject) {
        callback(text: "",to: "")
    }
   
    
    static func getCellHeight(entity:ReplyModel)->CGFloat{
        let attribute = [NSFontAttributeName:UIFont.systemFontOfSize(13)]
        let option:NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let replyText: NSString = NSString(CString: entity.replyContent!.cStringUsingEncoding(NSUTF8StringEncoding)!,
            encoding: NSUTF8StringEncoding)!
        let replyFrame:CGRect = replyText.boundingRectWithSize(CGSizeMake(SCREEN_WIDTH-68, 3000), options: option, attributes: attribute, context: nil)
        
        let commentText: NSString = NSString(CString: entity.commentContent!.cStringUsingEncoding(NSUTF8StringEncoding)!,
            encoding: NSUTF8StringEncoding)!
        let commentFrame:CGRect = commentText.boundingRectWithSize(CGSizeMake(SCREEN_WIDTH-77, 3000), options: option, attributes: attribute, context: nil)
        
        
        return replyFrame.size.height+commentFrame.size.height+132;
    }
    
    static func getReplyContentHeight(entity:ReplyModel) ->CGFloat{
        let attribute = [NSFontAttributeName:UIFont.systemFontOfSize(13)]
        let option:NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let replyText: NSString = NSString(CString: entity.replyContent!.cStringUsingEncoding(NSUTF8StringEncoding)!,
            encoding: NSUTF8StringEncoding)!
        let replyFrame:CGRect = replyText.boundingRectWithSize(CGSizeMake(SCREEN_WIDTH-30, 3000), options: option, attributes: attribute, context: nil)
        
        return replyFrame.height
    }


    
    func configureCell(reply:ReplyModel,action:replyTo){
        self.reply = reply
        replyLabel.text = reply.replyContent
        commentLabel.text = reply.commentContent
        callback = action
       
     
        
    }

    
}
