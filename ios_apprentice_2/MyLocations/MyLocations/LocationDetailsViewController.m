//
//  LocationDetailsViewController.m
//  MyLocations
//
//  Created by mcxiaoke on 15/9/21.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "AppDelegate.h"
#import "LocationDetailsViewController.h"
#import "CategoryPickerViewController.h"
#import "HudView.h"
#import "Location+CoreDataProperties.h"
#import "NSMutableString+AddText.h"

extern NSString *const ManagedObjectContextSaveDidFailNotification;

@interface LocationDetailsViewController ()<
    UITextViewDelegate, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate, UIActionSheetDelegate>

@property(weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property(weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property(weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property(weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property(weak, nonatomic) IBOutlet UILabel *addressLabel;
@property(weak, nonatomic) IBOutlet UILabel *dateLabel;

@property(nonatomic, weak) IBOutlet UIImageView *imageView;
@property(nonatomic, weak) IBOutlet UILabel *imageLabel;
@end

@implementation LocationDetailsViewController {
  NSString *_descriptionText;
  NSString *_categoryName;
  NSDate *_date;
  UIImage *_image;

  UIActionSheet *_actionSheet;
  UIImagePickerController *_imagePicker;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _descriptionText = @"";
    _categoryName = @"No Category";
    _date = [NSDate date];
  }
  return self;
}

- (IBAction)cancel:(id)sender {
  [self closeScreen];
}
- (IBAction)done:(id)sender {
  NSLog(@"Description '%@'", _descriptionText);
  HudView *hudView =
      [HudView hudInView:self.navigationController.view animated:YES];

  Location *location = nil;
  if (_locationToEdit != nil) {
    hudView.text = @"Updated";
    location = _locationToEdit;
  } else {
    hudView.text = @"Tagged";
    location = [NSEntityDescription
        insertNewObjectForEntityForName:@"Location"
                 inManagedObjectContext:self.managedObjectContext];
    location.photoId = @-1;
  }

  location.locationDescription = _descriptionText;
  location.category = _categoryName;
  location.latitude = @(self.coordinate.latitude);
  location.longitude = @(self.coordinate.longitude);
  location.date = _date;
  location.placemark = self.placemark;

  if (_image != nil) {
    if (![location hasPhoto]) {
      location.photoId = @([Location nextPhotoId]);
    }

    NSData *data = UIImageJPEGRepresentation(_image, 0.6);
    NSError *error;
    if (![data writeToFile:[location photoPath]
                   options:NSDataWritingAtomic
                     error:&error]) {
      NSLog(@"Error writing file: %@", error);
    } else {
      NSLog(@"write image to file: %@", [location photoPath]);
    }
  }

  NSError *error;
  if (![self.managedObjectContext save:&error]) {
    NSLog(@"Fatal Error in %s:%d %@", __FILE__, __LINE__, error);
    [[NSNotificationCenter defaultCenter]
        postNotificationName:ManagedObjectContextSaveDidFailNotification
                      object:error];
    return;
  }

  [self performSelector:@selector(closeScreen) withObject:nil afterDelay:0.6];
}

- (void)closeScreen {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setLocationToEdit:(Location *)newLocationToEdit {
  if (_locationToEdit != newLocationToEdit) {
    _locationToEdit = newLocationToEdit;
    _descriptionText = _locationToEdit.locationDescription;
    _categoryName = _locationToEdit.category;
    _date = _locationToEdit.date;
    self.coordinate =
        CLLocationCoordinate2DMake([_locationToEdit.latitude doubleValue],
                                   [_locationToEdit.longitude doubleValue]);
    self.placemark = _locationToEdit.placemark;
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.backgroundColor = [UIColor blackColor];
  self.tableView.separatorColor = [UIColor colorWithWhite:1.0f alpha:0.2f];
  self.descriptionTextView.textColor = [UIColor whiteColor];
  self.descriptionTextView.backgroundColor = [UIColor blackColor];
  self.imageLabel.textColor = [UIColor whiteColor];
  self.imageLabel.highlightedTextColor = self.imageLabel.textColor;
  self.addressLabel.textColor = [UIColor colorWithWhite:1.0f alpha:0.4f];
  self.addressLabel.highlightedTextColor = self.addressLabel.textColor;

  if (self.locationToEdit) {
    self.title = @"Edit Location";

    if ([self.locationToEdit hasPhoto]) {
      UIImage *existsImage = [self.locationToEdit photoImage];
      if (existsImage != nil) {
        [self showImage:existsImage];
      }
    }
  }

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
  self.dateLabel.text = [self formatDate:_date];

  UITapGestureRecognizer *gesture =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(hideKeyboard:)];
  gesture.cancelsTouchesInView = NO;
  [self.tableView addGestureRecognizer:gesture];

  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(applicationDidEnterBackground)
             name:UIApplicationDidEnterBackgroundNotification
           object:nil];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationDidEnterBackground {
  if (_imagePicker) {
    [self dismissViewControllerAnimated:NO completion:nil];
    _imagePicker = nil;
  }
  if (_actionSheet) {
    [_actionSheet dismissWithClickedButtonIndex:_actionSheet.cancelButtonIndex
                                       animated:NO];
    _actionSheet = nil;
  }
  [self.descriptionTextView resignFirstResponder];
}

- (void)showImage:(UIImage *)image {
  self.imageView.backgroundColor = [UIColor redColor];
  self.imageView.image = image;
  self.imageView.hidden = NO;
  self.imageView.frame = CGRectMake(10, 10, 260, 260);
  self.imageLabel.hidden = YES;
}

- (void)hideKeyboard:(UIGestureRecognizer *)gesture {
  CGPoint point = [gesture locationInView:self.tableView];
  NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
  if (indexPath != nil && indexPath.section == 0 && indexPath.row == 0) {
    return;
  }
  [self.descriptionTextView resignFirstResponder];
}

- (NSString *)stringFromPlacemark:(CLPlacemark *)placemark {
  NSMutableString *line = [NSMutableString stringWithCapacity:100];
  [line addText:placemark.subThoroughfare withSeparator:@""];
  [line addText:placemark.thoroughfare withSeparator:@" "];
  [line addText:placemark.locality withSeparator:@", "];
  [line addText:placemark.administrativeArea withSeparator:@", "];
  [line addText:placemark.postalCode withSeparator:@" "];
  [line addText:placemark.country withSeparator:@", "];
  return line;

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

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor blackColor];
    cell.textLabel.textColor = [UIColor whiteColor]; cell.textLabel.highlightedTextColor =
    cell.textLabel.textColor;
    cell.detailTextLabel.textColor =
    [UIColor colorWithWhite:1.0f alpha:0.4f];
    cell.detailTextLabel.highlightedTextColor = cell.detailTextLabel.textColor;
    UIView *selectionView = [[UIView alloc] initWithFrame:CGRectZero];
    selectionView.backgroundColor =
    [UIColor colorWithWhite:1.0f alpha:0.2f];
    cell.selectedBackgroundView = selectionView;

}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1 && !self.imageView.hidden) {
    return 20 + self.imageView.frame.size.height;
  } else if (indexPath.section == 2 && indexPath.row == 2) {
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

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0 || indexPath.section == 1) {
    return indexPath;
  } else {
    return nil;
  }
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0 && indexPath.row == 0) {
    [self.descriptionTextView becomeFirstResponder];
  } else if (indexPath.section == 1 && indexPath.row == 0) {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self showPhotoMenu];
  }
}

