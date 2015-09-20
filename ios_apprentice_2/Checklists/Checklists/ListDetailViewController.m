//
//  ListDetailViewController.m
//  Checklists
//
//  Created by mcxiaoke on 15/9/20.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "ListDetailViewController.h"
#import "IconPickerViewController.h"
#import "Checklist.h"

@interface ListDetailViewController ()<UITextFieldDelegate,
                                       IconPickerViewControllerDelegate>

@property(weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property(weak, nonatomic) IBOutlet UITextField *textField;
@property(weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation ListDetailViewController {
  NSString *_iconName;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _iconName = @"Folder";
  }
  return self;
}

- (IBAction)done:(id)sender {
  if (self.itemToEdit == nil) {
    Checklist *item = [[Checklist alloc] init];
    item.name = self.textField.text;
    item.iconName = _iconName;
    [self.delegate listDetailViewController:self didFinishAddingItem:item];
  } else {
    self.itemToEdit.name = self.textField.text;
    self.itemToEdit.iconName = _iconName;
    [self.delegate listDetailViewController:self
                       didFinishEditingItem:self.itemToEdit];
  }
}

- (IBAction)cancel:(id)sender {
  [self.delegate listDetailViewControllerDidCancel:self];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  if (self.itemToEdit != nil) {
    self.title = @"Edit Checklist";
    self.textField.text = self.itemToEdit.name;
    self.doneBarButton.enabled = YES;
    _iconName = self.itemToEdit.iconName;
  }

  self.iconImageView.image = [UIImage imageNamed:_iconName];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.textField becomeFirstResponder];
}

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1) {
    return indexPath;
  } else {
    return nil;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSLog(@"prepareForSegue: %@", segue.identifier);
  if ([segue.identifier isEqualToString:@"PickIcon"]) {
    IconPickerViewController *controller = segue.destinationViewController;
    controller.delegate = self;
  }
}

- (void)iconPicker:(IconPickerViewController *)picker
       didPickIcon:(NSString *)iconName {
  _iconName = iconName;
  self.iconImageView.image = [UIImage imageNamed:_iconName];
  [self.navigationController popViewControllerAnimated:YES];
}

@end
