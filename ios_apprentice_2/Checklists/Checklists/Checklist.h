//
//  Checklist.h
//  Checklists
//
//  Created by mcxiaoke on 15/9/20.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklist : NSObject<NSCoding>

@property(nonatomic, copy) NSString* name;
@property(nonatomic, copy) NSString* iconName;
@property(nonatomic, strong) NSMutableArray* items;

- (int)countUncheckedItems;

@end
