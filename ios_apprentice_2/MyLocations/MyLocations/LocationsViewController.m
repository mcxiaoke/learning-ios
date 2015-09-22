//
//  LocationsViewController.m
//  MyLocations
//
//  Created by mcxiaoke on 15/9/22.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "LocationsViewController.h"
#import "Location+CoreDataProperties.h"
#import "LocationCell.h"
#import "LocationDetailsViewController.h"
#import "UIImage+Resize.h"
#import "NSMutableString+AddText.h"
#import <CoreData/CoreData.h>

@interface LocationsViewController ()<NSFetchedResultsControllerDelegate>

@property(nonatomic, strong) NSFetchedResultsController* fetchResultsController;

@end

@implementation LocationsViewController {
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"EditLocation"]) {
    UINavigationController* navController = segue.destinationViewController;
    LocationDetailsViewController* controller =
        (LocationDetailsViewController*)navController.topViewController;
    controller.managedObjectContext = self.managedObjectContext;
    NSIndexPath* indexPath = [self.tableView indexPathForCell:sender];
    Location* location =
        [self.fetchResultsController objectAtIndexPath:indexPath];
    controller.locationToEdit = location;
  }
}

- (NSFetchedResultsController*)fetchResultsController {
  if (_fetchResultsController == nil) {
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* entity =
        [NSEntityDescription entityForName:@"Location"
                    inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSSortDescriptor* sorter1 =
        [NSSortDescriptor sortDescriptorWithKey:@"category" ascending:YES];
    NSSortDescriptor* sorter2 =
        [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    [fetchRequest setSortDescriptors:@[ sorter1, sorter2 ]];
    [fetchRequest setFetchBatchSize:20];
    _fetchResultsController = [[NSFetchedResultsController alloc]
        initWithFetchRequest:fetchRequest
        managedObjectContext:self.managedObjectContext
          sectionNameKeyPath:@"category"
                   cacheName:@"Locations"];
    _fetchResultsController.delegate = self;
  }

  return _fetchResultsController;
}

- (void)performFetch {
  NSError* error;
  if (![self.fetchResultsController performFetch:&error]) {
    abort();
    return;
  }
}

- (void)dealloc {
  _fetchResultsController.delegate = nil;
}

- (void)viewDidLoad {
  [super viewDidLoad];
    self.tableView.backgroundColor=[UIColor blackColor];
    self.tableView.separatorColor=[UIColor colorWithWhite:1.0f alpha:0.2f];
  self.navigationItem.rightBarButtonItem = self.editButtonItem;
  [self performFetch];
}

#pragma mark - fetched results controller delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController*)controller {
  NSLog(@"fetched results content begin changed");
  [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController*)controller {
  NSLog(@"fetched results content end changed");
  [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController*)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath*)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath*)newIndexPath {
  switch (type) {
    case NSFetchedResultsChangeInsert:
      // here indsert at newIndexPath
      [self.tableView insertRowsAtIndexPaths:@[ newIndexPath ]
                            withRowAnimation:UITableViewRowAnimationFade];
      break;
    case NSFetchedResultsChangeDelete:
      [self.tableView deleteRowsAtIndexPaths:@[ indexPath ]
                            withRowAnimation:UITableViewRowAnimationFade];
      break;
    case NSFetchedResultsChangeUpdate:
      [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath]
              atIndexPath:indexPath];
      break;
    case NSFetchedResultsChangeMove:
      [self.tableView deleteRowsAtIndexPaths:@[ indexPath ]
                            withRowAnimation:UITableViewRowAnimationFade];
      // here insert at newIndexPath
      [self.tableView insertRowsAtIndexPaths:@[ newIndexPath ]
                            withRowAnimation:UITableViewRowAnimationFade];
      break;
    default:
      break;
  }
}

- (void)controller:(NSFetchedResultsController*)controller
  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
  switch (type) {
    case NSFetchedResultsChangeInsert:
      [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                    withRowAnimation:UITableViewRowAnimationFade];
      break;
    case NSFetchedResultsChangeDelete:
      [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                    withRowAnimation:UITableViewRowAnimationFade];
      break;
    default:
      break;
  }
}

