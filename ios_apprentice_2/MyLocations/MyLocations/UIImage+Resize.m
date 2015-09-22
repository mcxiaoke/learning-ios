#import "UIImage+Resize.h"

#pragma mark Class Definition

@implementation UIImage (Resize)

#pragma mark - Properties

#pragma mark - Public Methods

- (UIImage*)resizedImageWithBounds:(CGSize)bounds {
  CGFloat hRatio = bounds.width / self.size.width;
  CGFloat vRatio = bounds.height / self.size.height;
  CGFloat ratio = MIN(hRatio, vRatio);
  CGSize newSize =
      CGSizeMake(self.size.width * ratio, self.size.height * ratio);
  UIGraphicsBeginImageContextWithOptions(newSize, YES, 0);
  [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
  UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}

@end
