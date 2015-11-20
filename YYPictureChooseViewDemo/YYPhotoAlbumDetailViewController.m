//
//  YYPhotoAlbumDetailViewController.m
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/18.
//  Copyright © 2015年 leju. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "YYPictureNavigationController.h"
#import "YYPhotoAlbumDetailViewController.h"
#import "YYPhotoAlbumDetailCollectionViewCell.h"
#import "YYPictureCaptureCameraCollectionViewCell.h"
#import "YYPictureCaptureDetailViewController.h"
#import "YYGridLayout.h"


@interface YYPhotoAlbumDetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) ALAssetsGroup *group;
@property (nonatomic, strong) NSArray<ALAsset *> *assetList;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) BOOL isCameraRoll;
@end

@implementation YYPhotoAlbumDetailViewController
- (nonnull instancetype)initWithAssetsGroup:(ALAssetsGroup *)group {
    if (self = [super init]) {
        self.group = group;
        self.isCameraRoll = (group == nil ||[[_group valueForProperty:ALAssetsGroupPropertyType] intValue] == ALAssetsGroupSavedPhotos);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:20], NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(left_bar_button_clicked:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(right_bar_button_clicked:)];
    
    [self.view addSubview:self.collectionView];
    
    
    [YY_Navi.manager assetListWithGroup:self.group complete:^(NSArray<ALAsset *> *result) {
        self.assetList = result;
        [self.collectionView reloadData];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload_view:) name:YYPictureEventAppendAsset object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload_view:) name:YYPictureEventRemoveAsset object:nil];

    
}

- (void)reload_view:(NSNotification *)noti {
    NSUInteger index = [self.assetList indexOfObject:noti.object];
    if (index < self.assetList.count) {
        [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:_isCameraRoll?1:0]]];
    } else {
        [self.collectionView reloadData];
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_isCameraRoll && indexPath.section == 0) {
        return ;
    }
    
    YYPictureCaptureDetailViewController *vc = [[YYPictureCaptureDetailViewController alloc] initWithAssetList:self.assetList currentPage:indexPath.item];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _isCameraRoll ? 2 : 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_isCameraRoll) {
        return section == 0 ? 1 : self.assetList.count;
    } else {
        return self.assetList.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_isCameraRoll && indexPath.section == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"camera" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor redColor];
        return cell;
    }
    
    ALAsset *asset = self.assetList[indexPath.item];
    
    YYPhotoAlbumDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"picture" forIndexPath:indexPath];
    cell.asset = asset;
    cell.manager = YY_Navi.manager;
    cell.choose = [YY_Navi.manager containsAsset:asset];
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = 0;
    if (_isCameraRoll &&  indexPath.section == 0) {
        width = (CGRectGetWidth(self.view.frame) - 5 * 3) / 2.;
        return CGSizeMake(width, width);
    }
    
    width = (CGRectGetWidth(self.view.frame) - 5 * 5) / 4.;
    return CGSizeMake(width, width);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark -
- (void)right_bar_button_clicked:(UIBarButtonItem *)barButtonItem {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)left_bar_button_clicked:(UIBarButtonItem *)barButtonItem {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter/setter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        id layout = nil;
        if (_isCameraRoll) {
            layout = [[YYGridLayout alloc] init];
        } else {
            layout = [[UICollectionViewFlowLayout alloc] init];
            [(UICollectionViewFlowLayout *)layout setMinimumLineSpacing:5];
            [(UICollectionViewFlowLayout *)layout setMinimumInteritemSpacing:5];
        }
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[YYPictureCaptureCameraCollectionViewCell class] forCellWithReuseIdentifier:@"camera"];
        [_collectionView registerClass:[YYPhotoAlbumDetailCollectionViewCell class] forCellWithReuseIdentifier:@"picture"];
    }
    return _collectionView;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
