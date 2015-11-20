//
//  YYPictureCaptureDetailViewController.h
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/19.
//  Copyright © 2015年 leju. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALAsset;

@interface YYPictureCaptureDetailViewController : UIViewController
- (instancetype)initWithAssetList:(NSArray<ALAsset *> *)assetList currentPage:(NSInteger)page;
@end
