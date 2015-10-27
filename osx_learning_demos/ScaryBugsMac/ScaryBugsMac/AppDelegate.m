//
//  AppDelegate.m
//  ScaryBugsMac
//
//  Created by mcxiaoke on 15/10/27.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "ScaryBugDoc.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property(nonatomic,strong) IBOutlet MasterViewController* masterViewController;


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  self.masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
  
  // Setup sample data
  ScaryBugDoc *bug1 = [[ScaryBugDoc alloc] initWithTitle:@"Potato Bug" rating:4 thumbImage:[NSImage imageNamed:@"potatoBugThumb.jpg"] fullImage:[NSImage imageNamed:@"potatoBug.jpg"]];
  ScaryBugDoc *bug2 = [[ScaryBugDoc alloc] initWithTitle:@"House Centipede" rating:3 thumbImage:[NSImage imageNamed:@"centipedeThumb.jpg"] fullImage:[NSImage imageNamed:@"centipede.jpg"]];
  ScaryBugDoc *bug3 = [[ScaryBugDoc alloc] initWithTitle:@"Wolf Spider" rating:5 thumbImage:[NSImage imageNamed:@"wolfSpiderThumb.jpg"] fullImage:[NSImage imageNamed:@"wolfSpider.jpg"]];
  ScaryBugDoc *bug4 = [[ScaryBugDoc alloc] initWithTitle:@"Lady Bug" rating:1 thumbImage:[NSImage imageNamed:@"ladybugThumb.jpg"] fullImage:[NSImage imageNamed:@"ladybug.jpg"]];
  NSMutableArray *bugs = [NSMutableArray arrayWithObjects:bug1, bug2, bug3, bug4, nil];
  
  self.masterViewController.bugs = bugs;
  
  [self.window.contentView addSubview:self.masterViewController.view];
  self.masterViewController.view.frame = ((NSView*)self.window.contentView).bounds;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
}

@end
