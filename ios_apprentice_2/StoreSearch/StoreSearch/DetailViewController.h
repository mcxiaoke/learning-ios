//
//  DetailViewController.h
//  StoreSearch
//
//  Created by mcxiaoke on 15/10/10.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchResult;

@interface DetailViewController : UIViewController

@property(nonatomic, strong) SearchResult* searchResult;

- (void)presentInParentViewController:(UIViewController*)parentViewController;
- (void)dismissFromParentViewController;

@end
