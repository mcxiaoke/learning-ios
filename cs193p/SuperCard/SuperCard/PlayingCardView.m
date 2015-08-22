//
//  PlayingCardView.m
//  SuperCard
//
//  Created by mcxiaoke on 15/8/15.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "PlayingCardView.h"

@implementation PlayingCardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - initialization

- (void)setup {
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self setup];
  }
  return self;
}

- (void)awakeFromNib {
  [self setup];
}

- (void)drawRect:(CGRect)rect {
  UIBezierPath* roundedRect =
      [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:12.0];
  [roundedRect addClip];
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
}

@end
