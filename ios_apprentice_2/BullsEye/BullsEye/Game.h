//
//  Game.h
//  BullsEye
//
//  Created by mcxiaoke on 15/9/18.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject

@property(nonatomic) int score;
@property(nonatomic) int round;
@property(nonatomic) int value;

- (void)reset;

- (void)next;

- (int)calculate:(int)newValue;

- (NSString*)alertMessageFor:(int)score;

@end
