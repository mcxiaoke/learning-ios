//
//  ViewController.m
//  HelloTableView
//
//  Created by mcxiaoke on 15/8/22.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.table.dataSource = self;
  self.table.delegate = self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  UIImage *image = [UIImage imageNamed:@"Rose.png"];
  if (indexPath.section == 0) {
    cell.textLabel.text =
        [NSString stringWithFormat:@"A Section %lu, Row %lu", indexPath.section,
                                   indexPath.row];
    cell.detailTextLabel.text =
        [NSString stringWithFormat:@"A Details for Row %lu", indexPath.row];
    cell.imageView.image = image;
  } else {
    cell.textLabel.text =
        [NSString stringWithFormat:@"B Section %lu, Row %lu", indexPath.section,
                                   indexPath.row];
    cell.detailTextLabel.text =
        [NSString stringWithFormat:@"B Details for Row %lu", indexPath.row];
    cell.imageView.image = image;
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"user selected:%@", indexPath);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  if (section == 0) {
    return 2;
  } else {
    return 3;
  }
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
  return [NSString stringWithFormat:@"Section %lu", section];
}

@end
