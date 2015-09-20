//
//  ListDetailViewController.h
//  Checklists
//
//  Created by mcxiaoke on 15/9/20.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListDetailViewController;
@class Checklist;

@protocol ListDetailViewControllerDelegate<NSObject>

- (void)listDetailViewControllerDidCancel:
    (ListDetailViewController *)controller;

- (void)listDetailViewController:(ListDetailViewController *)controller
             didFinishAddingItem:(Checklist *)checklist;

- (void)listDetailViewController:(ListDetailViewController *)controller
            didFinishEditingItem:(Checklist *)checklist;

@end

@interface ListDetailViewController : UITableViewController

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@property(nonatomic, strong) Checklist *itemToEdit;
@property(nonatomic, weak) id<ListDetailViewControllerDelegate> delegate;

@end
