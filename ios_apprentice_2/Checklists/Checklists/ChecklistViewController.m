//
//  ViewController.m
//  Checklists
//
//  Created by mcxiaoke on 15/9/20.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "ChecklistViewController.h"
#import "ChecklistItem.h"
#import "Checklist.h"

@interface ChecklistViewController ()

@end

@implementation ChecklistViewController

- (void)addNewItem:(ChecklistItem *)item {
  NSInteger newRowIndex = self.checklist.items.count;
  [self.checklist.items addObject:item];

  NSIndexPath *indexPath =
      [NSIndexPath indexPathForRow:newRowIndex inSection:0];
  NSArray *indexPaths = @[ indexPath ];
  [self.tableView insertRowsAtIndexPaths:indexPaths
                        withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark： tableview

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return self.checklist.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  ChecklistItem *item = self.checklist.items[indexPath.row];
  [self configureCheckmarkForCell:cell withChecklistItem:item];
  [self configureTextForCell:cell withChecklistItem:item];

  return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

  ChecklistItem *item = self.checklist.items[indexPath.row];
  [item toggleChecked];
  [self configureCheckmarkForCell:cell withChecklistItem:item];
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)configureCheckmarkForCell:(UITableViewCell *)cell
                withChecklistItem:(ChecklistItem *)item {
  UILabel *label = (UILabel *)[cell viewWithTag:1001];
  label.textColor = self.view.tintColor;
  if (item.checked) {
    label.text = @"√";
  } else {
    label.text = @"";
  }
}

- (void)configureTextForCell:(UITableViewCell *)cell
           withChecklistItem:(ChecklistItem *)item {
  UILabel *label = (UILabel *)[cell viewWithTag:1000];
  //  label.text = item.text;
  label.text = [NSString stringWithFormat:@"%lu: %@", item.itemId, item.text];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = self.checklist.name;
}

- (void)tableView:(UITableView *)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
     forRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.checklist.items removeObjectAtIndex:indexPath.row];
  NSArray *indexPaths = @[ indexPath ];
  [tableView deleteRowsAtIndexPaths:indexPaths
                   withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"AddItem"]) {
    UINavigationController *nav = segue.destinationViewController;

    ItemDetailViewController *avc =
        (ItemDetailViewController *)nav.topViewController;
    avc.delegate = self;
  } else if ([segue.identifier isEqualToString:@"EditItem"]) {
    UINavigationController *nav = segue.destinationViewController;

    ItemDetailViewController *avc =
        (ItemDetailViewController *)nav.topViewController;
    avc.delegate = self;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    avc.itemToEdit = self.checklist.items[indexPath.row];
  }
}

- (void)addItemViewControllerDidCancel:(ItemDetailViewController *)controller {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addItemViewController:(ItemDetailViewController *)controller
          didFinishAddingItem:(ChecklistItem *)item {
  [self addNewItem:item];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addItemViewController:(ItemDetailViewController *)controller
         didFinishEditingItem:(ChecklistItem *)item {
  NSInteger index = [self.checklist.items indexOfObject:item];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
  UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
  [self configureTextForCell:cell withChecklistItem:item];
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
