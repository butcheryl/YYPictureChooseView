//
//  YYPictureCaptureBottomView.m
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/18.
//  Copyright © 2015年 leju. All rights reserved.
//

#import "YYPictureCaptureBottomView.h"
#import "YYPictureViewImageCell.h"
#import "YYPictureNavigationController.h"

@interface YYPictureCaptureBottomView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIButton *submit_button;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation YYPictureCaptureBottomView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        
        [self addSubview:self.collectionView];
        
        self.submit_button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.submit_button.frame = CGRectMake(CGRectGetMaxX(self.collectionView.frame) + 10, 20, 60, 40);
        self.submit_button.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.submit_button setBackgroundColor:[UIColor whiteColor]];
        [self.submit_button setTitle:@"确定" forState:UIControlStateNormal];
        [self.submit_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.submit_button addTarget:self action:@selector(submit_button_clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.submit_button];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload_view:) name:YYPictureEventAppendAsset object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload_view:) name:YYPictureEventRemoveAsset object:nil];
    }
    return self;
}

- (void)reload_view:(NSNotification *)noti {
    [self.submit_button setTitle:[NSString stringWithFormat:@"确定(%ld/8)", self.manager.choosedAsset.count] forState:UIControlStateNormal];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = CGRectGetHeight(self.frame) - 10;
    return CGSizeMake(width, width);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.manager.choosedAsset.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    __block ALAsset *asset = self.manager.choosedAsset[indexPath.item];
    
    [(YYPictureViewImageCell *)cell setAsset:asset];
    [(YYPictureViewImageCell *)cell setDeleteButtonClickedAction:^(YYPictureViewImageCell *cell) {
        [self.manager removeChoosedAsset:asset];
    }];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (void)submit_button_clicked:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(submit_button_clicked)]) {
        [self.delegate submit_button_clicked];
    }
}

#pragma mark - getter/setter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame) - 80, CGRectGetHeight(self.frame)) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[YYPictureViewImageCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
