//
//  ScaryBugDoc.h
//  ScaryBugsMac
//
//  Created by mcxiaoke on 15/10/27.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ScaryBugData;

@interface ScaryBugDoc : NSObject

@property(nonatomic,strong) ScaryBugData* data;
@property(nonatomic,strong) NSImage* thumbImage;
@property(nonatomic,strong) NSImage* fullImage;

-(instancetype)initWithTitle:(NSString*)title rating:(float)rating thumbImage:(NSImage*) thumbImage fullImage:(NSImage*)fullImage;

@end
