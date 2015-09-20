//
//  AllListsViewController.h
//  Checklists
//
//  Created by mcxiaoke on 15/9/20.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"

@class DataModel;

@interface AllListsViewController
    : UITableViewController<ListDetailViewControllerDelegate>

@property(nonatomic, strong) DataModel* dataModel;

@end
