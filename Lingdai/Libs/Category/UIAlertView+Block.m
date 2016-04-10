//
//  UIAlertView+Block.m
//  GCLCategoryExample
//
//  Created by chaogao on 3/7/14.
//  Copyright (c) 2014 GC. All rights reserved.
//

#import "UIAlertView+Block.h"

static DismissBlock _dismissBlock;
static CancelBlock _cancelBlock;

@implementation UIAlertView (Block)

+ (UIAlertView*) warningAlertViewWithMessage:(NSString*) message
{
    return [UIAlertView showAlertViewWithTitle:nil message:message cancelButtonTitle:@"确定" otherButtonTitles:nil onDismiss:nil onCancel:nil];
}

+ (UIAlertView*) showAlertViewWithTitle:(NSString*) title
                                message:(NSString*) message
                      cancelButtonTitle:(NSString*) cancelButtonTitle
                      otherButtonTitles:(NSArray*) otherButtons
                              onDismiss:(DismissBlock) dismissed
                               onCancel:(CancelBlock) cancelled
{
    _cancelBlock  = [cancelled copy];
    
    _dismissBlock  = [dismissed copy];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[self self]
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
    
    for(NSString *buttonTitle in otherButtons)
        [alert addButtonWithTitle:buttonTitle];
    
    [alert show];
    return alert;
}

+ (void)alertView:(UIAlertView*) alertView didDismissWithButtonIndex:(NSInteger) buttonIndex {
    
	if(buttonIndex == [alertView cancelButtonIndex] && _cancelBlock != nil)
	{
		_cancelBlock();
	}
    else if(_dismissBlock != nil)
    {
        _dismissBlock(buttonIndex - 1.0); // cancel button is button 0
    }  
}

@end
