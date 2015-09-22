//
//  Location+CoreDataProperties.h
//  MyLocations
//
//  Created by mcxiaoke on 15/9/22.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Location.h"
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Location (CoreDataProperties)<MKAnnotation>

@property(nullable, nonatomic, retain) NSNumber *latitude;
@property(nullable, nonatomic, retain) NSNumber *longitude;
@property(nullable, nonatomic, retain) NSDate *date;
@property(nullable, nonatomic, retain) NSString *locationDescription;
@property(nullable, nonatomic, retain) NSString *category;
@property(nullable, nonatomic, retain) CLPlacemark *placemark;
@property(nullable, nonatomic, retain) NSNumber *photoId;

+ (NSInteger)nextPhotoId;
- (BOOL)hasPhoto;
- (NSString *)photoPath;
- (UIImage *)photoImage;
- (void)removePhotoFile;

@end

NS_ASSUME_NONNULL_END
