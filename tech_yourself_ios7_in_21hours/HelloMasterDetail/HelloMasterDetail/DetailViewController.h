//
//  DetailViewController.h
//  HelloMasterDetail
//
//  Created by mcxiaoke on 15/8/22.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

