//
//  ViewController.m
//  HelloSegue
//
//  Created by mcxiaoke on 15/8/19.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UILabel *bigLabel;

@end

@implementation ViewController

- (IBAction)exitHere:(id)sender {
}
- (IBAction)back:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setText:(NSString *)text {
  _text = text;
  if (self.view.window) {
    [self updateUI];
  }
}

- (void)updateUI {
  if (self.text) {
    self.bigLabel.text = self.text;
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self updateUI];
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
