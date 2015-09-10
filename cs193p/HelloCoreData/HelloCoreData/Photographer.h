//
//  Photographer.h
//  HelloCoreData
//
//  Created by mcxiaoke on 15/8/25.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Photographer : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSManagedObject *photographer;

@end
