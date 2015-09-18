//
//  ViewController.m
//  BullsEye
//
//  Created by mcxiaoke on 15/9/10.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "ViewController.h"
#import "Game.h"

@interface ViewController ()<UIAlertViewDelegate>
@property(weak, nonatomic) IBOutlet UILabel *valueLabel;
@property(weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property(weak, nonatomic) IBOutlet UILabel *roundLabel;
@property(weak, nonatomic) IBOutlet UISlider *slider;

@property(strong, nonatomic) Game *game;

@end

@implementation ViewController

- (Game *)game {
  if (!_game) {
    _game = [[Game alloc] init];
  }
  return _game;
}

- (IBAction)onSliderValueChanged:(UISlider *)sender {
}

- (IBAction)onHitClick:(UIButton *)sender {
  int newValue = (int)(self.slider.value);
  int newScore = [self.game calculate:newValue];
  [self showAlertFor:newValue and:newScore];
}
- (IBAction)onResetClick:(UIButton *)sender {
  [self.game reset];
  [self updateUI];
}
- (IBAction)onInfoClick:(UIButton *)sender {
}

- (void)showAlertFor:(int)value and:(int)score {
  NSString *title = [self.game alertMessageFor:score];
  NSString *message = [NSString
      stringWithFormat:@"Your Value is %d, Score is %d", value, score];
  [[[UIAlertView alloc] initWithTitle:title
                              message:message
                             delegate:self
                    cancelButtonTitle:@"Ok"
                    otherButtonTitles:nil, nil] show];
}

- (void)alertView:(UIAlertView *)alertView
    didDismissWithButtonIndex:(NSInteger)buttonIndex {
  [self newGame];
}

- (void)updateUI {
  self.valueLabel.text = [NSString stringWithFormat:@"%d", self.game.value];
  self.scoreLabel.text =
      [NSString stringWithFormat:@"Score: %d", self.game.score];
  self.roundLabel.text =
      [NSString stringWithFormat:@"Round: %d", self.game.round];
}

- (void)newGame {
  [self.game next];
  self.slider.value =
      (int)(self.slider.maximumValue - self.slider.minimumValue) / 2;
  [self updateUI];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self newGame];
}

@end
