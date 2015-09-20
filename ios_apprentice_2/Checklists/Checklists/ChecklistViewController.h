//
//  ViewController.h
//  Checklists
//
//  Created by mcxiaoke on 15/9/20.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

@class Checklist;

@interface ChecklistViewController
    : UITableViewController<ItemDetailViewControllerDelegate>

@property(nonatomic, strong) Checklist *checklist;

@end
