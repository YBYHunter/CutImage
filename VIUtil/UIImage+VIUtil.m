//
//  UIImage+VIUtil.m
//  VIPhotoViewDemo
//
//  Created by yu on 2017/12/3.
//  Copyright © 2017年 vito. All rights reserved.
//

#import "UIImage+VIUtil.h"

@implementation UIImage (VIUtil)

- (CGSize)sizeThatFits:(CGSize)size type:(VIPhotoImageType)type block:(void(^)(BOOL))block {
    CGSize imageSize = CGSizeMake(self.size.width / self.scale,
                                  self.size.height / self.scale);
    
    CGFloat widthRatio = imageSize.width / size.width;
    CGFloat heightRatio = imageSize.height / size.height;
    
    if (type == VIPhotoImageTypeAspectFit) {
        if (widthRatio > heightRatio) {
            //左右滑动图
            imageSize = CGSizeMake(imageSize.width / widthRatio, imageSize.height / widthRatio);
            if (block) {
                block(NO);
            }
        } else {
            //上下滑动
            imageSize = CGSizeMake(imageSize.width / heightRatio, imageSize.height / heightRatio);
            if (block) {
                block(YES);
            }
        }
    }
    else {
        if (widthRatio > heightRatio) {
            //左右滑动图
            imageSize = CGSizeMake(imageSize.width / heightRatio, imageSize.height / heightRatio);
            if (block) {
                block(NO);
            }
        } else {
            //上下滑动
            imageSize = CGSizeMake(imageSize.width / widthRatio, imageSize.height / widthRatio);
            if (block) {
                block(YES);
            }
        }
    }
    
    return imageSize;
}


//- (void)setIsVerticaSliding:(BOOL)isVerticaSliding {
//    _isVerticaSliding = isVerticaSliding;
//}


@end
