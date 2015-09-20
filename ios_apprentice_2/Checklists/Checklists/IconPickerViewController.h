//
//  IconPickerViewController.h
//  Checklists
//
//  Created by mcxiaoke on 15/9/20.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IconPickerViewController;

@protocol IconPickerViewControllerDelegate<NSObject>

- (void)iconPicker:(IconPickerViewController*)picker
       didPickIcon:(NSString*)iconName;

@end

@interface IconPickerViewController : UITableViewController

@property(nonatomic, weak) id<IconPickerViewControllerDelegate> delegate;

@end
