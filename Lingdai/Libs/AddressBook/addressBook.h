//
//  addressBook.h
//  CreditCard
//
//  Created by YUYE on 15/6/4.
//  Copyright (c) 2015年 YUYE. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^MyCallback)(id obj);
@interface addressBook : NSObject
+(void )addressBookRequestAccessCallBack:(MyCallback)callback;

@end
