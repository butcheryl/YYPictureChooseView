//
//  YYPictureCoreManager.h
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/19.
//  Copyright © 2015年 leju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

extern NSString * const YYPictureEventAppendAsset;
extern NSString * const YYPictureEventRemoveAsset;

@interface YYPictureCoreManager : NSObject

/**
 *  @brief  已经选择的ALAsset
 */
@property (nonatomic, strong, readonly) NSMutableArray<ALAsset *> *choosedAsset;

/**
 *  @brief  设置之前选择的ALAsset
 *
 *  @param assets NSArray
 */
- (void)settingChoosedAssets:(NSArray<ALAsset *> *)assets;

//==========================================================================================//

/**
 *  @brief  已选列表中是否包含一个ALAsset
 *
 *  @return BOOL
 */
- (BOOL)containsAsset:(ALAsset *)asset;

/**
 *  @brief  选择一个ALAsset
 *
 *  @param asset ALAsset
 */
- (void)appendChoosedAsset:(ALAsset *)asset;

/**
 *  @brief  删除一个ALAsset
 *
 *  @param asset ALAsset
 */
- (void)removeChoosedAsset:(ALAsset *)asset;


//==========================================================================================//

/**
 *  @brief  通过ALAssetsGroup获取该组内的ALAsset
 *
 *  @param group    group ALAssetsGroup
 *  @param complete 成功回调
 */
- (void)assetListWithGroup:(ALAssetsGroup *)group complete:(void(^)(NSArray<ALAsset *> *result))complete;

/**
 *  @brief  返回相机交卷内的ALAsset
 *
 *  @param complete 成功回调
 *  @param error    失败回调
 */
- (void)getSavedPhotoList:(void (^)(NSArray<ALAsset *> *result))complete error:(void (^)(NSError *error))error;

/**
 *  @brief  获取资源库分组
 *
 *  @param complete 成功回调
 */
- (void)getGroupList:(void (^)(NSArray<ALAssetsGroup *> *result))complete;


- (void)writeImageToSavedPhotosAlbum:(UIImage *)image
                            metadata:(NSDictionary *)metadata
                          completion:(nullable void (^)(ALAsset *asset, NSArray<ALAsset *> *assetList))completion;
@end
