//
//  ViewController.m
//  HelloProgramingLayout
//
//  Created by mcxiaoke on 15/8/22.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(strong, nonatomic) UIButton* ba;
@property(strong, nonatomic) UIButton* bb;
@property(strong, nonatomic) UILabel* lb;

- (void)initUI;
- (void)updateUI;
- (void)onClick:(id)sender;

@end

@implementation ViewController

- (void)initUI {
  self.ba = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [self.ba addTarget:self
                action:@selector(onClick:)
      forControlEvents:UIControlEventTouchUpInside];
  [self.ba setTitle:@"Button A" forState:UIControlStateNormal];

  self.bb = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [self.bb addTarget:self
                action:@selector(onClick:)
      forControlEvents:UIControlEventTouchUpInside];
  [self.bb setTitle:@"Button B" forState:UIControlStateNormal];

  self.lb = [UILabel new];
  self.lb.text = @"WelCome";
  [self updateUI];
}

- (void)updateUI {
  float sw = [UIScreen mainScreen].bounds.size.width;
  float sh = [UIScreen mainScreen].bounds.size.height;

  UIInterfaceOrientation orientation = self.interfaceOrientation;
  NSLog(@"screen width=%f, height=%f, orientation=%ld", sw, sh, orientation);
  if (orientation == UIInterfaceOrientationPortrait ||
      orientation == UIInterfaceOrientationPortraitUpsideDown) {
    self.ba.frame = CGRectMake(20, 40, sw - 40, 40);
    self.bb.frame = CGRectMake(20, sh - 80, sw - 40, 40);
    self.lb.frame = CGRectMake(sw / 2 - 40, sh / 2 - 10, 200, 20);
  } else {
    self.ba.frame = CGRectMake(40, 40, sw - 80, 20);
    self.bb.frame = CGRectMake(40, sh - 60, sw - 80, 20);
    self.lb.frame = CGRectMake(sw / 2 - 40, sh / 2 - 10, 200, 20);
  }
  [self.ba setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  self.ba.backgroundColor = [UIColor greenColor];
  [self.bb setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  self.bb.backgroundColor = [UIColor blueColor];

  if (![[self.view subviews] containsObject:self.ba]) {
    [self.view addSubview:self.ba];
    [self.view addSubview:self.bb];
    [self.view addSubview:self.lb];
  }
  //  [self.view addSubview:self.ba];
  //  [self.view addSubview:self.bb];
  //  [self.view addSubview:self.lb];
}

- (void)onClick:(id)sender {
  UIButton* btn = sender;
  self.lb.text = btn.currentTitle;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initUI];
}

- (void)didRotateFromInterfaceOrientation:
    (UIInterfaceOrientation)fromInterfaceOrientation {
  //  [[self.view subviews]
  // makeObjectsPerformSelector:@selector(removeFromSuperview)];
  [self updateUI];
}

//- (NSUInteger)supportedInterfaceOrientations {
//  return UIInterfaceOrientationMaskAll;
//}

@end
