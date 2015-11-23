//
//  YYPictureDetailViewController.h
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/18.
//  Copyright © 2015年 leju. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALAsset;

@interface YYPictureDetailViewController : UIViewController
@property (nonatomic, assign) BOOL isMainPicture;
@property (nonatomic, strong) ALAsset *asset;

@property (nonatomic, copy) void (^settingMainPicktureBlock)();
@property (nonatomic, copy) void (^deletePicktureBlock)();


- (instancetype)initWithAsset:(ALAsset *)asset isMain:(BOOL)isMain;
@end
