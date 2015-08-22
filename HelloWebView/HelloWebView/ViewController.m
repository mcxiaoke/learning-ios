//
//  ViewController.m
//  HelloWebView
//
//  Created by mcxiaoke on 15/8/18.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property(weak, nonatomic) IBOutlet UILabel *contentTitle;

@property(weak, nonatomic) IBOutlet UIWebView *webview;
@property(weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property(weak, nonatomic) IBOutlet UILabel *indicatorLabel;
@property(weak, nonatomic) IBOutlet UITextField *urlTextField;
@end

@implementation ViewController

- (void)webViewDidStartLoad:(UIWebView *)webView {
  [self.indicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  [self.indicatorView stopAnimating];
  NSString *theTitle =
      [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
  self.contentTitle.text = theTitle;
}

- (IBAction)go:(id)sender {
  if (self.urlTextField.text) {
    [self.urlTextField resignFirstResponder];
    NSURL *url = [NSURL URLWithString:self.urlTextField.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:request];
  }
}
- (IBAction)back:(id)sender {
  [self.webview goBack];
}
- (IBAction)forward:(id)sender {
  [self.webview goForward];
}
- (IBAction)refresh:(id)sender {
  [self.webview reload];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.indicatorView stopAnimating];
  self.indicatorLabel.text = nil;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.webview.delegate = self;
}

@end
