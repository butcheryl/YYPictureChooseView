//
//  YYPictureChooseView.h
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/17.
//  Copyright © 2015年 leju. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAsset;
@protocol YYPictureChooseViewDelegate;

@interface YYPictureChooseView : UIView
@property (nonatomic, weak) id<YYPictureChooseViewDelegate> delegate;
@property (nonatomic, strong, nullable) NSArray *lastChooseData;
@end


@protocol YYPictureChooseViewDelegate <NSObject>
- (void)pictureChooseView:(nonnull YYPictureChooseView *)pictureChooseView photosCountChange:(nonnull NSArray *)photos;
@end