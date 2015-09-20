//
//  DataModel.m
//  Checklists
//
//  Created by mcxiaoke on 15/9/20.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "DataModel.h"
#import "Checklist.h"

@implementation DataModel

- (id)init {
  self = [super init];
  if (self) {
    [self loadChecklists];
    [self registerDefaults];
    [self handleFirstTime];
  }
  return self;
}

- (void)registerDefaults {
  NSDictionary *dict = @{
    @"ChecklistIndex" : @-1,
    @"FirstTime" : @YES,
    @"ChecklistItemId" : @0
  };
  [[NSUserDefaults standardUserDefaults] registerDefaults:dict];
}

- (void)handleFirstTime {
  BOOL firstTime =
      [[NSUserDefaults standardUserDefaults] boolForKey:@"FirstTime"];
  if (firstTime) {
    Checklist *checklist = [[Checklist alloc] init];
    checklist.name = @"List";

    [self.lists addObject:checklist];
    [self setIndexOfSelectedChecklist:0];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FirstTime"];
  }
}

- (NSInteger)indexOfSelectedChecklist {
  return
      [[NSUserDefaults standardUserDefaults] integerForKey:@"ChecklistIndex"];
}

- (void)setIndexOfSelectedChecklist:(NSInteger)index {
  [[NSUserDefaults standardUserDefaults] setInteger:index
                                             forKey:@"ChecklistIndex"];
}

- (NSString *)documentsDirectory {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                       NSUserDomainMask, YES);
  return [paths firstObject];
}

- (NSString *)dataFilePath {
  return [[self documentsDirectory]
      stringByAppendingPathComponent:@"Checklists.plist"];
}

- (void)saveChecklists {
  NSMutableData *data = [[NSMutableData alloc] init];
  NSKeyedArchiver *archiver =
      [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
  [archiver encodeObject:self.lists forKey:@"Checklists"];
  [archiver finishEncoding];
  [data writeToFile:[self dataFilePath] atomically:YES];
}

- (void)loadChecklists {
  NSString *path = [self dataFilePath];
  if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSKeyedUnarchiver *unarchiver =
        [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    self.lists = [unarchiver decodeObjectForKey:@"Checklists"];
    [unarchiver finishDecoding];
  } else {
    self.lists = [[NSMutableArray alloc] init];
  }
}

- (void)sortChecklists {
  [self.lists sortUsingSelector:@selector(compare:)];
}

+ (NSInteger)nextChecklistItemId {
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  NSInteger itemId = [ud integerForKey:@"ChecklistItemId"];
  [ud setInteger:itemId + 1 forKey:@"ChecklistItemId"];
  [ud synchronize];
  return itemId;
}

@end
