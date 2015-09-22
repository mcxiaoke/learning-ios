#import "NSMutableString+AddText.h"

#pragma mark Class Definition

@implementation NSMutableString (AddText)

#pragma mark - Properties

#pragma mark - Public Methods

- (void)addText:(NSString *)text withSeparator:(NSString *)separator {
  if (text) {
    if ([self length]) {
      [self appendString:separator];
    }
    [self appendString:text];
  }
}

@end