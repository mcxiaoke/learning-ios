//
//  ViewController.m
//  ImageHop
//
//  Created by mcxiaoke on 15/8/18.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic) float animSpeed;
@property(weak, nonatomic) IBOutlet UILabel *hpsLabel;
@property(weak, nonatomic) IBOutlet UIImageView *rabbit1;
@property(weak, nonatomic) IBOutlet UIImageView *rabbit2;
@property(weak, nonatomic) IBOutlet UIImageView *rabbit3;
@property(weak, nonatomic) IBOutlet UIImageView *rabbit4;
@property(weak, nonatomic) IBOutlet UIImageView *rabbit5;
@property(weak, nonatomic) IBOutlet UILabel *speedLabel;
@property(weak, nonatomic) IBOutlet UITextField *inputField;
@property(weak, nonatomic) IBOutlet UISlider *slider;
@property(weak, nonatomic) IBOutlet UIStepper *stepper;
@property(weak, nonatomic) IBOutlet UIButton *btnClick;

@end

@implementation ViewController

- (void)startAnim {
  self.rabbit1.animationDuration = self.animSpeed;
  self.rabbit2.animationDuration = self.animSpeed;
  self.rabbit3.animationDuration = self.animSpeed;
  self.rabbit4.animationDuration = self.animSpeed;
  self.rabbit5.animationDuration = self.animSpeed;
  [self.rabbit1 startAnimating];
  [self.rabbit2 startAnimating];
  [self.rabbit3 startAnimating];
  [self.rabbit4 startAnimating];
  [self.rabbit5 startAnimating];
  [self.btnClick setTitle:@"Sit!" forState:UIControlStateNormal];
}

- (void)stopAnim {
  [self.rabbit1 stopAnimating];
  [self.rabbit2 stopAnimating];
  [self.rabbit3 stopAnimating];
  [self.rabbit4 stopAnimating];
  [self.rabbit5 stopAnimating];
  [self.btnClick setTitle:@"Hop!" forState:UIControlStateNormal];
}

- (void)toggleAnim {
  [self.rabbit1 isAnimating] ? [self stopAnim] : [self startAnim];
}

- (void)setAnimSpeed:(float)animSpeed {
  _animSpeed = animSpeed;
  self.hpsLabel.text = [NSString stringWithFormat:@"%1.2f hps", 1 / animSpeed];
  self.speedLabel.text = [NSString stringWithFormat:@"Speed: %1.2f", animSpeed];
  self.inputField.text = [NSString stringWithFormat:@"%1.2f", animSpeed];
}

- (IBAction)toggleAnimation:(UIButton *)sender {
  [self toggleAnim];
}
- (IBAction)setSpeed:(UISlider *)sender {
  self.animSpeed = 2 - self.slider.value;
  if (![self.rabbit1 isAnimating]) {
    [self startAnim];
  }
}
- (IBAction)setIncrement:(UIStepper *)sender {
  self.slider.value = self.stepper.value;
  [self setSpeed:nil];
}
- (IBAction)inputSpeed:(UITextField *)sender {
  if (sender.text) {
    self.animSpeed = [self.inputField.text floatValue];
    [self.inputField resignFirstResponder];
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  NSArray *animation = @[
    [UIImage imageNamed:@"frame-1.png"],
    [UIImage imageNamed:@"frame-2.png"],
    [UIImage imageNamed:@"frame-3.png"],
    [UIImage imageNamed:@"frame-4.png"],
    [UIImage imageNamed:@"frame-5.png"],
    [UIImage imageNamed:@"frame-6.png"],
    [UIImage imageNamed:@"frame-7.png"],
    [UIImage imageNamed:@"frame-8.png"],
    [UIImage imageNamed:@"frame-9.png"],
    [UIImage imageNamed:@"frame-10.png"],
    [UIImage imageNamed:@"frame-11.png"],
    [UIImage imageNamed:@"frame-12.png"],
    [UIImage imageNamed:@"frame-13.png"],
    [UIImage imageNamed:@"frame-14.png"],
    [UIImage imageNamed:@"frame-15.png"],
    [UIImage imageNamed:@"frame-16.png"],
    [UIImage imageNamed:@"frame-17.png"],
    [UIImage imageNamed:@"frame-18.png"],
    [UIImage imageNamed:@"frame-19.png"],
    [UIImage imageNamed:@"frame-20.png"],
  ];
  self.rabbit1.animationImages = animation;
  self.rabbit2.animationImages = animation;
  self.rabbit3.animationImages = animation;
  self.rabbit4.animationImages = animation;
  self.rabbit5.animationImages = animation;

  self.animSpeed = 1;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

@end
