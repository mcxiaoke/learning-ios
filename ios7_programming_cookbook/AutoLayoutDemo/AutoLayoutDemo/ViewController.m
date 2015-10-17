//
//  ViewController.m
//  AutoLayoutDemo
//
//  Created by mcxiaoke on 15/10/17.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "ViewController.h"

NSString* const kEmialTextFieldHorizontal = @"H:|-[_textFieldEmail]-|";
NSString* const kEmailTextFieldVertical = @"V:|-80-[_textFieldEmail]";

NSString* const kConfirmEmailHorizontal = @"H:|-[_textFieldConfirmEmail]-|";
NSString* const kConfirmEmailVertical =
    @"V:[_textFieldEmail]-20-[_textFieldConfirmEmail]";

NSString* const kRegisterVertical =
    @"V:[_textFieldConfirmEmail]-40-[_registerButton]";

@interface ViewController ()

@property(nonatomic, strong) UIButton* button;

@property(nonatomic, strong) UITextField* textFieldEmail;
@property(nonatomic, strong) UITextField* textFieldConfirmEmail;
@property(nonatomic, strong) UIButton* registerButton;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self showRegisterFromInVFL];
}

- (void)showRegisterFromInVFL {
  self.textFieldEmail = [self textFiedlWithPlaceHolder:@"Email"];
  self.textFieldConfirmEmail = [self textFiedlWithPlaceHolder:@"Confirm Email"];

  self.registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
  self.registerButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.registerButton setTitle:@"Register" forState:UIControlStateNormal];

  [self.view addSubview:self.textFieldEmail];
  [self.view addSubview:self.textFieldConfirmEmail];
  [self.view addSubview:self.registerButton];
  [self.view addConstraints:[self registerFormConstraints]];
}

- (NSArray*)registerFormConstraints {
  NSMutableArray* contraints = [[NSMutableArray alloc] init];
  [contraints addObjectsFromArray:[self emailTextFieldConstraints]];
  [contraints addObjectsFromArray:[self confirmEmailTextFieldConstraints]];
  [contraints addObjectsFromArray:[self registerButtonConstraints]];
  return [NSArray arrayWithArray:contraints];
}

- (NSArray*)emailTextFieldConstraints {
  NSMutableArray* cts = [[NSMutableArray alloc] init];

  NSDictionary* viewsDict = NSDictionaryOfVariableBindings(_textFieldEmail);
  [cts addObjectsFromArray:
           [NSLayoutConstraint
               constraintsWithVisualFormat:kEmialTextFieldHorizontal
                                   options:0
                                   metrics:nil
                                     views:viewsDict]];
  [cts addObjectsFromArray:
           [NSLayoutConstraint
               constraintsWithVisualFormat:kEmailTextFieldVertical
                                   options:0
                                   metrics:nil
                                     views:viewsDict]];

  return [NSArray arrayWithArray:cts];
}

- (NSArray*)confirmEmailTextFieldConstraints {
  NSMutableArray* cts = [[NSMutableArray alloc] init];

  NSDictionary* viewsDict =
      NSDictionaryOfVariableBindings(_textFieldConfirmEmail, _textFieldEmail);
  [cts addObjectsFromArray:
           [NSLayoutConstraint
               constraintsWithVisualFormat:kConfirmEmailHorizontal
                                   options:0
                                   metrics:nil
                                     views:viewsDict]];
  [cts addObjectsFromArray:[NSLayoutConstraint
                               constraintsWithVisualFormat:kConfirmEmailVertical
                                                   options:0
                                                   metrics:nil
                                                     views:viewsDict]];

  return [NSArray arrayWithArray:cts];
}

- (NSArray*)registerButtonConstraints {
  NSMutableArray* cts = [[NSMutableArray alloc] init];

  NSDictionary* viewsDict =
      NSDictionaryOfVariableBindings(_registerButton, _textFieldConfirmEmail);

  [cts addObject:[NSLayoutConstraint constraintWithItem:self.registerButton
                                              attribute:NSLayoutAttributeCenterX
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.view
                                              attribute:NSLayoutAttributeCenterX
                                             multiplier:1.0f
                                               constant:0.0f]];
  [cts addObjectsFromArray:[NSLayoutConstraint
                               constraintsWithVisualFormat:kRegisterVertical
                                                   options:0
                                                   metrics:nil
                                                     views:viewsDict]];

  return [NSArray arrayWithArray:cts];
}

- (UITextField*)textFiedlWithPlaceHolder:(NSString*)placeHolder {
  UITextField* textField = [[UITextField alloc] init];
  textField.translatesAutoresizingMaskIntoConstraints = NO;
  textField.borderStyle = UITextBorderStyleRoundedRect;
  textField.placeholder = placeHolder;
  return textField;
}

- (void)showCenterButton {
  self.button = [UIButton buttonWithType:UIButtonTypeSystem];
  self.button.translatesAutoresizingMaskIntoConstraints = NO;
  [self.button setTitle:@"Button" forState:UIControlStateNormal];
  [self.view addSubview:self.button];

  UIView* superView = self.button.superview;

  NSLayoutConstraint* centerXCt =
      [NSLayoutConstraint constraintWithItem:self.button
                                   attribute:NSLayoutAttributeCenterX
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:superView
                                   attribute:NSLayoutAttributeCenterX
                                  multiplier:1.0f
                                    constant:0.0f];

  NSLayoutConstraint* centerYCt =
      [NSLayoutConstraint constraintWithItem:self.button
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:superView
                                   attribute:NSLayoutAttributeCenterY
                                  multiplier:1.0f
                                    constant:0.0f];

  [superView addConstraints:@[ centerXCt, centerYCt ]];
}

@end
