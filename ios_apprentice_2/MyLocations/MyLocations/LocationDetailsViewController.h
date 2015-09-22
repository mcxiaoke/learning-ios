//
//  LocationDetailsViewController.h
//  MyLocations
//
//  Created by mcxiaoke on 15/9/21.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Location.h"

@interface LocationDetailsViewController : UITableViewController

@property(nonatomic, strong) NSManagedObjectContext* managedObjectContext;

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, strong) CLPlacemark* placemark;

@property(nonatomic, strong) Location* locationToEdit;

@end
