//
//  SearchResultCell.h
//  StoreSearch
//
//  Created by mcxiaoke on 15/10/9.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchResult;

@interface SearchResultCell : UITableViewCell
@property(weak, nonatomic) IBOutlet UIImageView *artworkImageView;

@property(weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(weak, nonatomic) IBOutlet UILabel *artistNameLabel;

- (void)configureForSearchResult:(SearchResult *)result;

@end
