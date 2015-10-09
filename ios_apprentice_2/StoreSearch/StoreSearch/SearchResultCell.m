//
//  SearchResultCell.m
//  StoreSearch
//
//  Created by mcxiaoke on 15/10/9.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>
#import "SearchResultCell.h"
#import "SearchResult.h"

@implementation SearchResultCell

- (void)awakeFromNib {
  [super awakeFromNib];
  UIView* selectedView = [[UIView alloc] initWithFrame:CGRectZero];
  selectedView.backgroundColor = [UIColor colorWithRed:20 / 255.0f
                                                 green:160 / 255.0f
                                                  blue:160 / 255.0f
                                                 alpha:0.5f];
  self.selectedBackgroundView = selectedView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

- (void)configureForSearchResult:(SearchResult*)result {
  self.nameLabel.text = result.name;
  NSString* artistName = result.artistName;
  if (!artistName) {
    artistName = @"Unknown";
  }
  NSString* kind = [result kindForDisplay];
  self.artistNameLabel.text =
      [NSString stringWithFormat:@"%@ (%@)", artistName, kind];
  [self.artworkImageView
       setImageWithURL:[NSURL URLWithString:result.artworkURL60]
      placeholderImage:[UIImage imageNamed:@"Placeholder"]];
}

- (void)prepareForReuse {
  [super prepareForReuse];
  [self.artworkImageView cancelImageRequestOperation];
  self.nameLabel.text = nil;
  self.artistNameLabel.text = nil;
}

@end
