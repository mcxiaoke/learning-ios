//
//  ViewController.m
//  HelloDatePicker
//
//  Created by mcxiaoke on 15/8/20.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "ViewController.h"
#import "DatePickerViewController.h"
#import "AnimalViewController.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UILabel *outLabel;
@property(weak, nonatomic) IBOutlet UILabel *animalLabel;

@end

@implementation ViewController

- (void)updateAnimalLabel:(NSString *)name {
}

- (void)updateAnimalLabel:(NSString *)name withSound:(NSString *)sound {
  self.animalLabel.text =
      [NSString stringWithFormat:@"Name: %@, Sound: %@", name, sound];
}

- (void)calculateDateDifference:(NSDate *)chosenDate {
  NSDate *today;
  NSString *diffOutput;
  NSString *todayString;
  NSString *chosenString;
  NSDateFormatter *dateFormat;
  NSTimeInterval diff;

  today = [NSDate date];
  diff = [today timeIntervalSinceDate:chosenDate] / 86400;
  dateFormat = [NSDateFormatter new];
  [dateFormat setDateFormat:@"MMMM d, yyyy hh:mm:ssa"];
  todayString = [dateFormat stringFromDate:today];
  chosenString = [dateFormat stringFromDate:chosenDate];
  diffOutput = [NSString
      stringWithFormat:
          @"Difference between chosen date (%@) and today (%@) in days: %1.2f",
          chosenString, todayString, fabs(diff)];
  self.outLabel.text = diffOutput;
}

- (IBAction)showDateChooser:(id)sender {
  if (self.dateChooserVisible != YES) {
    [self performSegueWithIdentifier:@"toDateChooser" sender:sender];
    self.dateChooserVisible = YES;
  }
}

- (IBAction)showAnimalPicker:(id)sender {
  if (self.animalChooserVisible != YES) {
    [self performSegueWithIdentifier:@"toAnimalChooser" sender:sender];
    self.animalChooserVisible = YES;
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"toDateChooser"]) {
    DatePickerViewController *dvc =
        (DatePickerViewController *)segue.destinationViewController;
    dvc.delegate = self;
  } else if ([segue.identifier isEqualToString:@"toAnimalChooser"]) {
    AnimalViewController *avc = segue.destinationViewController;
    avc.delegate = self;
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
