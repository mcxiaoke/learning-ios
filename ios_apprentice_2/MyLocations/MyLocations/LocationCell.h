//
//  LocationCell.h
//  MyLocations
//
//  Created by mcxiaoke on 15/9/22.
//  Copyright © 2015年 mcxiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationCell : UITableViewCell

@property(nonatomic, weak) IBOutlet UILabel* descriptionLabel;
@property(nonatomic, weak) IBOutlet UILabel* addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbView;

@end
