//
//  MasterViewController.m
//  FlowerDetails
//
//  Created by mcxiaoke on 15/8/22.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@property(strong, nonatomic) NSArray *flowerData;
@property(strong, nonatomic) NSArray *flowerSections;

- (void)createFlowerData;

@end

@implementation MasterViewController

- (void)createFlowerData {
  self.flowerSections = @[ @"Red Flowers", @"Blue Flowers" ];

  NSMutableArray *redFlowers = [[NSMutableArray alloc] init];
  NSMutableArray *blueFlowers = [[NSMutableArray alloc] init];

  [redFlowers addObject:@{
    @"name" : @"Poppy",
    @"picture" : @"Poppy.png",
    @"url" : @"http://en.wikipedia.org/wiki/Poppy"
  }];
  [redFlowers addObject:@{
    @"name" : @"Tulip",
    @"picture" : @"Tulip.png",
    @"url" : @"http://en.wikipedia.org/wiki/Tulip"
  }];
  [redFlowers addObject:@{
    @"name" : @"Gerbera",
    @"picture" : @"Gerbera.png",
    @"url" : @"http://en.wikipedia.org/wiki/Gerbera"
  }];

  [blueFlowers addObject:@{
    @"name" : @"Phlox",
    @"picture" : @"Phlox.png",
    @"url" : @"http://en.wikipedia.org/wiki/Phlox"
  }];
  [blueFlowers addObject:@{
    @"name" : @"Pin Cushion Flower",
    @"picture" : @"Pincushion flower.png",
    @"url" : @"http://en.wikipedia.org/wiki/Scabious"
  }];
  [blueFlowers addObject:@{
    @"name" : @"Iris",
    @"picture" : @"Iris.png",
    @"url" : @"http://en.wikipedia.org/wiki/Iris_(plant)"
  }];

  self.flowerData = @[ redFlowers, blueFlowers ];
}

- (void)awakeFromNib {
  [super awakeFromNib];
  if ([[UIDevice currentDevice] userInterfaceIdiom] ==
      UIUserInterfaceIdiomPad) {
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.detailViewController = (DetailViewController *)
      [[self.splitViewController.viewControllers lastObject] topViewController];
  [self createFlowerData];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([[segue identifier] isEqualToString:@"showDetail"]) {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSDictionary *item = self.flowerData[indexPath.section][indexPath.row];
    DetailViewController *controller = (DetailViewController *)
        [[segue destinationViewController] topViewController];
    [controller setDetailItem:item];
    controller.navigationItem.leftBarButtonItem =
        self.splitViewController.displayModeButtonItem;
    controller.navigationItem.leftItemsSupplementBackButton = YES;
  }
}

#pragma mark - Table View

- (BOOL)tableView:(UITableView *)tableView
    canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.flowerSections count];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return [self.flowerData[section] count];
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
  return self.flowerSections[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"flowerCell"
                                      forIndexPath:indexPath];

  NSDictionary *data = self.flowerData[indexPath.section][indexPath.row];
  cell.textLabel.text = data[@"name"];
  cell.detailTextLabel.text = data[@"url"];
  cell.imageView.image = [UIImage imageNamed:data[@"picture"]];

  return cell;
}

@end
