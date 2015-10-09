//
//  SearchResult.m
//  StoreSearch
//
//  Created by mcxiaoke on 15/10/9.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "SearchResult.h"

@implementation SearchResult

- (NSComparisonResult)compareName:(SearchResult*)other {
  return [self.name localizedStandardCompare:other.name];
}

- (NSString*)kindForDisplay {
  NSString* kind = self.kind;
  if ([kind isEqualToString:@"album"]) {
    return @"Album";
  } else if ([kind isEqualToString:@"audiobook"]) {
    return @"Audio Book";
  } else if ([kind isEqualToString:@"book"]) {
    return @"Book";
  } else if ([kind isEqualToString:@"ebook"]) {
    return @"E-Book";
  } else if ([kind isEqualToString:@"feature-movie"]) {
    return @"Movie";
  } else if ([kind isEqualToString:@"music-video"]) {
    return @"Music Video";
  } else if ([kind isEqualToString:@"podcast"]) {
    return @"Podcast";
  } else if ([kind isEqualToString:@"software"]) {
    return @"App";
  } else if ([kind isEqualToString:@"song"]) {
    return @"Song";
  } else if ([kind isEqualToString:@"tv-episode"]) {
    return @"TV Episode";
  } else {
    return kind;
  }
}

@end
