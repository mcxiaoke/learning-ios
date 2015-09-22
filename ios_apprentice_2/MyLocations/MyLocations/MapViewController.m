//
//  MapViewController.m
//  MyLocations
//
//  Created by mcxiaoke on 15/9/23.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "MapViewController.h"
#import "Location+CoreDataProperties.h"
#import "LocationDetailsViewController.h"
#import <CoreData/CoreData.h>

@interface MapViewController ()<MKMapViewDelegate, UINavigationBarDelegate>

@property(nonatomic, weak) IBOutlet MKMapView* mapView;

@end

@implementation MapViewController {
  NSArray* _locations;
}

- (MKAnnotationView*)mapView:(MKMapView*)mapView
           viewForAnnotation:(id<MKAnnotation>)annotation {
  if ([annotation isKindOfClass:[Location class]]) {
    static NSString* identifier = @"Location";
    MKPinAnnotationView* annotationView = (MKPinAnnotationView*)
        [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];

    if (annotationView == nil) {
      annotationView =
          [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                          reuseIdentifier:identifier];

      annotationView.enabled = YES;
      annotationView.canShowCallout = YES;
      annotationView.animatesDrop = NO;
      annotationView.pinTintColor =
          [UIColor colorWithRed:0 green:1.0 blue:0 alpha:1.0];

      UIButton* rightButton =
          [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
      [rightButton addTarget:self
                      action:@selector(showLocationDetails:)
            forControlEvents:UIControlEventTouchUpInside];
      annotationView.rightCalloutAccessoryView = rightButton;
    } else {
      annotationView.annotation = annotation;
    }

    UIButton* button = (UIButton*)annotationView.rightCalloutAccessoryView;
      button.tintColor= [UIColor colorWithWhite:0.0f alpha:0.5f];
    button.tag = [_locations indexOfObject:(Location*)annotation];

    return annotationView;
  }

  return nil;
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"EditLocation"]) {
    UINavigationController* nav = segue.destinationViewController;
    LocationDetailsViewController* controller =
        (LocationDetailsViewController*)nav.topViewController;
    controller.managedObjectContext = self.managedObjectContext;
    UIButton* button = (UIButton*)sender;
    Location* location = _locations[button.tag];
    controller.locationToEdit = location;
  }
}

- (void)showLocationDetails:(UIButton*)sender {
  [self performSegueWithIdentifier:@"EditLocation" sender:sender];
}

- (void)updateLocations {
  NSEntityDescription* entity =
      [NSEntityDescription entityForName:@"Location"
                  inManagedObjectContext:self.managedObjectContext];
  NSFetchRequest* r = [[NSFetchRequest alloc] init];
  [r setEntity:entity];

  NSError* error;
  NSArray* objects =
      [self.managedObjectContext executeFetchRequest:r error:&error];
  if (objects == nil) {
    abort();
    return;
  }
  if (_locations) {
    [self.mapView removeAnnotations:_locations];
  }

  _locations = objects;
  [self.mapView addAnnotations:_locations];
}

- (MKCoordinateRegion)regionForAnnotations:(NSArray*)annotations {
  MKCoordinateRegion region;
  if ([annotations count] == 0) {
    region = MKCoordinateRegionMakeWithDistance(
        self.mapView.userLocation.coordinate, 1000, 1000);
  } else if ([annotations count] == 1) {
    id<MKAnnotation> annotation = [annotations lastObject];
    region =
        MKCoordinateRegionMakeWithDistance(annotation.coordinate, 1000, 1000);
  } else {
    CLLocationCoordinate2D topLfetCoord;
    topLfetCoord.latitude = -90;
    topLfetCoord.longitude = 180;

    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;

    for (id<MKAnnotation> annotation in annotations) {
      topLfetCoord.latitude =
          fmax(topLfetCoord.latitude, annotation.coordinate.latitude);
      topLfetCoord.longitude =
          fmin(topLfetCoord.longitude, annotation.coordinate.longitude);

      bottomRightCoord.latitude =
          fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
      bottomRightCoord.longitude =
          fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
    }

    const double extraSpace = 1.1;
    region.center.latitude =
        topLfetCoord.latitude -
        (topLfetCoord.latitude - bottomRightCoord.latitude) / 2.0;
    region.center.longitude =
        topLfetCoord.longitude -
        (topLfetCoord.longitude - bottomRightCoord.longitude) / 2.0;
    region.span.latitudeDelta =
        fabs(topLfetCoord.latitude - bottomRightCoord.latitude) * extraSpace;
    region.span.longitudeDelta =
        fabs(topLfetCoord.longitude - bottomRightCoord.longitude) * extraSpace;
  }

  return [self.mapView regionThatFits:region];
}

- (IBAction)showUser:(id)sender {
  MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(
      self.mapView.userLocation.coordinate, 1000, 1000);
  [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

- (IBAction)showLocation:(id)sender {
  MKCoordinateRegion region = [self regionForAnnotations:_locations];
  [self.mapView setRegion:region];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // don't forget set delegate, or strange bugs
  self.mapView.delegate = self;
  [self updateLocations];
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(contextDidChange:)
             name:NSManagedObjectContextObjectsDidChangeNotification
           object:self.managedObjectContext];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)contextDidChange:(NSNotification*)notification {
  if ([self isViewLoaded]) {
    [self updateLocations];
  }
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
  return UIBarPositionTopAttached;
}

@end
