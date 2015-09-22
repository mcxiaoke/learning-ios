//
//  ViewController.m
//  HelloAlert
//
//  Created by mcxiaoke on 15/8/19.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "ViewController.h"
@import AudioToolbox;

@interface ViewController ()<UIAlertViewDelegate, UIActionSheetDelegate>

@end

@implementation ViewController

- (void)actionSheet:(UIActionSheet*)actionSheet
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  NSLog(@" action sheet [%@] clicked: %@", [actionSheet title],
        [actionSheet buttonTitleAtIndex:buttonIndex]);
}

- (void)alertView:(UIAlertView*)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  NSLog(@" button [%@] clicked: %@", [alertView title],
        [alertView buttonTitleAtIndex:buttonIndex]);
  @try {
    NSString* field0 = [[alertView textFieldAtIndex:0] text];
    NSString* field1 = [[alertView textFieldAtIndex:1] text];
    NSLog(@"button [%@] text: %@, %@", [alertView title], field0, field1);
  } @catch (NSException* exception) {
    NSLog(@"exception: %@", exception);
  }
}

- (IBAction)button1:(id)sender {
  UIAlertView* alert =
      [[UIAlertView alloc] initWithTitle:@"AlertMe"
                                 message:@"Hello, this is a alert message!"
                                delegate:self
                       cancelButtonTitle:@"Cancel"
                       otherButtonTitles:nil];
  alert.alertViewStyle = UIAlertViewStyleDefault;
  [alert show];
}
- (IBAction)button2:(id)sender {
  UIAlertView* alert = [[UIAlertView alloc]
          initWithTitle:@"PlainText Demo"
                message:@"Hello, buttons!"
               delegate:self
      cancelButtonTitle:@"Cancel"
      otherButtonTitles:@"Ok", @"Another Button", @"Maybe later", nil];
  alert.alertViewStyle = UIAlertViewStyleDefault;
  [alert show];
}
- (IBAction)button3:(id)sender {
  UIAlertView* alert =
      [[UIAlertView alloc] initWithTitle:@"SecureText Demo"
                                 message:@"Hello, this is a secure text!"
                                delegate:self
                       cancelButtonTitle:@"Cancel"
                       otherButtonTitles:@"Ok", nil];
  alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
  [alert show];
}
- (IBAction)button4:(id)sender {
  UIAlertView* alert = [[UIAlertView alloc]
          initWithTitle:@"LoginPassword Demo"
                message:@"Hello, this is a login password text!"
               delegate:self
      cancelButtonTitle:@"Cancel"
      otherButtonTitles:@"Ok", nil];
  alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
  [alert show];
  [[UIApplication sharedApplication] setApplicationIconBadgeNumber:10];
}
- (IBAction)button5:(id)sender {
  SystemSoundID soundId;
  NSString* soundFile =
      [[NSBundle mainBundle] pathForResource:@"Sounds/soundeffect"
                                      ofType:@"wav"];
  NSLog(@"sound file is %@", soundFile);
  AudioServicesCreateSystemSoundID(
      (__bridge CFURLRef)[NSURL fileURLWithPath:soundFile], &soundId);
  AudioServicesPlaySystemSound(soundId);
  // vibrate
  // AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
- (IBAction)button6:(id)sender {
  UIActionSheet* sheet =
      [[UIActionSheet alloc] initWithTitle:@"Sheet Title"
                                  delegate:self
                         cancelButtonTitle:@"Cancel"
                    destructiveButtonTitle:@"Destructive"
                         otherButtonTitles:@"Action One", @"Action Two",
                                           @"Action Thress", nil];
  sheet.actionSheetStyle = UIActionSheetStyleDefault;
  //  [sheet showInView:self.view];
  [sheet showFromRect:[(UIButton*)sender frame] inView:self.view animated:YES];
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
