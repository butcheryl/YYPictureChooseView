//
//  YYPictureCaptureDetailViewController.m
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/19.
//  Copyright © 2015年 leju. All rights reserved.
//

#import "BEMCheckBox.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "YYPictureCaptureDetailViewController.h"
#import "YYPictureCaptureDetailCollectionViewCell.h"
#import "YYPictureCaptureBottomView.h"
#import "YYPictureNavigationController.h"

@interface YYPictureCaptureDetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, BEMCheckBoxDelegate>
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray<ALAsset *> *assetList;
@property (nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic, assign) CGPoint beginPoint;
@end

@implementation YYPictureCaptureDetailViewController
- (instancetype)initWithAssetList:(NSArray<ALAsset *> *)assetList currentPage:(NSInteger)page {
    if (self = [super init]) {
        self.page = page;
        self.assetList = assetList;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"album_back"] style:UIBarButtonItemStylePlain target:self action:@selector(left_bar_button_clicked:)];
    
    BEMCheckBox *button = [[BEMCheckBox alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    button.tag = 999;
    button.onAnimationType = BEMAnimationTypeFill;
    button.delegate = self;
    button.tintColor = [UIColor lightGrayColor];
    button.onTintColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
    button.onFillColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
    button.onCheckColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    
    [self.view addSubview:self.collectionView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change_right_bar_button_status:) name:YYPictureEventAppendAsset object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change_right_bar_button_status:) name:YYPictureEventRemoveAsset object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_page inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

- (void)change_right_bar_button_status:(NSNotification *)noti {
    BEMCheckBox *button = [self.navigationController.navigationBar viewWithTag:999];
    button.on = [noti.name isEqualToString:YYPictureEventAppendAsset];
}

#pragma mark - Response Event
- (void)left_bar_button_clicked:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - BEMCheckBoxDelegate
- (void)didTapCheckBox:(BEMCheckBox*)checkBox {
    if (YY_Navi.manager.choosedAsset.count == 8) {
        checkBox.on = NO;
        return ;
    }
    
    NSIndexPath *indexPath = [self.collectionView indexPathsForVisibleItems].firstObject;
    if (checkBox.on) {
        [YY_Navi.manager appendChoosedAsset:self.assetList[indexPath.item]];
    } else {
        [YY_Navi.manager removeChoosedAsset:self.assetList[indexPath.item]];
    }
}



#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    BEMCheckBox *button = [self.navigationController.navigationBar viewWithTag:999];
    button.on = [YY_Navi.manager containsAsset:self.assetList[indexPath.item]];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YYPictureCaptureDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.asset = self.assetList[indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 80 - 44);
}

#pragma mark - getter/setter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 80) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        
        [_collectionView registerClass:[YYPictureCaptureDetailCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
