//
//  ViewController.m
//  HelloSettings
//
//  Created by mcxiaoke on 15/8/22.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "ViewController.h"

#define kOnOffToggle @"onoff"
#define kHueSetting @"hue"

#define kName @"name"
#define kEmail @"email"
#define kPhone @"phone"
#define kPicture @"picture"

@interface ViewController ()
@property(weak, nonatomic) IBOutlet UILabel *name;
@property(weak, nonatomic) IBOutlet UILabel *email;
@property(weak, nonatomic) IBOutlet UILabel *phone;

@property(weak, nonatomic) IBOutlet UISwitch *toggleSwitch;
@property(weak, nonatomic) IBOutlet UISlider *hueSlider;
@end

@implementation ViewController

- (void)saveConfig {
  NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
  [df setBool:self.toggleSwitch.on forKey:kOnOffToggle];
  [df setFloat:self.hueSlider.value forKey:kHueSetting];
  [df synchronize];
}

- (void)setBgColor {
  if (self.toggleSwitch.on) {
    UIColor *color = [UIColor colorWithHue:self.hueSlider.value
                                saturation:0.75
                                brightness:0.75
                                     alpha:0.75];
    self.view.backgroundColor = color;
  } else {
    self.view.backgroundColor = [UIColor whiteColor];
  }
}
- (IBAction)onSwitchToggle:(UISwitch *)sender {
  [self saveConfig];
  [self setBgColor];
}

- (IBAction)onHueValueChanged:(UISlider *)sender {
  [self saveConfig];
  [self setBgColor];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  NSDictionary *defaults = @{
    kName : @"John Games",
    kEmail : @"hello@apple.com",
    kPhone : @"555-345-1234"
  };

  NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
  [df registerDefaults:defaults];
  self.toggleSwitch.on = [df boolForKey:kOnOffToggle];
  self.hueSlider.value = [df floatForKey:kHueSetting];
  [self setBgColor];
}

@end
