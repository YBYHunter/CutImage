//
//  UIImageView+VIUtil.h
//  VIPhotoViewDemo
//
//  Created by yu on 2017/12/3.
//  Copyright © 2017年 vito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+VIUtil.h"

@interface UIImageView (VIUtil)

- (CGSize)contentSizeWithType:(VIPhotoImageType)type;

/*
 * == yes is Vertica
 */
- (BOOL)isVerticaSlidingDirectionWithType:(VIPhotoImageType)type;








@end
