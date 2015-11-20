//
//  YYPictureChooseView.h
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/17.
//  Copyright © 2015年 leju. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAsset;

@protocol YYPictureChooseViewDelegate <NSObject>
//- (void)pictureChooseView:(nonnull YYPictureChooseView *)pictureChooseView didSelectItemAtIndex:(NSInteger)index;
@end

@protocol YYPictureChooseViewDataSource <NSObject>

@end

@interface YYPictureChooseView : UIView
@property (nonatomic, strong, nullable) NSMutableArray *choosedData;
@property (nonatomic, weak, nullable) id <YYPictureChooseViewDelegate> delegate;
@property (nonatomic, weak, nullable) id <YYPictureChooseViewDataSource> dataSource;

@end
