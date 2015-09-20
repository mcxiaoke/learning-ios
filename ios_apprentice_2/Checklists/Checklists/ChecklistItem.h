//
//  ChecklistItem.h
//  Checklists
//
//  Created by mcxiaoke on 15/9/20.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ChecklistItem : NSObject<NSCoding>

@property(nonatomic, copy) NSString* text;
@property(nonatomic, assign) BOOL checked;

@property(nonatomic, copy) NSDate* dueDate;
@property(nonatomic, assign) BOOL shouldRemind;
@property(nonatomic, assign) NSInteger itemId;

- (void)toggleChecked;

- (void)scheduleNotification;
- (void)cancelNotification;

- (UILocalNotification*)notificationForThisItem;

@end
