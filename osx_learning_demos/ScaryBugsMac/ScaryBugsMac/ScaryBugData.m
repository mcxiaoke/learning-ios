//
//  ScaryBugData.m
//  ScaryBugsMac
//
//  Created by mcxiaoke on 15/10/27.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "ScaryBugData.h"

@implementation ScaryBugData

-(instancetype)initWithTitle:(NSString *)title rating:(float)rating{
  if (self = [super init]) {
    self.title = title;
    self.rating = rating;
  }
  return self;
}

@end
