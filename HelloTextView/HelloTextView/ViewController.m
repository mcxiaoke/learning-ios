//
//  ViewController.m
//  HelloTextView
//
//  Created by mcxiaoke on 15/8/17.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UITextField *thePlace;
@property(weak, nonatomic) IBOutlet UITextField *theVerb;
@property(weak, nonatomic) IBOutlet UITextField *theNumber;
@property(weak, nonatomic) IBOutlet UITextView *theTemplate;
@property(weak, nonatomic) IBOutlet UITextView *theStory;

@end

@implementation ViewController
- (IBAction)createStory:(UIButton *)sender {
  NSString *text = [self.theTemplate.text
      stringByReplacingOccurrencesOfString:@"<place>"
                                withString:self.thePlace.text];
  text = [text stringByReplacingOccurrencesOfString:@"<verb>"
                                         withString:self.theVerb.text];
  text = [text stringByReplacingOccurrencesOfString:@"<number>"
                                         withString:self.theNumber.text];
  self.theStory.text = text;
}
- (IBAction)hideKeyboard:(id)sender {
  [self.thePlace resignFirstResponder];
  [self.theVerb resignFirstResponder];
  [self.theNumber resignFirstResponder];
  [self.theTemplate resignFirstResponder];
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
