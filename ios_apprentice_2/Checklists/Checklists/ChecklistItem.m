//
//  ChecklistItem.m
//  Checklists
//
//  Created by mcxiaoke on 15/9/20.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "ChecklistItem.h"
#import "DataModel.h"
#import <UIKit/UIKit.h>

@implementation ChecklistItem

- (void)toggleChecked {
  self.checked = !self.checked;
}

- (void)scheduleNotification {
  [self cancelNotification];

  if (self.shouldRemind &&
      [self.dueDate compare:[NSDate date]] != NSOrderedAscending) {
    UILocalNotification* no = [[UILocalNotification alloc] init];
    no.fireDate = self.dueDate;
    no.timeZone = [NSTimeZone defaultTimeZone];
    no.alertBody = self.text;
    no.soundName = UILocalNotificationDefaultSoundName;
    no.userInfo = @{ @"ItemId" : @(self.itemId) };
    [[UIApplication sharedApplication] scheduleLocalNotification:no];
  }
}

- (void)cancelNotification {
  UILocalNotification* existsNotification = [self notificationForThisItem];
  if (existsNotification) {
    [[UIApplication sharedApplication]
        cancelLocalNotification:existsNotification];
  }
}

- (UILocalNotification*)notificationForThisItem {
  NSArray* notifications =
      [[UIApplication sharedApplication] scheduledLocalNotifications];
  for (UILocalNotification* no in notifications) {
    NSNumber* number = [no.userInfo objectForKey:@"ItemId"];
    if (number != nil && [number integerValue] == self.itemId) {
      return no;
    }
  }
  return nil;
}

- (void)dealloc {
  [self cancelNotification];
}

- (id)init {
  self = [super init];
  if (self) {
    self.itemId = [DataModel nextChecklistItemId];
  }
  return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder {
  self = [super init];
  if (self) {
    self.text = [aDecoder decodeObjectForKey:@"Text"];
    self.checked = [aDecoder decodeBoolForKey:@"Checked"];
    self.dueDate = [aDecoder decodeObjectForKey:@"DueDate"];
    self.shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"];
    self.itemId = [aDecoder decodeIntegerForKey:@"ItemId"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder*)aCoder {
  [aCoder encodeObject:self.text forKey:@"Text"];
  [aCoder encodeBool:self.checked forKey:@"Checked"];
  [aCoder encodeObject:self.dueDate forKey:@"DueDate"];
  [aCoder encodeBool:self.shouldRemind forKey:@"ShouldRemind"];
  [aCoder encodeInteger:self.itemId forKey:@"ItemId"];
}

@end
