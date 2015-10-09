//
//  SearchResult.h
//  StoreSearch
//
//  Created by mcxiaoke on 15/10/9.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResult : NSObject

@property(nonatomic, copy) NSString* name;
@property(nonatomic, copy) NSString* artistName;
@property(nonatomic, copy) NSString* artworkURL60;
@property(nonatomic, copy) NSString* artworkURL100;
@property(nonatomic, copy) NSString* storeURL;
@property(nonatomic, copy) NSString* kind;
@property(nonatomic, copy) NSString* currency;
@property(nonatomic, copy) NSDecimalNumber* price;
@property(nonatomic, copy) NSString* genre;

- (NSComparisonResult)compareName:(SearchResult*)other;
- (NSString*)kindForDisplay;

@end
