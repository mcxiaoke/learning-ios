//
//  IconPickerViewController.m
//  Checklists
//
//  Created by mcxiaoke on 15/9/20.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "IconPickerViewController.h"

@interface IconPickerViewController ()

@end

@implementation IconPickerViewController {
  NSArray* _icons;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  _icons = @[
    @"No Icon",
    @"Appointments",
    @"Birthdays",
    @"Chores",
    @"Drinks",
    @"Folder",
    @"Groceries",
    @"Inbox",
    @"Photos",
    @"Trips"
  ];
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section {
  return _icons.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath {
  UITableViewCell* cell =
      [tableView dequeueReusableCellWithIdentifier:@"IconCell"];
  NSString* iconName = _icons[indexPath.row];
  cell.textLabel.text = iconName;
  cell.imageView.image = [UIImage imageNamed:iconName];
  return cell;
}

- (void)tableView:(UITableView*)tableView
    didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
  NSString* iconName = _icons[indexPath.row];
  [self.delegate iconPicker:self didPickIcon:iconName];
}

@end
