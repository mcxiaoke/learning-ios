//
//  Checklist.m
//  Checklists
//
//  Created by mcxiaoke on 15/9/20.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "Checklist.h"
#import "ChecklistItem.h"

@implementation Checklist

- (id)init {
  self = [super init];
  if (self) {
    self.items = [[NSMutableArray alloc] init];
    self.iconName = @"No Icon";
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    self.name = [aDecoder decodeObjectForKey:@"Name"];
    self.items = [aDecoder decodeObjectForKey:@"Items"];
    self.iconName = [aDecoder decodeObjectForKey:@"IconName"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.name forKey:@"Name"];
  [aCoder encodeObject:self.items forKey:@"Items"];
  [aCoder encodeObject:self.iconName forKey:@"IconName"];
}

- (int)countUncheckedItems {
  int count = 0;
  for (ChecklistItem *item in self.items) {
    if (!item.checked) {
      count += 1;
    }
  }
  return count;
}

- (NSComparisonResult)compare:(Checklist *)otherChecklist {
  return [self.name localizedStandardCompare:otherChecklist.name];
}

@end
