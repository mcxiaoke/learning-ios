//
//  Game.m
//  BullsEye
//
//  Created by mcxiaoke on 15/9/18.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "Game.h"

@implementation Game

- (instancetype)init {
  self = [super init];
  return self;
}

- (void)reset {
  self.score = 0;
  self.round = 0;
  self.value = 0;
  [self next];
}

- (void)next {
  self.round++;
  self.value = arc4random() % 99 + 1;
}

- (int)calculate:(int)newValue {
  int delta = abs(self.value - newValue);
  int newScore;
  if (delta > 20) {
    newScore = 0;
  } else {
    newScore = (20 - delta) * 5;
  }
  self.score += newScore;
  return newScore;
}

- (NSString*)alertMessageFor:(int)score {
  NSString* title;
  if (score > 80) {
    title = @"Very Good!";
  } else if (score > 50) {
    title = @"Good!";
  } else if (score > 0) {
    title = @"Just soso.";
  } else {
    title = @"Too bad!";
  }
  return title;
}

@end
