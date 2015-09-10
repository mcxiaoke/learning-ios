//
//  Photo.h
//  HelloCoreData
//
//  Created by mcxiaoke on 15/8/25.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photographer;

@interface Photo : NSManagedObject

@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSDate *date;
@property(nonatomic, retain) NSNumber *length;
@property(nonatomic, retain) NSNumber *aFloat;
@property(nonatomic, retain) Photographer *who;

@end
