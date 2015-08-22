//
//  TextStatusViewController.m
//  Attributor
//
//  Created by mcxiaoke on 15/8/14.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "TextStatusViewController.h"

@interface TextStatusViewController ()

@property(weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property(weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabbel;
@end

@implementation TextStatusViewController

- (void)setTextToAnalytics:(NSAttributedString *)textToAnalytics {
  _textToAnalytics = textToAnalytics;
  if (self.view.window) {
    [self updateUI];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self updateUI];
}

- (void)updateUI {
  unsigned long colorfulCount =
      [[self charactersWithAttribute:NSForegroundColorAttributeName] length];
  unsigned long outlinedCount =
      [[self charactersWithAttribute:NSStrokeWidthAttributeName] length];
  NSLog(@"colorful=%lu,outlined=%lu", colorfulCount, outlinedCount);
  self.colorfulCharactersLabel.text =
      [NSString stringWithFormat:@"%lu colorful characters", colorfulCount];
  self.outlinedCharactersLabbel.text =
      [NSString stringWithFormat:@"%lu outlined characters", outlinedCount];
}

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName {
  NSMutableAttributedString *characters =
      [[NSMutableAttributedString alloc] init];

  unsigned long index = 0;
  while (index < [self.textToAnalytics length]) {
    NSRange range;
    id value = [self.textToAnalytics attribute:attributeName
                                       atIndex:index
                                effectiveRange:&range];
    if (value) {
      [characters
          appendAttributedString:[self.textToAnalytics
                                     attributedSubstringFromRange:range]];
      index = range.location + range.length;
    } else {
      index++;
    }
  }

  return characters;
}

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

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
