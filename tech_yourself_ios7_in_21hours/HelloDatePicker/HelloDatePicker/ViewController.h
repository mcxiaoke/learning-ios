//
//  ViewController.h
//  HelloDatePicker
//
//  Created by mcxiaoke on 15/8/20.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic) Boolean dateChooserVisible;
@property(nonatomic) Boolean animalChooserVisible;

- (void)calculateDateDifference:(NSDate*)chosenDate;
- (void)updateAnimalLabel:(NSString*)name withSound:(NSString*)sound;

@end
