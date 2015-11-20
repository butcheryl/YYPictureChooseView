//
//  YYPictureViewImageCell.h
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/17.
//  Copyright © 2015年 leju. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALAsset;

@interface YYPictureViewImageCell : UICollectionViewCell
@property (nonatomic, strong) ALAsset *asset;
@property (nonatomic, assign) BOOL isMainPicture;
@property (nonatomic, copy) void (^deleteButtonClickedAction)(YYPictureViewImageCell *cell);
@end
