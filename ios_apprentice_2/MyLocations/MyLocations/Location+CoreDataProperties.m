//
//  Location+CoreDataProperties.m
//  MyLocations
//
//  Created by mcxiaoke on 15/9/22.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Location+CoreDataProperties.h"

@implementation Location (CoreDataProperties)

@dynamic latitude;
@dynamic longitude;
@dynamic date;
@dynamic locationDescription;
@dynamic category;
@dynamic placemark;
@dynamic photoId;

- (CLLocationCoordinate2D)coordinate {
  return CLLocationCoordinate2DMake([self.latitude doubleValue],
                                    [self.longitude doubleValue]);
}

- (NSString *)title {
  if ([self.locationDescription length] > 0) {
    return self.locationDescription;
  } else {
    return @"(No Description)";
  }
}

- (NSString *)subtitle {
  return self.category;
}

- (NSString *)documentsDirectory {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                       NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths lastObject];
  return documentsDirectory;
}
- (NSString *)photoPath {
  NSString *filename =
      [NSString stringWithFormat:@"Photo-%lu.jpg", [self.photoId integerValue]];
  return [[self documentsDirectory] stringByAppendingPathComponent:filename];
}

- (BOOL)hasPhoto {
  return (self.photoId != nil && ([self.photoId integerValue] != -1));
}

- (UIImage *)photoImage {
  NSAssert(self.photoId != nil, @"No photo Id set");
  NSAssert([self.photoId integerValue] != -1, @"Photo Id is -1");
  return [UIImage imageWithContentsOfFile:[self photoPath]];
}

- (void)removePhotoFile {
  NSString *path = [self photoPath];
  NSFileManager *fm = [NSFileManager defaultManager];
  if ([fm fileExistsAtPath:path]) {
    NSError *error;
    if (![fm removeItemAtPath:path error:&error]) {
      NSLog(@"Error removing file: %@", error);
    }
  }
}

+ (NSInteger)nextPhotoId {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSInteger photoId = [defaults integerForKey:@"PhotoId"];
  [defaults setInteger:photoId + 1 forKey:@"PhotoId"];
  [defaults synchronize];
  return photoId;
}

@end
