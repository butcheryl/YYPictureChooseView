//
//  YYGridLayout.m
//  customGrid
//
//  Created by 王晨 on 15/11/18.
//  Copyright © 2015年 zhfish. All rights reserved.
//

#import "YYGridLayout.h"

@interface YYGridLayout ()

@end

@implementation YYGridLayout {
    NSArray *_prepareRects;
}

- (CGSize)collectionViewContentSize
{
    CGRect rect = [[[_prepareRects lastObject] lastObject] CGRectValue];
    
    return CGSizeMake(CGRectGetWidth(self.collectionView.bounds), CGRectGetMaxY(rect) + 5);
}

- (void)prepareLayout {
    [super prepareLayout];
    
    [self prepareRect];
}

- (void)prepareRect {
    NSInteger numberOfSections = [self.collectionView numberOfSections] ;
    if (numberOfSections != 2) {
        return;
    }
    
    CGRect offsetRect = CGRectZero;
    CGFloat width = CGRectGetWidth(self.collectionView.bounds);
    CGFloat blank = 5;
    CGFloat coloum = 4;
    CGFloat big = ((width - (coloum/2+1)*blank)/(coloum/2));
    CGFloat small = ((width - (coloum+1)*blank)/coloum);
    
    NSMutableArray *section = @[].mutableCopy;
    
    NSMutableArray *item1 = @[].mutableCopy;
    NSMutableArray *item2 = @[].mutableCopy;
    [section addObject:item1];
    [section addObject:item2];

    offsetRect = CGRectMake(blank, blank, big, big);
    [item1 addObject:[NSValue valueWithCGRect:offsetRect]];
    
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:1];
    for (int i = 0; i < numberOfItems; i++) {
        if (i < 4) {
            offsetRect = CGRectMake((blank+big+blank) + (small+blank)*(i%2),blank + (small+blank)*(i/2),small,small);
        }
        else {
            offsetRect = CGRectMake(blank + (small+blank)*((i-4)%4),(blank+big+blank) + (small+blank)*((i-4)/4),small,small);
        }
        [item2 addObject:[NSValue valueWithCGRect:offsetRect]];
    }
    
    _prepareRects = section;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *layoutAttributes = @[].mutableCopy;
    
    CGRect r = [_prepareRects[0][0] CGRectValue];
    if (CGRectIntersectsRect(r, rect)) {
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        attr.frame = r;
        [layoutAttributes addObject:attr];
    }

    for (NSInteger i = 0; i < [_prepareRects[1] count]; i++) {
        r = [_prepareRects[1][i] CGRectValue];
        if (CGRectIntersectsRect(r, rect)) {
            UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:1]];
            attr.frame = r;
            [layoutAttributes addObject:attr];
        }
    }
    
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *currentAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    return currentAttributes;
}

- (UICollectionViewLayoutAttributes*)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    CGRect r = [_prepareRects[itemIndexPath.section][itemIndexPath.item] CGRectValue];
    attr.frame = r;
    
    return attr;
}

@end
