//
//  ViewController.m
//  HelloGesture
//
//  Created by mcxiaoke on 15/8/23.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UILabel *label;

@property(weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic) CGRect originalRect;

@end

@implementation ViewController
- (IBAction)onTap:(UITapGestureRecognizer *)sender {
  self.label.text = @"Tapped";
}
- (IBAction)onSwipe:(UISwipeGestureRecognizer *)sender {
  self.label.text = @"Swipped";
}
- (IBAction)onPinch:(UIPinchGestureRecognizer *)sender {
  NSString *feedback;
  double scale;
  scale = sender.scale;
  self.imageView.transform = CGAffineTransformMakeRotation(0.0);
  feedback = [NSString stringWithFormat:@"Pinched, Scale:%1.2f, Velocity:%1.2f",
                                        sender.scale, sender.velocity];
  self.label.text = feedback;
  //  self.imageView.frame =
  //      CGRectMake(self.originalRect.origin.x, self.originalRect.origin.y,
  //                 self.originalRect.size.width * scale,
  //                 self.originalRect.size.height * scale);
  self.imageView.transform = CGAffineTransformMakeScale(scale, scale);
}
- (IBAction)onRatation:(UIRotationGestureRecognizer *)sender {
  NSString *feedback;
  double rotation;

  rotation = sender.rotation;
  feedback =
      [NSString stringWithFormat:@"Rotated, Radians:%1.2f, Velocity:%1.2f",
                                 sender.rotation, sender.velocity];
  self.label.text = feedback;
  self.imageView.transform = CGAffineTransformMakeRotation(rotation);
}

- (IBAction)onPan:(UIPanGestureRecognizer *)sender {
//  CGPoint point = [sender translationInView:self.view];
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  self.originalRect = self.imageView.frame;
  UIImageView *tempImageView =
      [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flower.png"]];
  tempImageView.frame = self.originalRect;
  [self.view addSubview:tempImageView];
  self.imageView = tempImageView;
  UIPinchGestureRecognizer *gsPinch =
      [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(onPinch:)];
  gsPinch.scale = 1;
  [self.view addGestureRecognizer:gsPinch];

  UIRotationGestureRecognizer *gsRotate = [[UIRotationGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(onRatation:)];
  gsRotate.rotation = 0;
  [self.view addGestureRecognizer:gsRotate];

  UIPanGestureRecognizer *gsPan =
      [[UIPanGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(onPan:)];
  [self.view addGestureRecognizer:gsPan];
}

@end