- (void)showPhotoMenu {
  if ([UIImagePickerController
          isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    _actionSheet = [[UIActionSheet alloc]

                 initWithTitle:nil
                      delegate:self
             cancelButtonTitle:@"Cancel"
        destructiveButtonTitle:nil
             otherButtonTitles:@"Take Photo", @"Choose Photo", nil];
    [_actionSheet showInView:self.view];
  } else {
    [self choosePhoto];
  }
}

- (void)takePhoto {
  _imagePicker = [[UIImagePickerController alloc] init];
  _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
  _imagePicker.delegate = self;
  _imagePicker.allowsEditing = YES;
  [self presentViewController:_imagePicker animated:YES completion:nil];
}

- (void)choosePhoto {
  _imagePicker = [[UIImagePickerController alloc] init];
  _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  _imagePicker.delegate = self;
  _imagePicker.allowsEditing = YES;
  [self presentViewController:_imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {
  _image = info[UIImagePickerControllerEditedImage];
  [self showImage:_image];
  [self.tableView reloadData];
  [self dismissViewControllerAnimated:YES completion:nil];
  _imagePicker = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [self dismissViewControllerAnimated:YES completion:nil];
  _imagePicker = nil;
}

- (void)actionSheet:(UIActionSheet *)actionSheet
    didDismissWithButtonIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 0) {
    [self takePhoto];
  } else if (buttonIndex == 1) {
    [self choosePhoto];
  }
  _actionSheet = nil;
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
