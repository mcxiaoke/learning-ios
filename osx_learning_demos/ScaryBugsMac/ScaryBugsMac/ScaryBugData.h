//
//  ScaryBugData.h
//  ScaryBugsMac
//
//  Created by mcxiaoke on 15/10/27.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScaryBugData : NSObject

@property(nonatomic,strong) NSString* title;
@property float rating;

-(instancetype)initWithTitle:(NSString*) title rating:(float)rating;

@end
