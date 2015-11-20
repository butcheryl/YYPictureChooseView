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
@end
