//
//  DatePickerViewController.m
//  HelloDatePicker
//
//  Created by mcxiaoke on 15/8/20.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "DatePickerViewController.h"
#import "ViewController.h"

@interface DatePickerViewController ()
@property(weak, nonatomic) IBOutlet UIDatePicker* datePicker;

@end

@implementation DatePickerViewController

- (IBAction)setDateTime:(id)sender {
  UIDatePicker* picker = sender;

  ViewController* vc = self.delegate;
  [vc calculateDateDifference:picker.date];
}

- (IBAction)dismissDateChooser:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self.datePicker setDate:[NSDate new]];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  ViewController* vc = self.delegate;
  vc.dateChooserVisible = NO;
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
