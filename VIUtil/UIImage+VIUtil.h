//
//  UIImage+VIUtil.h
//  VIPhotoViewDemo
//
//  Created by yu on 2017/12/3.
//  Copyright © 2017年 vito. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VIPhotoImageType) {
    /*
     * 不压缩比例，显示全部图片，有空隙
     * 没有适配切图功能
     */
    VIPhotoImageTypeAspectFit = 0,
    
    
    /*
     * 不压缩比例，显示部分图片，无空隙
     * 适配切图功能
     */
    VIPhotoImageTypeAspectFill,
};

@interface UIImage (VIUtil)

- (CGSize)sizeThatFits:(CGSize)size type:(VIPhotoImageType)type;

- (BOOL)isVerticaSlidingDirectionImageWithType:(VIPhotoImageType)type size:(CGSize)size;












@end
