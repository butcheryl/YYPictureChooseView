//
//  YYPictureCaptureCameraCollectionViewCell.m
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/18.
//  Copyright © 2015年 leju. All rights reserved.
//

#import "YYPictureCaptureCameraCollectionViewCell.h"

@interface YYPictureCaptureCameraCollectionViewCell ()
@property (nonatomic, strong) UIImageView *image;
@end

@implementation YYPictureCaptureCameraCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor grayColor];
        
        self.image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"steppost_camera_icon2"]];
        [self.contentView addSubview:self.image];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.image.center = CGPointMake(CGRectGetWidth(self.contentView.frame)/2., CGRectGetHeight(self.contentView.frame)/2.);
}
@end
