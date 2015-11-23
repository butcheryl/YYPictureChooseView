//
//  YYPictureCaptureDetailCollectionViewCell.m
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/19.
//  Copyright © 2015年 leju. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "YYPictureCaptureDetailCollectionViewCell.h"

@interface YYPictureCaptureDetailCollectionViewCell ()
@property (nonatomic, strong) UIImageView *picture_view;
@end

@implementation YYPictureCaptureDetailCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.picture_view = [[UIImageView alloc] init];
        self.picture_view.clipsToBounds = YES;
        self.picture_view.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:self.picture_view];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.picture_view.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
}


#pragma mark - getter/setter
- (void)setAsset:(ALAsset *)asset {
    _asset = asset;
    [self loadImage:_asset];
}


- (void)loadImage:(ALAsset*)asset {
    @autoreleasepool {
        ALAssetRepresentation *rep = [asset defaultRepresentation];
        CGImageRef iref = [rep fullScreenImage];
        UIImage *image = [UIImage imageWithCGImage:iref scale:[rep scale] orientation:UIImageOrientationUp];
        [self.picture_view setImage:image];
    }
}
@end
