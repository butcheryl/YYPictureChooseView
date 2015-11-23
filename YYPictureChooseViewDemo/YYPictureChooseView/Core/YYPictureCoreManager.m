//
//  YYPictureCoreManager.m
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/19.
//  Copyright © 2015年 leju. All rights reserved.
//

#import "YYPictureCoreManager.h"

@interface YYPictureCoreManager ()
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;

@property (nonatomic, strong) NSArray<ALAsset *> *savePhots;
@property (nonatomic, strong) NSArray<ALAssetsGroup *> *groupList;
@property (nonatomic, strong) NSMutableArray<ALAsset *> *choosedAsset;
@end

@implementation YYPictureCoreManager

- (instancetype)init {
    if (self = [super init]) {
        self.assetsLibrary = [[ALAssetsLibrary alloc] init];
        self.choosedAsset = [NSMutableArray array];
    }
    return self;
}

- (void)settingChoosedAssets:(NSArray<ALAsset *> *)assets {
    [self.choosedAsset removeAllObjects];
    [self.choosedAsset addObjectsFromArray:assets];
}

- (BOOL)containsAsset:(ALAsset *)asset {
    return [self.choosedAsset containsObject:asset];
}

- (void)removeChoosedAsset:(ALAsset *)asset {
    [self.choosedAsset removeObject:asset];
    [[NSNotificationCenter defaultCenter] postNotificationName:YYPictureEventRemoveAsset object:asset];
}

- (void)appendChoosedAsset:(ALAsset *)asset {
    [self.choosedAsset addObject:asset];
    [[NSNotificationCenter defaultCenter] postNotificationName:YYPictureEventAppendAsset object:asset];
}

- (void)assetListWithGroup:(ALAssetsGroup *)group complete:(void(^)(NSArray<ALAsset *> *result))complete {
    if (group == nil || [[group valueForProperty:ALAssetsGroupPropertyType] intValue] == ALAssetsGroupSavedPhotos) {
        if (self.savePhots == nil) {
            [self getSavedPhotoList:complete error:nil];
        } else {
            if (complete) {
                return complete([self.savePhots copy]);
            }
        }
    }
    
    NSMutableArray *result = [NSMutableArray array];
    [group setAssetsFilter:[ALAssetsFilter allPhotos]];
    [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        if (asset == nil) {
            if (complete != nil) {
                complete([[result reverseObjectEnumerator] allObjects]);
            }
            return ;
        }
        
        [result addObject:asset];
    }];
}

- (void)getSavedPhotoList:(void (^)(NSArray<ALAsset *> *))complete error:(void (^)(NSError *))error {
    if (self.savePhots) {
        if (complete) {
            return complete([self.savePhots copy]);
        }
    }
    
    NSMutableArray *result = [NSMutableArray array];
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if ([[group valueForProperty:ALAssetsGroupPropertyType] intValue] == ALAssetsGroupSavedPhotos) {
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *st) {
                if(asset == nil) {
                    if (complete) {
                        self.savePhots = [[result reverseObjectEnumerator] allObjects];
                        complete([self.savePhots copy]);
                    }
                    return ;
                }
                [result addObject:asset];
            }];
        }
    } failureBlock:^(NSError *err) {
        if (error) {
            error(err);
        }
    }];
}

- (void)getGroupList:(void (^)(NSArray<ALAssetsGroup *> *))complete {
    if (self.groupList) {
        if (complete) {
            return complete(self.groupList);
        }
    }
    
    NSMutableArray<ALAssetsGroup *> *result = [NSMutableArray array];
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group == nil) {
            if (complete) {
                self.groupList = result;
                complete(result);
            }
            return ;
        }
        [result addObject:group];
    } failureBlock:^(NSError *error) {
        
    }];
}

- (void)writeImageToSavedPhotosAlbum:(UIImage *)image metadata:(NSDictionary *)metadata completion:(nullable void (^)(ALAsset *asset, NSArray<ALAsset *> *assetList))completion {
    [self.assetsLibrary writeImageToSavedPhotosAlbum:image.CGImage metadata:metadata completionBlock:^(NSURL *assetURL, NSError *error) {
        [self.assetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            if (completion) {
                NSMutableArray *array = [NSMutableArray arrayWithObject:asset];
                [array addObjectsFromArray:self.savePhots];
                self.savePhots = array;
                completion(asset, [self.savePhots copy]);
            }
        } failureBlock:^(NSError *error) {
            
        }];
    }];
}
@end


NSString * const YYPictureEventAppendAsset = @"YYPictureEventAppendAsset";
NSString * const YYPictureEventRemoveAsset = @"YYPictureEventRemoveAsset";