//
//  FirstViewController.m
//  MyLocations
//
//  Created by mcxiaoke on 15/9/21.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "CurrentLocationViewController.h"
#import "LocationDetailsViewController.h"

@interface CurrentLocationViewController ()<CLLocationManagerDelegate>

@property(nonatomic, weak) IBOutlet UILabel* messageLabel;
@property(nonatomic, weak) IBOutlet UILabel* latitudeLabel;
@property(nonatomic, weak) IBOutlet UILabel* longitudeLabel;
@property(nonatomic, weak) IBOutlet UILabel* addressLabel;
@property(nonatomic, weak) IBOutlet UIButton* tagButton;
@property(nonatomic, weak) IBOutlet UIButton* getButton;

@end

@implementation CurrentLocationViewController {
  CLLocationManager* _locationManager;
  CLLocation* _location;
  CLGeocoder* _geocoder;
  CLPlacemark* _placemark;
  BOOL _performingReverseGeocoding;
  NSError* _lastGeocodingError;
  NSError* _lastLocationError;

  BOOL _updatingLocation;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{


    if ([segue.identifier isEqualToString:@"TagLocation"]) {
        UINavigationController* nav=segue.destinationViewController;
        LocationDetailsViewController* controller=(LocationDetailsViewController*)nav.topViewController;
        controller.coordinate=_location.coordinate;
        controller.placemark=_placemark;
    }
}

- (id)initWithCoder:(NSCoder*)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _locationManager = [[CLLocationManager alloc] init];
    _geocoder = [[CLGeocoder alloc] init];
  }
  return self;
}

- (void)configureGetButton {
  if (_updatingLocation) {
    [self.getButton setTitle:@"Stop" forState:UIControlStateNormal];
  } else {
    [self.getButton setTitle:@"Get My Location" forState:UIControlStateNormal];
  }
}

- (IBAction)tagLocation:(UIButton*)sender {
}
- (IBAction)getLocation:(UIButton*)sender {
  NSLog(@"get location");
  if (_updatingLocation) {
    [self stopLocationManager];
  } else {
    _location = nil;
    _lastLocationError = nil;
    _placemark = nil;
    _lastGeocodingError = nil;
    [self startLocationManager];
  }

  [self updateLabels];
  [self configureGetButton];
}

#pragma mark - location

- (void)didTimeOut:(id)obj {
  NSLog(@"time out");
  if (_location == nil) {
    [self stopLocationManager];
    _lastLocationError =
        [NSError errorWithDomain:@"MyLocationsErrorDomain" code:1 userInfo:nil];
    [self updateLabels];
    [self configureGetButton];
  }
}

- (void)stopLocationManager {
  if (_updatingLocation) {
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(didTimeOut:)
                                               object:nil];
    [_locationManager stopUpdatingLocation];
    _locationManager.delegate = nil;
    _updatingLocation = NO;
  }
}

- (void)startLocationManager {
  if ([CLLocationManager locationServicesEnabled]) {
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [_locationManager startUpdatingLocation];
    _updatingLocation = YES;

    [self performSelector:@selector(didTimeOut:) withObject:nil afterDelay:60];
  }
}

- (void)locationManager:(CLLocationManager*)manager
       didFailWithError:(NSError*)error {
  NSLog(@"didFailWithError:%@", error);
  if (error.code == kCLErrorLocationUnknown) {
    return;
  }
  [self stopLocationManager];
  [self updateLabels];
  [self configureGetButton];
}

- (void)locationManager:(CLLocationManager*)manager
     didUpdateLocations:(NSArray<CLLocation*>*)locations {
  CLLocation* newLocation = [locations lastObject];
  NSLog(@"didUpdateLocations: %@", newLocation);
  if ([newLocation.timestamp timeIntervalSinceNow] < -5.0) {
    return;
  }
  if (newLocation.horizontalAccuracy < 0) {
    return;
  }

  CLLocationDistance distance = MAXFLOAT;
  if (_location) {
    distance = [newLocation distanceFromLocation:_location];
  }

  if (_location == nil ||
      _location.horizontalAccuracy > newLocation.horizontalAccuracy) {
    _lastLocationError = nil;
    _location = newLocation;
    [self updateLabels];
    if (newLocation.horizontalAccuracy <= _locationManager.desiredAccuracy) {
      NSLog(@"We are done!");
      [self stopLocationManager];
      [self configureGetButton];

      if (distance > 0) {
        _performingReverseGeocoding = NO;
      }
    }

    if (!_performingReverseGeocoding) {
      NSLog(@"Get Geocoding...");
      _performingReverseGeocoding = YES;
      [_geocoder
          reverseGeocodeLocation:_location
               completionHandler:^(NSArray<CLPlacemark*>* _Nullable placemarks,
                                   NSError* _Nullable error) {
                 NSLog(@"geocoding results, placemarks:%@, error:%@",
                       [placemarks lastObject], error);
                 _lastGeocodingError = error;
                 if (error == nil && [placemarks count] > 0) {
                   _placemark = [placemarks lastObject];
                 } else {
                   _placemark = nil;
                 }
                 _performingReverseGeocoding = NO;
                 [self updateLabels];
               }];
    }
  } else if (distance < 1.0) {
    NSTimeInterval timeInterval =
        [newLocation.timestamp timeIntervalSinceDate:_location.timestamp];
    if (timeInterval > 10) {
      NSLog(@"Force done!");
      [self stopLocationManager];
      [self updateLabels];
      [self configureGetButton];
    }
  }
}

- (NSString*)stringForPlacemark:(CLPlacemark*)placemark {
  return [NSString
      stringWithFormat:@"%@ %@\n%@ %@ %@", placemark.subThoroughfare,
                       placemark.thoroughfare, placemark.locality,
                       placemark.administrativeArea, placemark.postalCode];
}

- (void)updateLabels {
  if (_location) {
    self.latitudeLabel.text =
        [NSString stringWithFormat:@"%.8f", _location.coordinate.latitude];
    self.longitudeLabel.text =
        [NSString stringWithFormat:@"%.8f", _location.coordinate.longitude];
    self.tagButton.hidden = NO;
    self.messageLabel.text = @"";

    if (_placemark != nil) {
      self.addressLabel.text = [self stringForPlacemark:_placemark];
    } else if (_performingReverseGeocoding) {
      self.addressLabel.text = @"Searching for Address...";
    } else if (_lastGeocodingError) {
      self.addressLabel.text = @"Error Finding Address";
    } else {
      self.addressLabel.text = @"No Address Found";
    }
  } else {
    self.latitudeLabel.text = @"";
    self.longitudeLabel.text = @"";
    self.addressLabel.text = @"";
    self.tagButton.hidden = YES;

    NSString* message;
    if (_lastLocationError) {
      if ([_lastLocationError.domain isEqualToString:kCLErrorDomain] &&
          _lastLocationError.code == kCLErrorDenied) {
        message = @"Location Service Disabled";
      } else {
        message = @"Error Getting Location";
      }
    } else if (![CLLocationManager locationServicesEnabled]) {
      message = @"Location Service Disabled";
    } else if (_updatingLocation) {
      message = @"Searching...";
    } else {
      message = @"Press the Button to Start";
    }
    self.messageLabel.text = message;
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  if ([CLLocationManager authorizationStatus] ==
      kCLAuthorizationStatusNotDetermined) {
    [_locationManager requestWhenInUseAuthorization];
  }
  [self updateLabels];
  [self configureGetButton];
}

@end
