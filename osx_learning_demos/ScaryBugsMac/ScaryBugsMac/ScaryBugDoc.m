//
//  ScaryBugDoc.m
//  ScaryBugsMac
//
//  Created by mcxiaoke on 15/10/27.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "ScaryBugDoc.h"
#import "ScaryBugData.h"

@implementation ScaryBugDoc

-(instancetype)initWithTitle:(NSString *)title rating:(float)rating thumbImage:(NSImage *)thumbImage fullImage:(NSImage *)fullImage{
  if ( self = [super init]) {
    self.data = [[ScaryBugData alloc] initWithTitle:title rating:rating];
    self.thumbImage = thumbImage;
    self.fullImage = fullImage;
  }
  return self;
}

@end
