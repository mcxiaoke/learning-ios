//
//  BNRItemStore.h
//  Homepwner
//
//  Created by mcxiaoke on 15/10/19.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;

@interface BNRItemStore : NSObject

+ (instancetype)sharedStore;

- (BNRItem*)createItem;

- (NSArray*)allItems;

@end
