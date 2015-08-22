//
//  SecondViewController.m
//  HelloSegue
//
//  Created by mcxiaoke on 15/8/19.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "SecondViewController.h"
#import "ViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
- (IBAction)goBackToFirst:(UIButton *)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)toThird:(id)sender {
  UIStoryboard *thirdBoard =
      [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  ViewController *thirdVc =
      [thirdBoard instantiateViewControllerWithIdentifier:@"stThird"];
  thirdVc.text = @"Text From Second View Controller";
  thirdVc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
  thirdVc.modalPresentationStyle = UIModalPresentationFormSheet;
  [self presentViewController:thirdVc animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  ViewController *third = (ViewController *)segue.destinationViewController;
  NSLog(@"prepareForSegue: %@", third.text);
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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
