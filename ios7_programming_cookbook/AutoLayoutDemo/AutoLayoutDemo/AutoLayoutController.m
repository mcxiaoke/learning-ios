//
//  AutoLayoutController.m
//  AutoLayoutDemo
//
//  Created by mcxiaoke on 15/10/17.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "AutoLayoutController.h"

@interface AutoLayoutController ()

@property(nonatomic, strong) UIView* topGrayView;
@property(nonatomic, strong) UIButton* topButton;
@property(nonatomic, strong) UIView* bottomGrayView;
@property(nonatomic, strong) UIButton* bottomButton;

@end

@implementation AutoLayoutController

- (UIView*)newGrayView {
  UIView* view = [[UIView alloc] init];
  view.backgroundColor = [UIColor lightGrayColor];
  view.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:view];
  return view;
}

- (void)createGrayViews {
  self.topGrayView = [self newGrayView];
  self.bottomGrayView = [self newGrayView];
}

- (UIButton*)newButtonPlacedOnView:(UIView*)view {
  UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
  button.translatesAutoresizingMaskIntoConstraints = NO;
  [button setTitle:@"Button" forState:UIControlStateNormal];
  [view addSubview:button];
  return button;
}

- (void)createButtons {
  self.topButton = [self newButtonPlacedOnView:self.topGrayView];
  self.bottomButton = [self newButtonPlacedOnView:self.bottomGrayView];
}

- (void)applyConstraintsToTopGrayView {
  NSDictionary* views = NSDictionaryOfVariableBindings(_topGrayView);
  NSMutableArray* constraints = [[NSMutableArray alloc] init];
  NSString* const kHConstraint = @"H:|-[_topGrayView]-|";
  NSString* const kVConstraint = @"V:|-[_topGrayView(==100)]";

  [constraints addObjectsFromArray:[NSLayoutConstraint
                                       constraintsWithVisualFormat:kHConstraint
                                                           options:0
                                                           metrics:nil
                                                             views:views]];
  [constraints addObjectsFromArray:[NSLayoutConstraint
                                       constraintsWithVisualFormat:kVConstraint
                                                           options:0
                                                           metrics:nil
                                                             views:views]];
  [self.topGrayView.superview addConstraints:constraints];
}

- (void)applyConstraintsToButtonOnTopGrayView {
  NSDictionary* views = NSDictionaryOfVariableBindings(_topButton);
  NSMutableArray* constraints = [[NSMutableArray alloc] init];
  NSString* const kHConstraint = @"H:|-[_topButton]";
  [constraints addObjectsFromArray:[NSLayoutConstraint
                                       constraintsWithVisualFormat:kHConstraint
                                                           options:0
                                                           metrics:nil
                                                             views:views]];
  [constraints
      addObject:[NSLayoutConstraint constraintWithItem:self.topButton
                                             attribute:NSLayoutAttributeCenterY
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:self.topGrayView
                                             attribute:NSLayoutAttributeCenterY
                                            multiplier:1.0f
                                              constant:0.0f]];

  [self.topButton.superview addConstraints:constraints];
}

- (void)applyConstraintsToBottomGrayView {
  NSDictionary* views =
      NSDictionaryOfVariableBindings(_topGrayView, _bottomGrayView);
  NSMutableArray* constraints = [[NSMutableArray alloc] init];
  NSString* const kHConstraint = @"H:|-[_bottomGrayView]-|";
  NSString* const kVConstraint = @"V:|-[_topGrayView]-[_bottomGrayView(==100)]";

  [constraints addObjectsFromArray:[NSLayoutConstraint
                                       constraintsWithVisualFormat:kHConstraint
                                                           options:0
                                                           metrics:nil
                                                             views:views]];
  [constraints addObjectsFromArray:[NSLayoutConstraint
                                       constraintsWithVisualFormat:kVConstraint
                                                           options:0
                                                           metrics:nil
                                                             views:views]];

  [self.bottomGrayView.superview addConstraints:constraints];
}

- (void)applyConstraintsToButtonOnBottomGrayView {
  NSDictionary* views =
      NSDictionaryOfVariableBindings(_topButton, _bottomButton);
  NSString* const kHConstraint = @"H:[_topButton][_bottomButton]";
  [self.bottomGrayView.superview
      addConstraints:[NSLayoutConstraint
                         constraintsWithVisualFormat:kHConstraint
                                             options:0
                                             metrics:nil
                                               views:views]];
  [self.bottomButton.superview
      addConstraint:[NSLayoutConstraint
                        constraintWithItem:self.bottomButton
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.bottomGrayView
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0f
                                  constant:0.0f]];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self createGrayViews];
  [self createButtons];
  [self applyConstraintsToTopGrayView];
  [self applyConstraintsToButtonOnTopGrayView];
  [self applyConstraintsToBottomGrayView];
  [self applyConstraintsToButtonOnBottomGrayView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}


@end
