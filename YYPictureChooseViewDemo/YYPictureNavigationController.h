//
//  YYPictureNavigationController.h
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/19.
//  Copyright © 2015年 leju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYPictureCoreManager.h"

#define YY_Navi ((YYPictureNavigationController *)self.navigationController)

@interface YYPictureNavigationController : UINavigationController
@property (nonatomic, weak) YYPictureCoreManager *manager;
@property (nonatomic, strong) NSArray<ALAsset *> *lastChoosedAsset;
@property (nonatomic, copy) void (^submit_click_block)(NSArray<ALAsset *> *assets);
@end
