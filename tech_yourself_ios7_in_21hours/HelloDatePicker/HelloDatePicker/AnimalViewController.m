//
//  AnimalViewController.m
//  HelloDatePicker
//
//  Created by mcxiaoke on 15/8/20.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "AnimalViewController.h"
#import "ViewController.h"

#define kComponentCount 2
#define kAnimalComponent 0
#define kSoundComponent 1

@interface AnimalViewController ()

@property(strong, nonatomic) NSArray* animalNames;
@property(strong, nonatomic) NSArray* animalSounds;
@property(strong, nonatomic) NSArray* animalImages;
@property(weak, nonatomic) IBOutlet UIPickerView* aPicker;

@end

@implementation AnimalViewController

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView {
  return kComponentCount;
}

- (NSInteger)pickerView:(UIPickerView*)pickerView
numberOfRowsInComponent:(NSInteger)component {
  if (component == kAnimalComponent) {
    return [self.animalNames count];
  } else {
    return [self.animalSounds count];
  }
}

- (UIView*)pickerView:(UIPickerView*)pickerView
           viewForRow:(NSInteger)row
         forComponent:(NSInteger)component
          reusingView:(UIView*)view {
  if (component == kAnimalComponent) {
    UIImageView* iv = self.animalImages[row];
    UIImageView* wkImageView = [[UIImageView alloc] initWithFrame:iv.frame];
    wkImageView.backgroundColor = [UIColor colorWithPatternImage:iv.image];
    return wkImageView;
  } else {
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 32)];
    label.backgroundColor = [UIColor clearColor];
    label.text = self.animalSounds[row];
    return label;
  }
}

- (CGFloat)pickerView:(UIPickerView*)pickerView
rowHeightForComponent:(NSInteger)component {
  return 50;
}

- (CGFloat)pickerView:(UIPickerView*)pickerView
    widthForComponent:(NSInteger)component {
  if (component == kAnimalComponent) {
    return 75.0;
  } else {
    return 150.0;
  }
}

- (void)pickerView:(UIPickerView*)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
  ViewController* vc = self.delegate;
  NSInteger nameIndex = [pickerView selectedRowInComponent:kAnimalComponent];
  NSInteger soundIndex = [pickerView selectedRowInComponent:kSoundComponent];
  [vc updateAnimalLabel:self.animalNames[nameIndex]
              withSound:self.animalSounds[soundIndex]];
}

- (IBAction)onDone:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.animalNames =
      @[ @"Mouse", @"Goose", @"Cat", @"Dog", @"Snake", @"Bear", @"Pig" ];
  self.animalSounds =
      @[ @"Oink", @"Rawr", @"Ssss", @"Roof", @"Meow", @"Honk", @"Squeak" ];

  NSMutableArray* images = [[NSMutableArray alloc] init];
  for (int i = 0; i < [self.animalNames count]; i++) {
    NSString* name = [self.animalNames objectAtIndex:i];
    NSString* imageName =
        [NSString stringWithFormat:@"%@.png", [name lowercaseString]];
    [images addObject:[[UIImageView alloc]
                          initWithImage:[UIImage imageNamed:imageName]]];
  }
  self.animalImages = [images copy];
  self.aPicker.delegate = self;
  self.aPicker.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  ViewController* vc = self.delegate;
  [vc updateAnimalLabel:self.animalNames[0] withSound:self.animalSounds[0]];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  ViewController* vc = self.delegate;
  vc.animalChooserVisible = NO;
}

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
