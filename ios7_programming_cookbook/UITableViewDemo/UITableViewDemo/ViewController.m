//
//  ViewController.m
//  UITableViewDemo
//
//  Created by mcxiaoke on 15/10/17.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "ViewController.h"

static NSString* const kCellIdentifier = @"Cell";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView* tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                style:UITableViewStylePlain];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  self.tableView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.tableView registerClass:[UITableViewCell class]
         forCellReuseIdentifier:kCellIdentifier];
  [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
  return 5;
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return 3;
      break;
    case 1:
      return 5;
      break;
    case 2:
      return 8;
      break;
    default:
      return 2;
      break;
  }
}

- (UILabel*)newLabelWithTitle:(NSString*)title {
  UILabel* label = [[UILabel alloc] initWithFrame:CGRectZero];
  label.text = title;
  label.backgroundColor = [UIColor clearColor];
  [label sizeToFit];
  return label;
}

- (UIView*)headerOrFooterViewWithTitle:(NSString*)title {
  UILabel* label = [self newLabelWithTitle:title];
  label.frame = CGRectMake(label.frame.origin.x + 10.0f, 5.0f,
                           label.frame.size.width, label.frame.size.height);

  CGRect finalFrame = CGRectMake(0.0f, 0.0f, label.frame.size.width + 10.0f,
                                 label.frame.size.height);

  UIView* view = [[UIView alloc] initWithFrame:finalFrame];
  view.backgroundColor = [UIColor lightGrayColor];
  [view addSubview:label];
  return view;
}

- (UIView*)tableView:(UITableView*)tableView
    viewForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    return [self headerOrFooterViewWithTitle:@"Section 0 Header"];
  }
  return nil;
}

- (UIView*)tableView:(UITableView*)tableView
    viewForFooterInSection:(NSInteger)section {
  if (section == 0) {
    return [self headerOrFooterViewWithTitle:@"Section 0 Footer"];
  }
  return nil;
}

- (NSString*)tableView2:(UITableView*)tableView
titleForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    return @"Section 0 Header";
  }
  return nil;
}

- (NSString*)tableView2:(UITableView*)tableView
titleForFooterInSection:(NSInteger)section {
  if (section == 0) {
    return @"Section 0 Footer";
  }
  return nil;
}

- (CGFloat)tableView:(UITableView*)tableView
    heightForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    return 30.0f;
  }
  return 0.0f;
}

- (CGFloat)tableView:(UITableView*)tableView
    heightForFooterInSection:(NSInteger)section {
  if (section == 0) {
    return 30.0f;
  }
  return 0.0f;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath {
  UITableViewCell* cell =
      [tableView dequeueReusableCellWithIdentifier:kCellIdentifier
                                      forIndexPath:indexPath];
  cell.textLabel.text =
      [NSString stringWithFormat:@"Section %ld, Cell %ld", indexPath.section,
                                 indexPath.row];
  //  cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;

  UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
  button.frame = CGRectMake(0.0f, 0.0f, 150.0f, 30.0f);
  [button setTitle:@"Expand" forState:UIControlStateNormal];
  [button addTarget:self
                action:@selector(performExpand:)
      forControlEvents:UIControlEventTouchUpInside];
  //  cell.accessoryView = button;

  return cell;
}

- (UIView*)superviewOfType:(Class)superviewClass forView:(UIView*)view {
  if (view.superview != nil) {
    if ([view.superview isKindOfClass:superviewClass]) {
      return view.superview;
    } else {
      return [self superviewOfType:superviewClass forView:view.superview];
    }
  }
  return nil;
}

- (void)performExpand:(UIButton*)sender {
  __unused UITableViewCell* parentCell = (UITableViewCell*)
      [self superviewOfType:[UITableViewCell class] forView:sender];
  NSLog(@"performExpand: %@", parentCell.textLabel.text);
}

- (void)tableView:(UITableView*)tableView
    accessoryButtonTappedForRowWithIndexPath:(NSIndexPath*)indexPath {
  UITableViewCell* tapCell = [tableView cellForRowAtIndexPath:indexPath];
  NSLog(@"accessoryButtonTappedForRowWithIndexPath, cell title： %@",
        tapCell.textLabel.text);
}

- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath {
  return UITableViewCellEditingStyleDelete;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
  [super setEditing:editing animated:animated];
  [self.tableView setEditing:editing animated:animated];
}

- (void)tableView:(UITableView*)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
     forRowAtIndexPath:(NSIndexPath*)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    ////    [self.allRows removeObjectAtIndex:indexPath.row];
    //    [tableView deleteRowsAtIndexPaths:@[ indexPath ]
    //                     withRowAnimation:UITableViewRowAnimationLeft];
  }
}

// FIXME only working with UITableViewController
// see:
// http://stackoverflow.com/questions/16216503/uitableview-never-calls-tableviewshouldshowmenuforrowatindexpath-on-its-delega
- (BOOL)tableView:(UITableView*)tableView
    shouldShowMenuForRowAtIndexPath:(NSIndexPath*)indexPath {
  return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
  NSLog(@"canPerformAction:%@", NSStringFromSelector(action));
  if (action == @selector(copy:)) {
    return YES;
  }
  return NO;
}

- (void)tableView:(UITableView*)tableView
    performAction:(SEL)action
forRowAtIndexPath:(NSIndexPath*)indexPath
       withSender:(id)sender {
}

@end
