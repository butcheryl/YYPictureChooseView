//
//  YYPictureViewImageCell.m
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/17.
//  Copyright © 2015年 leju. All rights reserved.
//

#import "YYPictureViewImageCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface YYPictureViewImageCell ()
@property (nonatomic, strong) UIImageView *pictureView;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UILabel * mainPictureTag;
@end

@implementation YYPictureViewImageCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.pictureView = [[UIImageView alloc] init];
        self.pictureView.clipsToBounds = NO;
        self.pictureView.contentMode = UIViewContentModeScaleAspectFill;
        self.pictureView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.pictureView];
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteButton.frame = CGRectMake(-10, -10, 20, 20);
        self.deleteButton.layer.cornerRadius = 10;
        self.deleteButton.layer.masksToBounds = YES;
        [self.deleteButton setBackgroundColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]];
        [self.deleteButton setTitle:@"×" forState:UIControlStateNormal];
        [self.deleteButton setTitleColor:[UIColor colorWithRed:250/255. green:214/255. blue:87/255. alpha:1] forState:UIControlStateNormal];
        
        [self.deleteButton addTarget:self action:@selector(delete_button_clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.deleteButton];

        self.mainPictureTag = [[UILabel alloc] init];
        self.mainPictureTag.hidden = YES;
        self.mainPictureTag.text = @"主图";
        self.mainPictureTag.font = [UIFont systemFontOfSize:13];
        self.mainPictureTag.textColor = [UIColor darkGrayColor];
        self.mainPictureTag.textAlignment = NSTextAlignmentCenter;
        self.mainPictureTag.backgroundColor = [UIColor colorWithRed:250/255. green:214/255. blue:87/255. alpha:1];
        [self.contentView addSubview:self.mainPictureTag];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.pictureView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
    self.mainPictureTag.frame = CGRectMake(0, CGRectGetHeight(self.contentView.frame) - 20, CGRectGetWidth(self.contentView.frame), 20);
}

- (void)delete_button_clicked:(UIButton *)button {
    if ([self deleteButtonClickedAction]) {
        self.deleteButtonClickedAction(self);
    }
}

#pragma mark - getter/setter
- (void)setIsMainPicture:(BOOL)isMainPicture {
    _isMainPicture = isMainPicture;
    
    self.mainPictureTag.hidden = !_isMainPicture;
}
- (void)setAsset:(ALAsset *)asset {
    _asset = asset;
    self.pictureView.image = [UIImage imageWithCGImage:[asset thumbnail]];
}
@end
