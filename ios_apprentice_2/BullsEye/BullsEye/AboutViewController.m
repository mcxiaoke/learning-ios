//
//  AboutViewController.m
//  BullsEye
//
//  Created by mcxiaoke on 15/9/18.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property(weak, nonatomic) IBOutlet UIWebView* webview;

@end

@implementation AboutViewController
- (IBAction)onBackPressed:(UIButton*)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  NSString* htmlFile =
      [[NSBundle mainBundle] pathForResource:@"BullsEye" ofType:@"html"];
  NSData* htmlData = [NSData dataWithContentsOfFile:htmlFile];
  NSURL* baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
  [self.webview loadData:htmlData
                MIMEType:@"text/html"
        textEncodingName:@"UTF-8"
                 baseURL:baseURL];
}

@end
