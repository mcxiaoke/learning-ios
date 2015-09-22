//
//  NounViewController.m
//  HelloNoun
//
//  Created by mcxiaoke on 15/8/17.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "NounViewController.h"

@interface NounViewController ()<UITextFieldDelegate>

@property(nonatomic, weak) IBOutlet UILabel* userOutput;
@property(nonatomic, weak) IBOutlet UITextField* userInput;

@end

@implementation NounViewController

- (IBAction)setOutput:(UIButton*)sender {
  self.userOutput.text = self.userInput.text;
}

- (IBAction)setOutput2:(UIButton*)sender {
  self.userOutput.text = self.userInput.text;
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
  if (textField == self.userInput) {
    [textField resignFirstResponder];
    self.userOutput.text = textField.text;
    return NO;
  }
  return YES;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.userInput.delegate = self;
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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

@end
