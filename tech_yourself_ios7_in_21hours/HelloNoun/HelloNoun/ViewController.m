//
//  ViewController.m
//  HelloNoun
//
//  Created by mcxiaoke on 15/8/17.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(weak, nonatomic) IBOutlet UILabel *label;
@property(strong, nonatomic) NSString *text;

@property(weak, nonatomic) IBOutlet UITextField *editText;
@end

@implementation ViewController

- (void)setText:(NSString *)text {
  self.label.text = text;
}

- (NSString *)text {
  return self.label.text;
}

- (IBAction)setButton:(UIButton *)sender {
  self.text = self.editText.text;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
