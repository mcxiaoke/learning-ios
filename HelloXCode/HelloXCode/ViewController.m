//
//  ViewController.m
//  HelloXCode
//
//  Created by mcxiaoke on 15/8/17.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIButton *button3;

@property(weak, nonatomic) IBOutlet UILabel* centerLabel;
@end

@implementation ViewController
- (IBAction)button1:(UIButton *)sender {
}
- (IBAction)button2:(UIButton *)sender {
}

- (void)viewDidLoad {
  [super viewDidLoad];
  CGFloat x = self.centerLabel.frame.origin.x;
  CGFloat y =
      self.centerLabel.frame.origin.y + self.centerLabel.frame.size.height + 10;
  NSLog(@"%g-%g", self.centerLabel.frame.origin.x,
        self.centerLabel.frame.origin.y);
  UILabel* aLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 200, 40)];
  aLabel.textAlignment = NSTextAlignmentCenter;
  aLabel.backgroundColor = [UIColor blueColor];
  aLabel.textColor = [UIColor whiteColor];
  aLabel.text = @"a custom label";
  [self.view addSubview:aLabel];

  NSLog(@"%g-%g", aLabel.frame.origin.x, aLabel.frame.origin.y);
}

#pragma mark <label>

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
