//
//  YYPictureViewAddCell.m
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/17.
//  Copyright © 2015年 leju. All rights reserved.
//

#import "YYPictureViewAddCell.h"

@interface YYPictureViewAddCell ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation YYPictureViewAddCell

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor lightGrayColor];
        
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"post_add_images_hover_icon"]];
        [self.contentView addSubview:self.imageView];
        
        self.label = [[UILabel alloc] init];
        self.label.text = @"添加图片";
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont systemFontOfSize:11];
        [self.label sizeToFit];
        [self.contentView addSubview:self.label];
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat y = (CGRectGetHeight(self.contentView.frame) - CGRectGetHeight(self.imageView.frame) - CGRectGetHeight(self.label.frame))/2.;
    
    self.imageView.center = CGPointMake(CGRectGetWidth(self.contentView.frame)/2., y + CGRectGetHeight(self.imageView.frame) / 2.);
    self.label.center = CGPointMake(CGRectGetWidth(self.contentView.frame)/2., CGRectGetMaxY(self.imageView.frame) + CGRectGetHeight(self.label.frame));
}
@end
