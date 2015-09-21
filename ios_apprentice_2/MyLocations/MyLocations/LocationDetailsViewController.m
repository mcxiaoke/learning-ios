//
//  LocationDetailsViewController.m
//  MyLocations
//
//  Created by mcxiaoke on 15/9/21.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "LocationDetailsViewController.h"
#import "CategoryPickerViewController.h"

@interface LocationDetailsViewController ()<UITextViewDelegate>
@property(weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property(weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property(weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property(weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property(weak, nonatomic) IBOutlet UILabel *addressLabel;
@property(weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation LocationDetailsViewController {
  NSString *_descriptionText;
  NSString *_categoryName;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _descriptionText = @"";
    _categoryName = @"No Category";
  }
  return self;
}

- (IBAction)cancel:(id)sender {
  [self closeScreen];
}
- (IBAction)done:(id)sender {
  NSLog(@"Description '%@'", _descriptionText);
  [self closeScreen];
}

- (void)closeScreen {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.descriptionTextView.delegate = self;
  self.descriptionTextView.text = _descriptionText;
  self.categoryLabel.text = _categoryName;
  self.latitudeLabel.text =
      [NSString stringWithFormat:@"%.8f", self.coordinate.latitude];
  self.longitudeLabel.text =
      [NSString stringWithFormat:@"%.8f", self.coordinate.longitude];
  if (self.placemark) {
    self.addressLabel.text = [self stringFromPlacemark:self.placemark];
  } else {
    self.addressLabel.text = @"No Address Found";
  }
  self.dateLabel.text = [self formatDate:[NSDate date]];
}

- (NSString *)stringFromPlacemark:(CLPlacemark *)placemark {
  return [NSString
      stringWithFormat:@"%@ %@\n%@ %@ %@", placemark.subThoroughfare,
                       placemark.thoroughfare, placemark.locality,
                       placemark.administrativeArea, placemark.postalCode];
}

- (NSString *)formatDate:(NSDate *)date {
  static NSDateFormatter *formatter = nil;
  if (!formatter) {
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
  }
  return [formatter stringFromDate:date];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"PickCategory"]) {
    CategoryPickerViewController *controller = segue.destinationViewController;
    controller.selectedCategoryName = _categoryName;
  }
}

- (IBAction)categoryPickerDidPickCategory:(UIStoryboardSegue *)segue {
  CategoryPickerViewController *controller = segue.sourceViewController;
  _categoryName = controller.selectedCategoryName;
  self.categoryLabel.text = _categoryName;
}

#pragma mark - table view

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 2 && indexPath.row == 2) {
    CGRect rect = CGRectMake(100, 10, 260, 10000);
    self.addressLabel.frame = rect;
    [self.addressLabel sizeToFit];
    rect.size.height = self.addressLabel.frame.size.height;
    self.addressLabel.frame = rect;
    //    return self.addressLabel.frame.size.height + 20;
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
  } else {
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
  }
}

#pragma mark - textview delegate

- (BOOL)textView:(UITextView *)textView
    shouldChangeTextInRange:(NSRange)range
            replacementText:(NSString *)text {
  _descriptionText =
      [textView.text stringByReplacingCharactersInRange:range withString:text];
  return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
  _descriptionText = textView.text;
}

@end
