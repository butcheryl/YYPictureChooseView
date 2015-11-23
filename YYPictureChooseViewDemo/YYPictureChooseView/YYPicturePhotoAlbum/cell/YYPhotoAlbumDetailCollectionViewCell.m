//
//  YYPictureCapturePictureCollectionViewCell.m
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/18.
//  Copyright © 2015年 leju. All rights reserved.
//

#import "YYPhotoAlbumDetailCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "BEMCheckBox.h"
#import "YYPictureCoreManager.h"

@interface YYPhotoAlbumDetailCollectionViewCell () <BEMCheckBoxDelegate>
@property (nonatomic, strong) UIImageView *picture_view;
@property (nonatomic, strong) BEMCheckBox *choose_button;
@end

@implementation YYPhotoAlbumDetailCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.picture_view = [[UIImageView alloc] init];
        self.picture_view.clipsToBounds = NO;
        self.picture_view.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.picture_view];
        
        self.choose_button = [[BEMCheckBox alloc] init];
        self.choose_button.onAnimationType = BEMAnimationTypeFill;
        self.choose_button.delegate = self;
        self.choose_button.tintColor = [UIColor lightGrayColor];
        self.choose_button.onTintColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
        self.choose_button.onFillColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
        self.choose_button.onCheckColor = [UIColor whiteColor];

        [self.contentView addSubview:self.choose_button];
    }
    return self;
}

- (void)didTapCheckBox:(BEMCheckBox*)checkBox {
    if (checkBox.on) {
        if (self.manager.choosedAsset.count == 8) {
            checkBox.on = NO;
            return ;
        }
        [self.manager appendChoosedAsset:self.asset];
    } else {
        [self.manager removeChoosedAsset:self.asset];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.picture_view.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
    self.choose_button.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - 30 -2, 2, 30, 30);
    [self.choose_button reload];
}

#pragma mark - getter/setter
- (void)setAsset:(ALAsset *)asset {
    _asset = asset;
    @autoreleasepool {
        UIImage* image = [UIImage imageWithCGImage:[asset thumbnail]];
        [self.picture_view setImage:image];
    }
}

- (void)setChoose:(BOOL)choose {
    _choose = choose;
    [self.choose_button setOn:_choose animated:NO];
}

@end
