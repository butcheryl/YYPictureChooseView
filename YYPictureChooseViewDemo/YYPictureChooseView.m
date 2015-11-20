//
//  YYPictureChooseView.m
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/17.
//  Copyright © 2015年 leju. All rights reserved.
//

#import "YYPictureChooseView.h"
#import "YYPictureViewAddCell.h"
#import "YYPictureViewImageCell.h"
#import "YYPictureDetailViewController.h"
#import "YYPhotoAlbumDetailViewController.h"
#import "YYPhotoAlbumListViewController.h"
#import "YYPictureNavigationController.h"
#import "YYPictureCoreManager.h"

@interface YYPictureChooseView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *view;
@property (nonatomic, strong) YYPictureCoreManager *manager;
@property (nonatomic, assign) NSInteger mainPictureIndex;
@end

@implementation YYPictureChooseView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.manager = [[YYPictureCoreManager alloc] init];
        self.choosedData = [NSMutableArray array];
        
        [self addSubview:self.view];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload_view:) name:YYPictureEventAppendAsset object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload_view:) name:YYPictureEventRemoveAsset object:nil];
    }
    return self;
}

- (void)reload_view:(NSNotification *)noti {
    [self.view reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (CGRectGetWidth(self.frame) - 5 * 10) / 4;
    return CGSizeMake(width, width);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self _isAddItem:indexPath]) {
        YYPhotoAlbumListViewController *vc = [[YYPhotoAlbumListViewController alloc] init];
        YYPictureNavigationController *navi = [[YYPictureNavigationController alloc] initWithRootViewController:vc];
        navi.manager = self.manager;
        navi.lastChoosedAsset = self.choosedData;
        [navi setSubmit_click_block:^(NSArray<ALAsset *> *assets) {
            self.choosedData = [NSMutableArray arrayWithArray:assets];
            [self.view reloadData];
        }];
        [(UIViewController *)self.delegate presentViewController:navi animated:YES completion:nil];
    } else {
        __block ALAsset *asset = self.choosedData[indexPath.item];
        YYPictureDetailViewController *vc = [[YYPictureDetailViewController alloc] initWithAsset:asset isMain:_mainPictureIndex == indexPath.item];
        [vc setSettingMainPicktureBlock:^() {
            self.mainPictureIndex = indexPath.item;
            [self.view reloadData];
        }];
        
        [vc setDeletePicktureBlock:^() {
            [self deletePictureAtIndex:indexPath.item];
        }];
        
        [((UIViewController *)self.delegate) presentViewController:vc animated:YES completion:nil];        
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.choosedData.count == 8 ? 8 : self.choosedData.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    if ([self _isAddItem:indexPath]) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"add" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"image" forIndexPath:indexPath];
        [(YYPictureViewImageCell *)cell setIsMainPicture:indexPath.item == self.mainPictureIndex];
        [(YYPictureViewImageCell *)cell setAsset:self.choosedData[indexPath.item]];
        [(YYPictureViewImageCell *)cell setDeleteButtonClickedAction:^(YYPictureViewImageCell *cell) {
            [self deletePictureAtIndex:indexPath.item];
        }];
        
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

#pragma mark - getter/setter
- (UICollectionView *)view {
    if (!_view) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        
        _view = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _view.delegate = self;
        _view.dataSource = self;
        [_view registerClass:[YYPictureViewAddCell class] forCellWithReuseIdentifier:@"add"];
        [_view registerClass:[YYPictureViewImageCell class] forCellWithReuseIdentifier:@"image"];
    }
    
    return _view;
}

#pragma mark - private
- (void)deletePictureAtIndex:(NSInteger)index {
    if (index == self.mainPictureIndex) {
        self.mainPictureIndex = 0;
    } else if (index < self.mainPictureIndex){
        self.mainPictureIndex--;
    }
    [self.choosedData removeObjectAtIndex:index];
    [self.view reloadData];
}

- (BOOL)_isAddItem:(NSIndexPath *)indexPath {
    return indexPath.item == self.choosedData.count;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
