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
@end

@implementation YYPictureViewAddCell

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor lightGrayColor];
        self.label = [[UILabel alloc] init];
        self.label.text = @"+";
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:80];
        [self.label sizeToFit];
        [self.contentView addSubview:self.label];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.label.center = CGPointMake(CGRectGetWidth(self.contentView.frame)/2., CGRectGetHeight(self.contentView.frame)/2. - 5);
}
@end
