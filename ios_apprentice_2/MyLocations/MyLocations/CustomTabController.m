//
//  CustomTabController.m
//  MyLocations
//
//  Created by mcxiaoke on 15/9/24.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import "CustomTabController.h"

@interface CustomTabController ()

@end

@implementation CustomTabController

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(UIViewController*)childViewControllerForStatusBarStyle{
    return nil;}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
