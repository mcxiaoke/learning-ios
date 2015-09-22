//
//  HudView.h
//  MyLocations
//
//  Created by mcxiaoke on 15/9/22.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HudView : UIView

+ (instancetype)hudInView:(UIView*)view animated:(BOOL)animated;

- (void)showAnimated:(BOOL)animated;

@property(nonatomic, strong) NSString* text;

@end
