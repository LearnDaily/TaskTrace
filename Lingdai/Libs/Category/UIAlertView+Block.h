//
//  UIAlertView+Block.h
//  GCLCategoryExample
//
//  Created by chaogao on 3/7/14.
//  Copyright (c) 2014 GC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DismissBlock)(int buttonIndex);
typedef void (^CancelBlock)();

@interface UIAlertView (Block)

+ (UIAlertView*) showAlertViewWithTitle:(NSString*) title
                                message:(NSString*) message
                      cancelButtonTitle:(NSString*) cancelButtonTitle
                      otherButtonTitles:(NSArray*) otherButtons
                              onDismiss:(DismissBlock) dismissed
                               onCancel:(CancelBlock) cancelled;

+ (UIAlertView*) warningAlertViewWithMessage:(NSString*) message;


@end
