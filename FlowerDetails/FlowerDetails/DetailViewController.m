//
//  DetailViewController.m
//  FlowerDetails
//
//  Created by mcxiaoke on 15/8/22.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property(weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(NSDictionary *)newDetailItem {
  if (_detailItem != newDetailItem) {
    _detailItem = newDetailItem;

    // Update the view.
    [self configureView];
  }
}

- (void)configureView {
  // Update the user interface for the detail item.
  if (self.detailItem) {
    self.navigationItem.title = self.detailItem[@"name"];
    NSURL *url = [[NSURL alloc] initWithString:self.detailItem[@"url"]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.webView.scalesPageToFit = YES;
  [self configureView];
}

@end
