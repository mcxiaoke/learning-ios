//
//  AppDelegate.m
//  TrackMix
//
//  Created by mcxiaoke on 15/10/27.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "AppDelegate.h"
#import "Track.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *volumeTextField;
@property (weak) IBOutlet NSSlider *volumeSlider;


@end

@implementation AppDelegate

- (IBAction)mute:(id)sender {
  NSLog(@"mute: %@",sender);
  self.track.volume = 0.0;
  [self updateUI];
}
- (IBAction)valueChanged:(id)sender {
  float newValue = [sender floatValue];
  NSLog(@"valueChanged: %f",newValue);
  self.track.volume = newValue;
  [self updateUI];
  
}

-(void)updateUI {
  float volume = self.track.volume;
  self.volumeTextField.floatValue = volume;
  self.volumeSlider.floatValue = volume;
  
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  self.track = [[Track alloc] init];
  [self updateUI];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
}

@end
