//
//  addressBook.m
//  CreditCard
//
//  Created by YUYE on 15/6/4.
//  Copyright (c) 2015年 YUYE. All rights reserved.
//

#import "addressBook.h"
#import <AddressBook/AddressBook.h>
#import "UIAlertView+Block.h"
@implementation addressBook

+(void)addressBookRequestAccessCallBack:(MyCallback)callback
{
    CFErrorRef error;
    ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, &error), ^(bool granted, CFErrorRef error) {
        if (granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
               callback([self getContactsFromAddressBook]);
            });
        } else {
            callback(nil);
           
        }
    });
}

+(NSMutableArray *)getContactsFromAddressBook
{
    CFErrorRef error = NULL;

    NSMutableArray *mutableContacts = [NSMutableArray array];
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    if (addressBook) {
        NSArray *allContacts = (__bridge_transfer NSArray*)ABAddressBookCopyArrayOfAllPeople(addressBook);
        
        
        NSUInteger i = 0;
        for (i = 0; i<[allContacts count]; i++)
        {

            ABRecordRef contactPerson = (__bridge ABRecordRef)allContacts[i];
            //contact.recordId = ABRecordGetRecordID(contactPerson);
            
            // Get first and last names
            NSString *firstName = (__bridge_transfer NSString*)ABRecordCopyValue(contactPerson, kABPersonFirstNameProperty);
            NSString *lastName = (__bridge_transfer NSString*)ABRecordCopyValue(contactPerson, kABPersonLastNameProperty);
            
            // Set Contact properties
//            contact.firstName = firstName;
//            contact.lastName = lastName;
 
            NSString * name = [NSString stringWithFormat:@"%@%@",lastName == nil ? @"" : lastName ,firstName == nil ? @"" : firstName];
       
            
            
            // Get mobile number
            ABMultiValueRef phonesRef = ABRecordCopyValue(contactPerson, kABPersonPhoneProperty);
            //contact.phone = [self getMobilePhoneProperty:phonesRef];

            
            
//            if(phonesRef) {
//                CFRelease(phonesRef);
//            }
            
            // Get image if it exists
//            NSData  *imgData = (__bridge_transfer NSData *)ABPersonCopyImageData(contactPerson);
//            contact.image = [UIImage imageWithData:imgData];
//            if (!contact.image) {
//                contact.image = [UIImage imageNamed:@"icon-avatar-60x60"];
//            }
        
            NSMutableArray *array = [self getMobilePhoneProperty:phonesRef andName:name];
            CFRelease(phonesRef);
            for (NSDictionary *dic in array)
            {
                [mutableContacts addObject:dic];
            }
            
        }
        
        if(addressBook) {
            CFRelease(addressBook);
        }
       

    }
    else
    {
        NSLog(@"Error");
        
    }
    
     return mutableContacts;
}

+(NSMutableArray *)getMobilePhoneProperty:(ABMultiValueRef)phonesRef andName:(NSString *)name
{
    NSMutableArray *array =[NSMutableArray array];
    for (int i=0; i < ABMultiValueGetCount(phonesRef); i++) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        CFStringRef currentPhoneLabel = ABMultiValueCopyLabelAtIndex(phonesRef, i);
        CFStringRef currentPhoneValue = ABMultiValueCopyValueAtIndex(phonesRef, i);
        
        if(currentPhoneLabel) {
//            if (CFStringCompare(currentPhoneLabel, kABPersonPhoneMobileLabel, 0) == kCFCompareEqualTo) {
//                str =  (__bridge NSString *)currentPhoneValue;
//            }
//            
//            if (CFStringCompare(currentPhoneLabel, kABHomeLabel, 0) == kCFCompareEqualTo) {
//                str = (__bridge NSString *)currentPhoneValue;
//            }
            
            NSString *str = [(__bridge NSString *)currentPhoneValue stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            [dic setValue:[[str stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] forKey:@"phone"];
            [dic setValue:name forKey:@"name"];
            [array addObject:dic];
        }
        

       
        if(currentPhoneLabel) {
            CFRelease(currentPhoneLabel);
        }
        if(currentPhoneValue) {
            CFRelease(currentPhoneValue);
        }
    }
    
    return array;
}

@end
