//
//  ViewController.m
//  HelloViews
//
//  Created by mcxiaoke on 15/8/15.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "ViewController.h"
#import "DemoView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  CGRect labelRect = CGRectMake(20, 20, 120, 40);
  UILabel* label = [[UILabel alloc] initWithFrame:labelRect];
  label.backgroundColor = [UIColor darkGrayColor];
  label.textAlignment = NSTextAlignmentCenter;
  label.textColor = [UIColor whiteColor];
  CGFloat fontSize = 18.0;
  label.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
  label.text = @"Hello, Label";

  UIView* demoView =
      [[DemoView alloc] initWithFrame:CGRectMake(40, 100, 300, 400)];
  [self.view addSubview:label];
  [self.view addSubview:demoView];
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
