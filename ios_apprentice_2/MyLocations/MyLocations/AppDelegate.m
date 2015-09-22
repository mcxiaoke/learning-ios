//
//  AppDelegate.m
//  MyLocations
//
//  Created by mcxiaoke on 15/9/21.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "CurrentLocationViewController.h"
#import "LocationsViewController.h"
#import "MapViewController.h"

NSString *const ManagedObjectContextSaveDidFailNotification =
    @"ManagedObjectContextSaveDidFailNotification";

@interface AppDelegate ()<UIAlertViewDelegate>

@property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property(nonatomic, strong)
    NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation AppDelegate

- (void)customizeAppearance {
  [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
  [[UINavigationBar appearance] setTitleTextAttributes:@{
    NSForegroundColorAttributeName : [UIColor whiteColor]
  }];

  [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
}

#pragma mark - alert view

- (void)alertView:(UIAlertView *)alertView
    didDismissWithButtonIndex:(NSInteger)buttonIndex {
  abort();
}

- (void)fatalCoreDataError:(NSNotification *)notification {
  UIAlertView *alertView = [[UIAlertView alloc]
          initWithTitle:NSLocalizedString(@"Internal Error", nil)
                message:NSLocalizedString(@"There was a fatal error in the app "
                                          @"and it cannot continue.\n\nPress "
                                          @"OK to terminate the app. Sorry "
                                          @"for the inconvenience.",
                                          nil)
               delegate:self
      cancelButtonTitle:NSLocalizedString(@"OK", nil)
      otherButtonTitles:nil];
  [alertView show];
}

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  UITabBarController *tabBarController =
      (UITabBarController *)self.window.rootViewController;

  CurrentLocationViewController *tab1Controller =
      (CurrentLocationViewController *)tabBarController.viewControllers[0];
  tab1Controller.managedObjectContext = self.managedObjectContext;

  UINavigationController *tab2NavController =
      (UINavigationController *)tabBarController.viewControllers[1];
  LocationsViewController *tab2Controller =
      tab2NavController.viewControllers[0];
  tab2Controller.managedObjectContext = self.managedObjectContext;

  MapViewController *tab3Controller =
      (MapViewController *)tabBarController.viewControllers[2];
  tab3Controller.managedObjectContext = self.managedObjectContext;

  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(fatalCoreDataError:)
             name:ManagedObjectContextSaveDidFailNotification
           object:nil];

  [self customizeAppearance];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state.
  // This can occur for certain types of temporary interruptions (such as an
  // incoming phone call or SMS message) or when the user quits the application
  // and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down
  // OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate
  // timers, and store enough application state information to restore your
  // application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called
  // instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state;
  // here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the
  // application was inactive. If the application was previously in the
  // background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if
  // appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - core data

- (NSManagedObjectModel *)managedObjectModel {
  if (_managedObjectModel == nil) {
    NSString *modelPath =
        [[NSBundle mainBundle] pathForResource:@"DataModel" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    _managedObjectModel =
        [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  }
  return _managedObjectModel;
}

- (NSString *)documentsDirectory {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                       NSUserDomainMask, YES);
  return [paths lastObject];
}

- (NSString *)dataStorePath {
  return [[self documentsDirectory]
      stringByAppendingPathComponent:@"DataStore.sqlite"];
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  if (_persistentStoreCoordinator == nil) {
    NSURL *storeURL = [NSURL fileURLWithPath:[self dataStorePath]];
    NSLog(@"storeURL: %@", storeURL);
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
        initWithManagedObjectModel:self.managedObjectModel];
    NSError *error;
    if (![_persistentStoreCoordinator
            addPersistentStoreWithType:NSSQLiteStoreType
                         configuration:nil
                                   URL:storeURL
                               options:nil
                                 error:&error]) {
      NSLog(@"Error adding persistent store %@, %@", error, [error userInfo]);
      abort();
    }
  }
  return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
  if (_managedObjectContext == nil) {
    NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
    if (coordinator != nil) {
      _managedObjectContext = [[NSManagedObjectContext alloc]
          initWithConcurrencyType:NSPrivateQueueConcurrencyType];
      [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
  }

  return _managedObjectContext;
}

@end
