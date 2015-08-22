//
//  DropitBehaviour.m
//  Dropit
//
//  Created by mcxiaoke on 15/8/16.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "DropitBehaviour.h"

@interface DropitBehaviour ()

//@property(nonatomic, strong) UIGravityBehavior *gravity;
//@property(nonatomic, strong) UICollisionBehavior *collison;

@end

@implementation DropitBehaviour

- (void)addItem:(UIDynamicAnimator *)animator {
  [animator addBehavior:self];
}

- (void)removeItem:(UIDynamicAnimator *)animator {
  [animator removeBehavior:self];
}

- (instancetype)init {
  self = [super init];
  if (self) {
    UIDynamicBehavior *gravity = [[UIGravityBehavior alloc] init];
    UIDynamicBehavior *collision = [[UICollisionBehavior alloc] init];
    [self addChildBehavior:gravity];
    [self addChildBehavior:collision];
  }
  return self;
}
@end
