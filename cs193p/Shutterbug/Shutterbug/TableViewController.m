//
//  TableViewController.m
//  Shutterbug
//
//  Created by mcxiaoke on 15/8/23.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "TableViewController.h"
#import "PhotoViewController.h"

#define PHOTOS_URL @"https://moment.douban.com/api/post/123306"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)setPhotos:(NSArray *)photos {
  _photos = photos;
  NSLog(@"setPhotos, count=%lu", [photos count]);
  [self.tableView reloadData];
}

- (void)fetchPhotos {
  self.photos = nil;
  [self.tableView beginUpdates];
  NSURLRequest *request =
      [NSURLRequest requestWithURL:[NSURL URLWithString:PHOTOS_URL]];
  NSOperationQueue *queue = [NSOperationQueue new];
  [NSURLConnection
      sendAsynchronousRequest:request
                        queue:queue
            completionHandler:^(NSURLResponse *response, NSData *data,
                                NSError *connectionError) {
              //
              //              NSString *content =
              //                  [[NSString alloc] initWithData:data
              //                                        encoding:NSUTF8StringEncoding];
              //              NSLog(@"received http response: %@", content);
              NSError *error;
              NSDictionary *dict =
                  [NSJSONSerialization JSONObjectWithData:data
                                                  options:0
                                                    error:&error];
              NSArray *photos = dict[@"photos"];
              //              NSLog(@"response photos: %@", photos);
              //              NSLog(@"response one photo: %@", photos[1]);

              dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView endUpdates];
                self.photos = photos;
              });

            }];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.refreshControl.tintColor = [UIColor purpleColor];
  [self.refreshControl addTarget:self
                          action:@selector(fetchPhotos)
                forControlEvents:UIControlEventValueChanged];
  [self fetchPhotos];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                      forIndexPath:indexPath];

  NSDictionary *photo = self.photos[indexPath.row];

  //  NSLog(@"cell photo=%@", photo);

  cell.textLabel.text = [NSString stringWithFormat:@"%@", photo[@"id"]];
  //  cell.detailTextLabel.text = photo[@"large"][@"url"];
  cell.detailTextLabel.text = [photo valueForKeyPath:@"large.url"];
  return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"showPhoto"] &&
      [sender isKindOfClass:[UITableViewCell class]]) {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    if (indexPath) {
      if ([segue.destinationViewController
              isKindOfClass:[PhotoViewController class]]) {
        NSDictionary *photo = self.photos[indexPath.row];
        PhotoViewController *pvc = segue.destinationViewController;
        pvc.imageURL =
            [NSURL URLWithString:[photo valueForKeyPath:@"large.url"]];
      }
    }
  }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath
*)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath]
withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the
array, and add a new row to the table view
    }
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath
*)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath
*)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
