//
//  ItemDetailViewController.h
//  Checklists
//
//  Created by mcxiaoke on 15/9/20.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemDetailViewController;
@class ChecklistItem;

@protocol ItemDetailViewControllerDelegate<NSObject>

- (void)addItemViewControllerDidCancel:(ItemDetailViewController *)controller;

- (void)addItemViewController:(ItemDetailViewController *)controller
          didFinishAddingItem:(ChecklistItem *)item;

- (void)addItemViewController:(ItemDetailViewController *)controller
         didFinishEditingItem:(ChecklistItem *)item;

@end

@interface ItemDetailViewController : UITableViewController

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@property(nonatomic, strong) ChecklistItem *itemToEdit;
@property(nonatomic, weak) id<ItemDetailViewControllerDelegate> delegate;

@end
