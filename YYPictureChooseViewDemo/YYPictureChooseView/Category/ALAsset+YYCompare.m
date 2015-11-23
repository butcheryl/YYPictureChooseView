//
//  ALAsset+YYCompare.m
//  YYPictureChooseViewDemo
//
//  Created by Butcher on 15/11/19.
//  Copyright © 2015年 leju. All rights reserved.
//

#import "ALAsset+YYCompare.h"

@implementation ALAsset (YYCompare)
- (BOOL)isEqual:(id)obj {
    if(![obj isKindOfClass:[ALAsset class]])
        return NO;
    
    return ([self.description isEqualToString:[obj description]]);
}

- (UIImage *)getFullResolutionImage {
    // 需传入方向和缩放比例，否则方向和尺寸都不对
    UIImage *tempImg = [UIImage imageWithCGImage:self.defaultRepresentation.fullResolutionImage
                                           scale:self.defaultRepresentation.scale
                                     orientation:(UIImageOrientation)self.defaultRepresentation.orientation];
    return tempImg;
}
@end
