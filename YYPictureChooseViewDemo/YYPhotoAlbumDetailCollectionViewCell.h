//
//  YYPictureCapturePictureCollectionViewCell.h
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/18.
//  Copyright © 2015年 leju. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALAsset;
@class YYPictureCoreManager;

@interface YYPhotoAlbumDetailCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) ALAsset *asset;
@property (nonatomic, assign, getter=isChoose) BOOL choose;
@property (nonatomic, weak) YYPictureCoreManager *manager;
@end
