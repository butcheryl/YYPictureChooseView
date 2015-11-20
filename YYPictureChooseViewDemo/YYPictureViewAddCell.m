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
        self.label = [[UILabel alloc] init];
        self.label.text = @"+";
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont boldSystemFontOfSize:60];
        [self.contentView addSubview:self.label];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}
@end
