//
//  YYPictureCaptureBottomView.h
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/18.
//  Copyright © 2015年 leju. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAsset;
@class YYPictureCoreManager;
@protocol YYPictureCaptureBottomViewDelegate;

@interface YYPictureCaptureBottomView : UIView
@property (nonatomic, weak) YYPictureCoreManager *manager;
@property (nonatomic, weak) id <YYPictureCaptureBottomViewDelegate> delegate;
@end


@protocol YYPictureCaptureBottomViewDelegate <NSObject>
- (void)submit_button_clicked;
@end