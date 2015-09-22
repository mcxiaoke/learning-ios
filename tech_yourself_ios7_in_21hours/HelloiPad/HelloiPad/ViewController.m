//
//  ViewController.m
//  HelloiPad
//
//  Created by mcxiaoke on 15/8/19.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "ViewController.h"
#import "PopoverViewController.h"

@interface ViewController ()<UIPopoverControllerDelegate>

@property(strong, nonatomic) UIPopoverController* popup;

@end

@implementation ViewController

- (void)popoverControllerDidDismissPopover:
    (UIPopoverController*)popoverController {
  NSLog(@"popover dismissed!");
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"Popover"]) {
    //    ((UIStoryboardPopoverSegue *)segue).popoverController.delegate = self;
  }
}

- (IBAction)showPopover:(id)sender {
  [self performSegueWithIdentifier:@"Popover" sender:self];
}

- (IBAction)showPopoverByProgramming:(id)sender {
  //  UIStoryboard* main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  //  PopoverViewController* pop =
  //      [main instantiateViewControllerWithIdentifier:@"thirdPopover"];
  self.popup = [[UIPopoverController alloc] initWithContentViewController:self];

  self.popup.popoverContentSize = CGSizeMake(300, 400);
  self.popup.delegate = self;
  [self.popup presentPopoverFromRect:((UIView*)sender).frame
                              inView:self.view
            permittedArrowDirections:UIPopoverArrowDirectionAny
                            animated:YES];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
