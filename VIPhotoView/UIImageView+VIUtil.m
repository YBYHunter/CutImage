//
//  UIImageView+VIUtil.m
//  VIPhotoViewDemo
//
//  Created by yu on 2017/12/3.
//  Copyright © 2017年 vito. All rights reserved.
//

#import "UIImageView+VIUtil.h"

@implementation UIImageView (VIUtil)

- (CGSize)contentSizeWithType:(VIPhotoImageType)type {
    return [self.image sizeThatFits:self.bounds.size type:type];
}

- (BOOL)isVerticaSlidingDirectionWithType:(VIPhotoImageType)type {
    return [self.image isVerticaSlidingDirectionImageWithType:type size:self.bounds.size];
}






@end