#pragma mark - table view

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
  return [[self.fetchResultsController sections] count];
}

- (NSString*)tableView:(UITableView*)tableView
    titleForHeaderInSection:(NSInteger)section {
  id<NSFetchedResultsSectionInfo> info =
      [self.fetchResultsController sections][section];
  return [[info name] uppercaseString];
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section {
  id<NSFetchedResultsSectionInfo> info =
      [self.fetchResultsController sections][section];
  return [info numberOfObjects];
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(15.0f, tableView.sectionHeaderHeight-14.0f, 300.0f, 14.0f)];
    label.font=[UIFont boldSystemFontOfSize:11.0f];
    label.text=[tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    label.textColor=[UIColor colorWithWhite:1.0f alpha:0.4f];
    label.backgroundColor=[UIColor clearColor];
    
    UIView* separator=[[UIView alloc] initWithFrame:CGRectMake(15.0f, tableView.sectionHeaderHeight-0.5f, tableView.bounds.size.width-15.0f, 0.5f)];
    separator.backgroundColor=tableView.separatorColor;
    
    UIView* view=[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.bounds.size.width, tableView.sectionHeaderHeight)];
    view.backgroundColor=[UIColor colorWithWhite:0.0f alpha:0.85f];
    
    [view addSubview:label];
    [view addSubview:separator];
    
    return view;


}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath {
  UITableViewCell* cell =
      [tableView dequeueReusableCellWithIdentifier:@"LocationCell"];
  [self configureCell:cell atIndexPath:indexPath];

  return cell;
}

- (void)configureCell:(UITableViewCell*)aCell
          atIndexPath:(NSIndexPath*)indexPath {
  Location* location =
      [self.fetchResultsController objectAtIndexPath:indexPath];
  LocationCell* cell = (LocationCell*)aCell;

  if ([location.locationDescription length] > 0) {
    cell.descriptionLabel.text = location.locationDescription;
  } else {
    cell.descriptionLabel.text = @"(No Description)";
  }

  if (location.placemark != nil) {
    NSMutableString* string = [NSMutableString stringWithCapacity:100];
    [string addText:location.placemark.subThoroughfare withSeparator:@""];
    [string addText:location.placemark.thoroughfare withSeparator:@" "];
    [string addText:location.placemark.locality withSeparator:@", "];

    cell.addressLabel.text = string;

  } else {
    cell.addressLabel.text =
        [NSString stringWithFormat:@"Lat:%.8f, Long: %.8f",
                                   [location.latitude doubleValue],
                                   [location.longitude doubleValue]];
  }

  UIImage* image = nil;
  if ([location hasPhoto]) {
    image = [location photoImage];
    if (image != nil) {
      image = [image resizedImageWithBounds:CGSizeMake(60, 60)];
    }
  }
    if (image==nil) {
        image=[UIImage imageNamed:@"No Photo"];
    }
  cell.thumbView.image = image;
    cell.thumbView.layer.cornerRadius=cell.thumbView.bounds.size.width/2.0f;
    cell.thumbView.clipsToBounds=YES;
    cell.separatorInset=UIEdgeInsetsMake(0, 82, 0, 0);
    
    cell.backgroundColor=[UIColor blackColor];
    cell.descriptionLabel.textColor=[UIColor whiteColor];
    cell.descriptionLabel.highlightedTextColor=cell.descriptionLabel.textColor;
    cell.addressLabel.textColor=[UIColor colorWithWhite:1.0f alpha:0.4f];
    cell.addressLabel.highlightedTextColor=cell.addressLabel.textColor;
    
    UIView* selectionView=[[UIView alloc] initWithFrame:CGRectZero];
    selectionView.backgroundColor=[UIColor colorWithWhite:1.0f alpha:0.2f];
    cell.selectedBackgroundView=selectionView;

}

- (void)tableView:(UITableView*)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
     forRowAtIndexPath:(NSIndexPath*)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    Location* location =
        [self.fetchResultsController objectAtIndexPath:indexPath];
    [location removePhotoFile];
    [self.managedObjectContext deleteObject:location];
    NSError* error;

    if (![self.managedObjectContext save:&error]) {
      abort();
      return;
    }
  }
}

@end
