//
//  AllListsViewController.m
//  Checklists
//
//  Created by mcxiaoke on 15/9/20.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "AllListsViewController.h"
#import "Checklist.h"
#import "ChecklistItem.h"
#import "ChecklistViewController.h"
#import "DataModel.h"

@interface AllListsViewController ()<UINavigationControllerDelegate>

@end

@implementation AllListsViewController

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
  if (viewController == self) {
    [self.dataModel setIndexOfSelectedChecklist:-1];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  self.navigationController.delegate = self;
  NSInteger index = [self.dataModel indexOfSelectedChecklist];
  if (index >= 0 && index < [self.dataModel.lists count]) {
    Checklist *checklist = self.dataModel.lists[index];
    [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
  }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self.dataModel loadChecklists];
  }

  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return [self.dataModel.lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"Cell";
  UITableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:cellIdentifier];
  }

  Checklist *checklist = self.dataModel.lists[indexPath.row];

  cell.textLabel.text = checklist.name;
  cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
  int count = [checklist countUncheckedItems];
  if ([checklist.items count] == 0) {
    cell.detailTextLabel.text = @"(No items)";
  } else if (count == 0) {
    cell.detailTextLabel.text = @"All Done!";
  } else {
    cell.detailTextLabel.text =
        [NSString stringWithFormat:@"%d Remaining", count];
  }

  NSLog(@"image name: %@", checklist.iconName);

  cell.imageView.image = [UIImage imageNamed:checklist.iconName];

  return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.dataModel setIndexOfSelectedChecklist:indexPath.row];

  Checklist *checklist = self.dataModel.lists[indexPath.row];
  [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"ShowChecklist"]) {
    ChecklistViewController *controller = segue.destinationViewController;

    controller.checklist = sender;
  } else if ([segue.identifier isEqualToString:@"AddChecklist"]) {
    UINavigationController *nav = segue.destinationViewController;
    ListDetailViewController *controller =
        (ListDetailViewController *)nav.topViewController;
    controller.delegate = self;
    controller.itemToEdit = nil;
  }
}

- (void)listDetailViewControllerDidCancel:
    (ListDetailViewController *)controller {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(ListDetailViewController *)controller
             didFinishAddingItem:(Checklist *)checklist {
  //  NSInteger newRowIndex = [self.dataModel.lists count];
  [self.dataModel.lists addObject:checklist];
  [self.dataModel sortChecklists];
  [self.tableView reloadData];

  //  NSIndexPath *indexPath =
  //      [NSIndexPath indexPathForRow:newRowIndex inSection:0];
  //  NSArray *indexPaths = @[ indexPath ];
  //  [self.tableView insertRowsAtIndexPaths:indexPaths
  //                        withRowAnimation:UITableViewRowAnimationAutomatic];

  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(ListDetailViewController *)controller
            didFinishEditingItem:(Checklist *)checklist {
  [self.dataModel sortChecklists];
  [self.tableView reloadData];

  //  NSInteger index = [self.dataModel.lists indexOfObject:checklist];
  //  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
  //  UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
  //  cell.textLabel.text = checklist.name;
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
     forRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.dataModel.lists removeObjectAtIndex:indexPath.row];
  NSArray *indexPaths = @[ indexPath ];
  [tableView deleteRowsAtIndexPaths:indexPaths
                   withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)tableView:(UITableView *)tableView
    accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
  UINavigationController *nav = [self.storyboard
      instantiateViewControllerWithIdentifier:@"ListNavigationController"];
  ListDetailViewController *controller =
      (ListDetailViewController *)nav.topViewController;
  controller.delegate = self;
  Checklist *checklist = self.dataModel.lists[indexPath.row];
  controller.itemToEdit = checklist;
  [self presentViewController:nav animated:YES completion:nil];
}

@end
