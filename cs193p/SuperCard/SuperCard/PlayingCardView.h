//
//  PlayingCardView.h
//  SuperCard
//
//  Created by mcxiaoke on 15/8/15.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property(nonatomic) NSUInteger rank;
@property(strong, nonatomic) NSString* suit;
@property(nonatomic) BOOL faceUp;

@end
