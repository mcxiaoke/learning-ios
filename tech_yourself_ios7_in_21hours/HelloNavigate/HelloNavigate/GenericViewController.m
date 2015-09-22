//
//  GenericViewController.m
//  HelloNavigate
//
//  Created by mcxiaoke on 15/8/20.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "GenericViewController.h"

@interface GenericViewController ()
@property(weak, nonatomic) IBOutlet UILabel* countLabel;

@end

@implementation GenericViewController
- (IBAction)incrementCount:(id)sender {
  CountingViewController* cv =
      (CountingViewController*)self.parentViewController;
  cv.pushCount++;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  CountingViewController* cv =
      (CountingViewController*)self.parentViewController;
  NSString* pushText = [NSString stringWithFormat:@"%d", cv.pushCount];
  self.countLabel.text = pushText;
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
