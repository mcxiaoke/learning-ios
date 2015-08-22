//
//  DemoView.m
//  HelloViews
//
//  Created by mcxiaoke on 15/8/15.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "DemoView.h"

@implementation DemoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect {
  //  self.backgroundColor = [UIColor whiteColor];
  self.opaque = NO;
  //  CGContextRef context = UIGraphicsGetCurrentContext();
  UIBezierPath* path = [[UIBezierPath alloc] init];
  path.lineWidth = 4.0;
  [path moveToPoint:CGPointMake(100, 30)];
  [path addLineToPoint:CGPointMake(160, 150)];
  [path addLineToPoint:CGPointMake(40, 150)];
  [path closePath];
  [[UIColor greenColor] setFill];
  [[UIColor redColor] setStroke];
  [path fill];
  [path stroke];

  NSAttributedString* text =
      [[NSAttributedString alloc] initWithString:@"hello, world"];
  [text drawAtPoint:CGPointMake(20, 160)];

  UIImage* imgage = nil;
  //  [image drawAtPoint:CGPointMake(0, 180)];
  //  [image drawInRect:CGRectMake(0, 0, 100, 100)];
  //  [image drawAsPatternInRect:CGRectMake(0, 0, 100, 100)];
}

@end
