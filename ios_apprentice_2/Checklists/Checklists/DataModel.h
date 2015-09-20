//
//  DataModel.h
//  Checklists
//
//  Created by mcxiaoke on 15/9/20.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property(nonatomic, strong) NSMutableArray* lists;

- (void)saveChecklists;
- (void)loadChecklists;

- (NSInteger)indexOfSelectedChecklist;
- (void)setIndexOfSelectedChecklist:(NSInteger)index;
- (void)sortChecklists;

+ (NSInteger)nextChecklistItemId;

@end
