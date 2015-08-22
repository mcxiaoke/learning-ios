//
//  AnimalViewController.h
//  HelloDatePicker
//
//  Created by mcxiaoke on 15/8/20.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimalViewController
    : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property(weak, nonatomic) id delegate;

@end
