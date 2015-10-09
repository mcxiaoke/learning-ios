//
//  DetailViewController.m
//  StoreSearch
//
//  Created by mcxiaoke on 15/10/10.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "DetailViewController.h"
#import "SearchResult.h"
#import <QuartzCore/QuartzCore.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface DetailViewController ()<UIGestureRecognizerDelegate>
@property(weak, nonatomic) IBOutlet UIView *popupView;

@property(weak, nonatomic) IBOutlet UIImageView *artworkImageView;
@property(weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property(weak, nonatomic) IBOutlet UILabel *kindLabel;
@property(weak, nonatomic) IBOutlet UILabel *genreLabel;
@property(weak, nonatomic) IBOutlet UIButton *priceButton;
@end

@implementation DetailViewController
- (IBAction)openInStore:(id)sender {
  [[UIApplication sharedApplication]
      openURL:[NSURL URLWithString:self.searchResult.storeURL]];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor clearColor];
  //  UIImage *image = [[UIImage imageNamed:@"PriceButton"]
  //      resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
  //  [self.priceButton setBackgroundImage:image forState:UIControlStateNormal];
  self.view.tintColor = [UIColor colorWithRed:20 / 255.0f
                                        green:160 / 255.0f
                                         blue:160 / 255.0f
                                        alpha:1.0f];
  self.popupView.layer.cornerRadius = 10.0f;

  UITapGestureRecognizer *gestureRecognizer =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(close:)];
  gestureRecognizer.cancelsTouchesInView = NO;
  gestureRecognizer.delegate = self;
  [self.view addGestureRecognizer:gestureRecognizer];

  if (self.searchResult) {
    [self updateUI];
  }
}

- (void)updateUI {
  self.nameLabel.text = self.searchResult.name;
  NSString *artistName = self.searchResult.artistName;
  if (!artistName) {
    artistName = @"Unknown";
  }

  self.artistNameLabel.text = artistName;
  self.kindLabel.text = [self.searchResult kindForDisplay];
  self.genreLabel.text = self.searchResult.genre;

  NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
  [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
  [formatter setCurrencyCode:self.searchResult.currency];

  NSString *priceText;
  if ([self.searchResult.price floatValue] == 0.0f) {
    priceText = @"Free";
  } else {
    priceText = [formatter stringFromNumber:self.searchResult.price];
  }

  [self.priceButton setTitle:priceText forState:UIControlStateNormal];

  [self.artworkImageView
      setImageWithURL:[NSURL URLWithString:self.searchResult.artworkURL100]];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
  return (touch.view == self.view);
}

- (void)dealloc {
  NSLog(@"dealloc");
  [self.artworkImageView cancelImageRequestOperation];
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
- (IBAction)close:(id)sender {
  [self dismissFromParentViewController];
}

- (void)presentInParentViewController:(UIViewController *)parentViewController {
  self.view.frame = parentViewController.view.bounds;
  [parentViewController.view addSubview:self.view];
  [parentViewController addChildViewController:self];

  CAKeyframeAnimation *bounceAnimation =
      [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
  bounceAnimation.duration = 0.4;
  bounceAnimation.delegate = self;
  bounceAnimation.values = @[ @0.7, @1.2, @0.9, @1.0 ];
  bounceAnimation.keyTimes = @[ @0.0, @0.334, @0.666, @1.0 ];

  bounceAnimation.timingFunctions = @[
    [CAMediaTimingFunction
        functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
    [CAMediaTimingFunction
        functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]

  ];
  [self.popupView.layer addAnimation:bounceAnimation forKey:@"bounceAnimation"];

  //  [self didMoveToParentViewController:parentViewController];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
  [self didMoveToParentViewController:self.parentViewController];
}

- (void)dismissFromParentViewController {
  [self willMoveToParentViewController:nil];
  [self.view removeFromSuperview];
  [self removeFromParentViewController];
}

@end
