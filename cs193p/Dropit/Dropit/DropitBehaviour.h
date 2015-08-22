//
//  DropitBehaviour.h
//  Dropit
//
//  Created by mcxiaoke on 15/8/16.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropitBehaviour : UIDynamicBehavior

- (void)addItem:(UIDynamicAnimator*)animator;
- (void)removeItem:(UIDynamicAnimator*)animator;

@end
