//
//  ViewController.m
//  Attributor
//
//  Created by mcxiaoke on 15/8/2.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UILabel *headline;
@property(weak, nonatomic) IBOutlet UITextView *body;
@property(weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // only once
  // bounds not set yet.
  // do not initialize geometry-dependent things.
  NSMutableAttributedString *title = [[NSMutableAttributedString alloc]
      initWithString:self.outlineButton.currentTitle];
  [title setAttributes:@{
    NSStrokeWidthAttributeName : @3,
    NSStrokeColorAttributeName : self.outlineButton.tintColor
  } range:NSMakeRange(0, [title length])];
  [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
}

- (void)viewWillLayoutSubviews {
}

- (void)viewDidLayoutSubviews {
}

- (void)preferredContentSizeChanged:(NSNotification *)notification {
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(preferredContentSizeChanged:)
             name:UIContentSizeCategoryDidChangeNotification
           object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [[NSNotificationCenter defaultCenter]
      removeObserver:self
                name:UIContentSizeCategoryDidChangeNotification
              object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
}

- (void)changeSelectionTextColor:(UIButton *)sender {
  [self.body.textStorage addAttribute:NSForegroundColorAttributeName
                                value:sender.backgroundColor
                                range:self.body.selectedRange];
}
- (IBAction)redSelection:(UIButton *)sender {
  [self changeSelectionTextColor:sender];
}
- (IBAction)greenSelection:(UIButton *)sender {
  [self changeSelectionTextColor:sender];
}
- (IBAction)orangeSelection:(UIButton *)sender {
  [self changeSelectionTextColor:sender];
}
- (IBAction)purpleSelection:(UIButton *)sender {
  [self changeSelectionTextColor:sender];
}

- (IBAction)outlineSelection:(UIButton *)sender {
  [self.body.textStorage addAttributes:@{
    NSStrokeWidthAttributeName : @-3,
    NSStrokeColorAttributeName : [UIColor yellowColor],

  } range:self.body.selectedRange];
}
- (IBAction)unOutlineSelection:(UIButton *)sender {
  [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName
                                   range:self.body.selectedRange];
}

@end
