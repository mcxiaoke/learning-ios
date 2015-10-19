//
//  BNRItemStore.m
//  Homepwner
//
//  Created by mcxiaoke on 15/10/19.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore ()

@property(nonatomic, strong) NSMutableArray* items;

@end

@implementation BNRItemStore

+ (instancetype)sharedStore {
  static BNRItemStore* instance = nil;
  if (!instance) {
    instance = [[self alloc] initPrivate];
  }
  return instance;
}

- (instancetype)init {
  @throw [NSException exceptionWithName:@"Singleton"
                                 reason:@"Use [+BNRItemStore sharedStore]"
                               userInfo:nil];
  return nil;
}

- (instancetype)initPrivate {
  self = [super init];
  if (self) {
    _items = [[NSMutableArray alloc] init];
  }
  return self;
}

- (NSArray*)allItems {
  return [self.items copy];
}

- (BNRItem*)createItem {
  BNRItem* item = [BNRItem randomItem];
  [self.items addObject:item];
  return item;
}

@end
