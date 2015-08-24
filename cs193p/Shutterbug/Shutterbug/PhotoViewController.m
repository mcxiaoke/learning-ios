//
//  PhotoViewController.m
//  Shutterbug
//
//  Created by mcxiaoke on 15/8/23.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@property(weak, nonatomic) IBOutlet UILabel *descLabel;
@property(weak, nonatomic) IBOutlet UIImageView *imageView;
@property(weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@end

@implementation PhotoViewController

- (void)loadImage {
  if (self.imageURL) {
    self.indicator.hidden = NO;
    dispatch_queue_t queue = dispatch_queue_create("image", NULL);
    dispatch_async(queue, ^{
      NSData *data = [NSData dataWithContentsOfURL:self.imageURL];
      UIImage *image = [UIImage imageWithData:data];

      dispatch_async(dispatch_get_main_queue(), ^{
        self.imageView.image = image;
        self.indicator.hidden = YES;
      });
    });
  }
}

- (void)setImageURL:(NSURL *)imageURL {
  _imageURL = imageURL;
  [self loadImage];
}

- (void)onPinch:(UIPinchGestureRecognizer *)sender {
  if (self.imageView.image) {
    self.imageView.transform =
        CGAffineTransformMakeScale(sender.scale, sender.scale);
  }
}

- (void)onTap:(UITapGestureRecognizer *)sender {
  NSLog(@"onTap");
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  UITapGestureRecognizer *tap =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(onTap:)];
  UIPinchGestureRecognizer *pinch =
      [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(onPinch:)];
  pinch.scale = 1;

  [self.view addGestureRecognizer:tap];
  [self.view addGestureRecognizer:pinch];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
