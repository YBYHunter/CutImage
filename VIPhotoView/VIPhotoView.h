//
//  VIPhotoView.h
//  VIPhotoViewDemo
//
//  Created by Vito on 1/7/15.
//  Copyright (c) 2015 vito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIPhotoView : UIScrollView

@property (nonatomic, strong, readonly) UITapGestureRecognizer *doubleTapGestureRecognizer;

@property (nonatomic, strong, readonly) UIImage *image;

//裁剪区域
@property (nonatomic, assign, readonly) CGRect cutRect;

//初始化
- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image;

//滑动到图片中心位置
- (void)centerPositionWithAnimation:(BOOL)isAnimation;



@end
