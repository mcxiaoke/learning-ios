//
//  ViewController.m
//  Scroller
//
//  Created by mcxiaoke on 15/8/18.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scroller.contentSize=CGSizeMake(500, 1000);
}



@end
