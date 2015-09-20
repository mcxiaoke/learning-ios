//
//  AppDelegate.m
//  Checklists
//
//  Created by mcxiaoke on 15/9/20.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "AppDelegate.h"
#import "AllListsViewController.h"
#import "DataModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate {
  DataModel *_dataModel;
}

- (void)saveData {
  [_dataModel saveChecklists];
}

- (void)application:(UIApplication *)application
    didReceiveLocalNotification:(UILocalNotification *)notification {
  NSLog(@"didReceiveLocalNotification %@", notification);
}

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  UIUserNotificationType types = UIUserNotificationTypeBadge |
                                 UIUserNotificationTypeAlert |
                                 UIUserNotificationTypeSound;
  UIUserNotificationSettings *settings =
      [UIUserNotificationSettings settingsForTypes:types categories:nil];
  [application registerUserNotificationSettings:settings];

  _dataModel = [[DataModel alloc] init];
  UINavigationController *nav =
      (UINavigationController *)self.window.rootViewController;
  AllListsViewController *controller = nav.viewControllers[0];
  controller.dataModel = _dataModel;
  return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  [self saveData];
}

- (void)applicationWillTerminate:(UIApplication *)application {
  [self saveData];
}

@end
