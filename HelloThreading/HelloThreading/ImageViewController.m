//
//  ImageViewController.m
//  HelloThreading
//
//  Created by mcxiaoke on 15/8/16.
//  Copyright (c) 2015年 mcxiaoke. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong) UIImageView* imageView;
@property(nonatomic, strong) UIImage* image;
@property(weak, nonatomic) IBOutlet UIScrollView* scrollView;
@property(weak, nonatomic) IBOutlet UIActivityIndicatorView* spinner;

@end

@implementation ImageViewController

- (void)setImageURL:(NSURL*)imageURL {
  _imageURL = imageURL;
  //  self.image =[UIImage imageWithData:[NSData
  //  dataWithContentsOfURL:self.imageURL]];
  [self downloadImage];
}

- (void)downloadImage {
  self.image = nil;
  if (self.imageURL) {
    [self.spinner startAnimating];
    NSURLRequest* request = [NSURLRequest requestWithURL:self.imageURL];
    NSURLSessionConfiguration* configuration =
        [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession* session =
        [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask* task = [session
        downloadTaskWithRequest:request
              completionHandler:^(NSURL* location, NSURLResponse* response,
                                  NSError* error) {
                if (!error) {
                  if ([request.URL isEqual:self.imageURL]) {
                    UIImage* image = [UIImage
                        imageWithData:[NSData dataWithContentsOfURL:location]];
                    // dispatch_async(dispatch_get_main_queue(), ^{ self.image =
                    // image; });
                    [self performSelectorOnMainThread:@selector(setImage:)
                                           withObject:image
                                        waitUntilDone:NO];
                  }
                }
              }];
    [task resume];
  }
}

- (UIImageView*)imageView {
  if (!_imageView) {
    _imageView = [[UIImageView alloc] init];
  }
  return _imageView;
}

- (UIImage*)image {
  return self.imageView.image;
}

- (void)setImage:(UIImage*)image {
  self.imageView.image = image;
  [self.imageView sizeToFit];
  self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
  [self.spinner stopAnimating];
}

- (void)setScrollView:(UIScrollView*)scrollView {
  _scrollView = scrollView;
  _scrollView.minimumZoomScale = 0.2;
  _scrollView.maximumZoomScale = 2.0;
  _scrollView.delegate = self;
  self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView*)scrollView {
  return self.imageView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.scrollView addSubview:self.imageView];
  self.imageURL =
      [NSURL URLWithString:@"http://images.apple.com/v/iphone/world-gallery/c/"
             @"images/goodwin_list_large_2x.jpg"];
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
