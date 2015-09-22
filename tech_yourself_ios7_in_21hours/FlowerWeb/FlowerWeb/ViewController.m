//
//  ViewController.m
//  FlowerWeb
//
//  Created by mcxiaoke on 15/8/18.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property(weak, nonatomic) IBOutlet UISegmentedControl* colorChoice;
@property(weak, nonatomic) IBOutlet UIWebView* flowerView;
@property(weak, nonatomic) IBOutlet UIWebView* flowerDetailView;

@property(weak, nonatomic) IBOutlet UIActivityIndicatorView* progressBar;
@end

@implementation ViewController

- (void)webViewDidStartLoad:(UIWebView*)webView {
  self.progressBar.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView*)webView {
  self.progressBar.hidden = YES;
}

- (IBAction)toggleFlowerDetail:(UISwitch*)sender {
  self.flowerDetailView.hidden = !sender.isOn;
}
- (IBAction)changeColor:(UISegmentedControl*)sender {
  [self changePhoto];
}
- (IBAction)getFlowers:(UIButton*)sender {
  [self changePhoto];
}

- (void)changePhoto {
  NSURL* imageURL;
  NSURL* detailURL;
  NSString* imageURLString;
  NSString* detailURLString;
  NSString* color;
  int sessionId = random() % 50000;

  color = [self.colorChoice
      titleForSegmentAtIndex:self.colorChoice.selectedSegmentIndex];
  imageURLString =
      [NSString stringWithFormat:@"http://www.floraphotographs.com/"
                                 @"showrandomios.php?color=%@&session=%d",
                                 color, sessionId];
  detailURLString =
      [NSString stringWithFormat:@"http://www.floraphotographs.com/"
                                 @"detailios.php?session=%d",
                                 sessionId];
  imageURL = [NSURL URLWithString:imageURLString];
  detailURL = [NSURL URLWithString:detailURLString];
  [self.flowerView loadRequest:[NSURLRequest requestWithURL:imageURL]];
  [self.flowerDetailView loadRequest:[NSURLRequest requestWithURL:detailURL]];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.progressBar.hidden = YES;
  self.flowerView.delegate = self;
  self.flowerDetailView.hidden = YES;
  [self getFlowers:nil];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
