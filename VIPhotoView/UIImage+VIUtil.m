//
//  UIImage+VIUtil.m
//  VIPhotoViewDemo
//
//  Created by yu on 2017/12/3.
//  Copyright © 2017年 vito. All rights reserved.
//

#import "UIImage+VIUtil.h"

@implementation UIImage (VIUtil)

- (CGSize)sizeThatFits:(CGSize)size type:(VIPhotoImageType)type {
    CGSize imageSize = CGSizeMake(self.size.width / self.scale,
                                  self.size.height / self.scale);
    
    CGFloat widthRatio = imageSize.width / size.width;
    CGFloat heightRatio = imageSize.height / size.height;
    
    if (type == VIPhotoImageTypeAspectFit) {
        if (widthRatio > heightRatio) {
            //左右滑动图
            imageSize = CGSizeMake(imageSize.width / widthRatio, imageSize.height / widthRatio);
        } else {
            //上下滑动
            imageSize = CGSizeMake(imageSize.width / heightRatio, imageSize.height / heightRatio);
        }
    }
    else {
        if (widthRatio > heightRatio) {
            //左右滑动图
            imageSize = CGSizeMake(imageSize.width / heightRatio, imageSize.height / heightRatio);
        } else {
            //上下滑动
            imageSize = CGSizeMake(imageSize.width / widthRatio, imageSize.height / widthRatio);
        }
    }
    
    return imageSize;
}

- (BOOL)isVerticaSlidingDirectionImageWithType:(VIPhotoImageType)type size:(CGSize)size {
    CGSize imageSize = CGSizeMake(self.size.width / self.scale,
                                  self.size.height / self.scale);
    
    CGFloat widthRatio = imageSize.width / size.width;
    CGFloat heightRatio = imageSize.height / size.height;
    
    BOOL isVertica = NO;
    if (type == VIPhotoImageTypeAspectFit) {
        if (widthRatio > heightRatio) {
            //左右滑动图
            isVertica = YES;
        } else {
            //上下滑动
            isVertica = NO;
        }
    }
    else {
        if (widthRatio > heightRatio) {
            //左右滑动图
            isVertica = NO;
        } else {
            //上下滑动
            isVertica = YES;
        }
    }
    return isVertica;
}

@end
