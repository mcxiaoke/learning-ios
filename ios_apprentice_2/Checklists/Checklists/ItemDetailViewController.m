//
//  ItemDetailViewController.m
//  Checklists
//
//  Created by mcxiaoke on 15/9/20.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ChecklistItem.h"

@interface ItemDetailViewController ()<UITextFieldDelegate>
@property(weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property(weak, nonatomic) IBOutlet UITextField *textField;
@property(weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property(weak, nonatomic) IBOutlet UISwitch *switchControl;
@property(weak, nonatomic) IBOutlet UILabel *dueDateLabel;

@end

@implementation ItemDetailViewController {
  NSDate *_dueDate;
  BOOL _datePickerVisible;
}

- (IBAction)cancel:(id)sender {
  [self.delegate addItemViewControllerDidCancel:self];
  //  [self.presentingViewController dismissViewControllerAnimated:YES
  //                                                    completion:nil];
}

- (IBAction)done:(id)sender {
  if (self.itemToEdit == nil) {
    ChecklistItem *item = [[ChecklistItem alloc] init];
    item.text = self.textField.text;
    item.checked = NO;
    item.shouldRemind = self.switchControl.on;
    item.dueDate = _dueDate;
    [item scheduleNotification];

    [self.delegate addItemViewController:self didFinishAddingItem:item];
  } else {
    self.itemToEdit.text = self.textField.text;
    self.itemToEdit.shouldRemind = self.switchControl.on;
    self.itemToEdit.dueDate = _dueDate;
    [self.itemToEdit scheduleNotification];
    [self.delegate addItemViewController:self
                    didFinishEditingItem:self.itemToEdit];
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  if (self.itemToEdit != nil) {
    self.title = @"Edit Item";
    self.textField.text = self.itemToEdit.text;
    self.doneBarButton.enabled = YES;
    self.switchControl.on = self.itemToEdit.shouldRemind;
    _dueDate = self.itemToEdit.dueDate;
  } else {
    self.switchControl.on = NO;
  }

  if (!_dueDate) {
    _dueDate = [NSDate date];
  }

  [self updateDueDateLabel];
}

- (void)updateDueDateLabel {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateStyle:NSDateFormatterMediumStyle];
  [formatter setTimeStyle:NSDateFormatterShortStyle];
  self.dueDateLabel.text = [formatter stringFromDate:_dueDate];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.textField becomeFirstResponder];
}

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1 && indexPath.row == 1) {
    return indexPath;
  } else {
    return nil;
  }
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  if (section == 1 && _datePickerVisible) {
    return 3;
  } else {
    return [super tableView:tableView numberOfRowsInSection:section];
  }
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1 && indexPath.row == 2) {
    return 217;
  } else {
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
  }
}

- (NSInteger)tableView:(UITableView *)tableView
    indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1 && indexPath.row == 2) {
    NSIndexPath *newIndexPath =
        [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
    return [super tableView:tableView
        indentationLevelForRowAtIndexPath:newIndexPath];
  } else {
    return
        [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1 && indexPath.row == 2) {
    UITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"DatePickerCell"];
    if (!cell) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:@"DatePickerCell"];
      cell.selectionStyle = UITableViewCellSelectionStyleNone;

      UIDatePicker *picker =
          [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
      picker.tag = 100;
      [cell.contentView addSubview:picker];
      [picker addTarget:self
                    action:@selector(dateChanged:)
          forControlEvents:UIControlEventValueChanged];
    }
    return cell;
  } else {
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
  }
}

- (void)dateChanged:(UIDatePicker *)datePicker {
  _dueDate = datePicker.date;
  [self updateDueDateLabel];
}

- (void)hideDatePicker {
  if (_datePickerVisible) {
    _datePickerVisible = NO;
    NSIndexPath *dateRowIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *datePickerIndexPath =
        [NSIndexPath indexPathForRow:2 inSection:1];
    UITableViewCell *cell =
        [self.tableView cellForRowAtIndexPath:dateRowIndexPath];
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:0 alpha:0.5];

    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[ dateRowIndexPath ]
                          withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView deleteRowsAtIndexPaths:@[ datePickerIndexPath ]
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
  }
}

- (void)showDatePicker {
  _datePickerVisible = YES;
  NSIndexPath *dateRowIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];
  NSIndexPath *datePickerIndexPath =
      [NSIndexPath indexPathForRow:2 inSection:1];

  UITableViewCell *cell =
      [self.tableView cellForRowAtIndexPath:dateRowIndexPath];
  cell.detailTextLabel.textColor = cell.detailTextLabel.tintColor;

  [self.tableView beginUpdates];
  [self.tableView insertRowsAtIndexPaths:@[ datePickerIndexPath ]
                        withRowAnimation:UITableViewRowAnimationFade];
  [self.tableView reloadRowsAtIndexPaths:@[ dateRowIndexPath ]
                        withRowAnimation:UITableViewRowAnimationNone];
  [self.tableView endUpdates];

  UITableViewCell *datePickerCell =
      [self.tableView cellForRowAtIndexPath:datePickerIndexPath];
  UIDatePicker *datePicker = (UIDatePicker *)[datePickerCell viewWithTag:100];
  [datePicker setDate:_dueDate];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  [self hideDatePicker];
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  [self.textField resignFirstResponder];
  if (indexPath.section == 1 && indexPath.row == 1) {
    if (_datePickerVisible) {
      [self hideDatePicker];
    } else {
      [self showDatePicker];
    }
  }
}

- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  NSString *newText =
      [textField.text stringByReplacingCharactersInRange:range
                                              withString:string];

  self.doneBarButton.enabled = ([newText length] > 0);

  return YES;
}

@end
