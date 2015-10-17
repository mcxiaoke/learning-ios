//
//  TableViewController.m
//  UITableViewDemo
//
//  Created by mcxiaoke on 15/10/18.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "TableViewController.h"

static NSString* const kCellIdentifier = @"Cell";

@interface TableViewController ()

@property(nonatomic, strong) NSMutableArray* sections;

@end

@implementation TableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  //  UINavigationController* navController = self.navigationController;
  UIBarButtonItem* demoItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Demo"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(deleteCells)];
  self.navigationItem.rightBarButtonItem = demoItem;
  self.navigationItem.leftBarButtonItem = demoItem;

  [self.tableView registerClass:[UITableViewCell class]
         forCellReuseIdentifier:kCellIdentifier];
  //  [self addMoveSectionButton];
  //  [self addMoveCellsButton];
  //  [self addDeleteCellsButton];
  self.refreshControl = [[UIRefreshControl alloc] init];
  [self.refreshControl addTarget:self
                          action:@selector(handleRefresh:)
                forControlEvents:UIControlEventValueChanged];
}

- (void)handleRefresh:(id)sender {
  dispatch_time_t popTime =
      dispatch_time(DISPATCH_TIME_NOW, 1.0f * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_main_queue(), ^{
    NSMutableArray* firstSection = [self.sections firstObject];
    [firstSection addObject:[NSDate date]];
    [self.refreshControl endRefreshing];
    NSIndexPath* newIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[ newIndexPath ]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
  });
}

- (void)addMoveSectionButton {
  UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
  [button setTitle:@"Move Section" forState:UIControlStateNormal];
  button.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
  [button sizeToFit];
  button.frame = CGRectMake(
      0, self.view.bounds.size.height - button.frame.size.height - 50,
      button.frame.size.width, button.frame.size.height);
  [button addTarget:self
                action:@selector(moveSection1ToSection3)
      forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
}

- (void)addMoveCellsButton {
  UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
  [button setTitle:@"Move Cells" forState:UIControlStateNormal];
  button.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
  [button sizeToFit];
  button.frame =
      CGRectMake(button.frame.size.width + 10,
                 self.view.bounds.size.height - button.frame.size.height - 50,
                 button.frame.size.width, button.frame.size.height);
  [button addTarget:self
                action:@selector(moveSectionCells)
      forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
}

- (void)addDeleteCellsButton {
  UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
  [button setTitle:@"Delete Cells" forState:UIControlStateNormal];
  button.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
  [button sizeToFit];
  button.frame =
      CGRectMake(button.frame.size.width * 2,
                 self.view.bounds.size.height - button.frame.size.height - 50,
                 button.frame.size.width, button.frame.size.height);
  [button addTarget:self
                action:@selector(deleteCells)
      forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
}

- (void)deleteCells {
}

#pragma mark - Table view data source

- (NSMutableArray*)newSectionWithIndex:(NSUInteger)index
                             cellCount:(NSUInteger)cellCount {
  NSMutableArray* result = [[NSMutableArray alloc] init];
  NSUInteger counter = 0;
  for (counter = 0; counter < cellCount; counter++) {
    [result addObject:[NSString stringWithFormat:@"Section %lu Cell %lu", index,
                                                 counter + 1]];
  }
  return result;
}

- (NSMutableArray*)sections {
  if (_sections == nil) {
    NSMutableArray* section1 = [self newSectionWithIndex:1 cellCount:3];
    NSMutableArray* section2 = [self newSectionWithIndex:2 cellCount:8];
    NSMutableArray* section3 = [self newSectionWithIndex:3 cellCount:3];
    _sections = [[NSMutableArray alloc]
        initWithArray:@[ section1, section2, section3 ]];
  }
  return _sections;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
  return self.sections.count;
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section {
  NSMutableArray* st = self.sections[section];
  return st.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath {
  UITableViewCell* cell =
      [tableView dequeueReusableCellWithIdentifier:kCellIdentifier
                                      forIndexPath:indexPath];
  NSMutableArray* array = self.sections[indexPath.section];
  cell.textLabel.text = array[indexPath.row];
  return cell;
}

- (NSString*)tableView:(UITableView*)tableView
    titleForHeaderInSection:(NSInteger)section {
  return [NSString stringWithFormat:@"Section Header %ld", section];
}

- (void)moveSection1ToSection3 {
  NSMutableArray* section1 = self.sections[0];
  [self.sections removeObject:section1];
  [self.sections addObject:section1];
  [self.tableView moveSection:0 toSection:2];
}

- (void)moveSectionCells {
  NSMutableArray* section1 = self.sections[0];
  NSMutableArray* section2 = self.sections[1];
  NSString* cell1InSection1 = section1[0];

  [section1 removeObject:cell1InSection1];
  [section2 insertObject:cell1InSection1 atIndex:1];

  NSIndexPath* sourceIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  NSIndexPath* destIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];
  [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destIndexPath];
}

@end
