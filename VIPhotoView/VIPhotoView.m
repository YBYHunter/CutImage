//
//  VIPhotoView.m
//  VIPhotoViewDemo
//
//  Created by Vito on 1/7/15.
//  Copyright (c) 2015 vito. All rights reserved.
//

#import "VIPhotoView.h"

@interface VIPhotoView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTapGestureRecognizer;

@property (nonatomic, assign) CGSize minSize;

@property (nonatomic, assign) CGFloat currentScale;
@property (nonatomic, assign) VIPhotoImageType currentType;
@property (nonatomic, assign) BOOL currentIsVertica;

@end

@implementation VIPhotoView


- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image type:(VIPhotoImageType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.bouncesZoom = YES;
        _currentType = type;
        
        [self.containerView addGestureRecognizer:self.doubleTapGestureRecognizer];
        [self setupRotationNotification];
        
        // Add view
        [self addSubview:self.containerView];
        [self.containerView addSubview:self.imageView];
        
        [self updataDataWithImage:image];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}


#pragma mark - public method

- (void)centerPositionWithAnimation:(BOOL)isAnimation {
    CGFloat centerOffsetX = 0;
    CGFloat centerOffsetY = 0;
    
    if (self.currentIsVertica == NO) {
        //左右
        centerOffsetX = (self.contentSize.width - self.frame.size.width)/2;
        centerOffsetY = 0;
    }
    else {
        centerOffsetX = 0;
        centerOffsetY = (self.contentSize.height - self.frame.size.height)/2;
    }
    [self setContentOffset:CGPointMake(centerOffsetX, centerOffsetY) animated:isAnimation];
    
    //更新裁剪区域
    [self updateSubImageRectWith:self];
}

- (void)updataDataWithImage:(UIImage *)image {
    _image = image;
    _currentScale = 1;
    
    [self setZoomScale:self.minimumZoomScale animated:NO];
    
    self.imageView.image = image;
    self.containerView.frame = self.bounds;
    self.imageView.frame = self.containerView.bounds;
    
    __weak __typeof(self)weakSelf = self;
    CGSize imageSize = [self.imageView contentSizeWithType:_currentType block:^(BOOL isVertica) {
        weakSelf.currentIsVertica = isVertica;
    }];
    
    self.containerView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
    self.imageView.bounds = CGRectMake(0, 0, imageSize.width, imageSize.height);
    self.imageView.center = CGPointMake(imageSize.width / 2, imageSize.height / 2);
    
    self.contentSize = imageSize;
    self.minSize = imageSize;
    
    //更新cutRext值
    [self updateSubImageRectWith:self];
    
    //设置最小最大zoom
    [self setMaxMinZoomScale];
    
    // Center containerView by set insets
    if (_currentType == VIPhotoImageTypeAspectFit) {
        [self centerContent];
    }
    else {
        [self centerPositionWithAnimation:NO];
    }

}

#pragma mark - Setup

- (void)setupRotationNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.containerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self centerContent];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view {
    
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    _currentScale = scrollView.zoomScale;
    [self updateSubImageRectWith:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self updateSubImageRectWith:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateSubImageRectWith:scrollView];
}

- (void)updateSubImageRectWith:(UIScrollView *)scrollView {
    //需要裁剪的图片的size
    CGSize cutSize = [self getCutSize];
    
    //把contentOffset.x换算成image上面的点
    CGFloat cutOffsetX = scrollView.contentOffset.x * cutSize.width/scrollView.frame.size.width;
    CGFloat cutOffsetY = scrollView.contentOffset.y * cutSize.height/scrollView.frame.size.height;

    CGRect rect = CGRectMake(cutOffsetX/_currentScale,
                             cutOffsetY/_currentScale,
                             cutSize.width/_currentScale,
                             cutSize.height/_currentScale);
    
    _cutRect = rect;
}


#pragma mark - GestureRecognizer

- (void)tapHandler:(UITapGestureRecognizer *)recognizer
{
    if (self.zoomScale > self.minimumZoomScale) {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    } else if (self.zoomScale < self.maximumZoomScale) {
        CGPoint location = [recognizer locationInView:recognizer.view];

        CGRect zoomToRect = CGRectMake(0, 0, 50, 50);
        zoomToRect.origin = CGPointMake(location.x - CGRectGetWidth(zoomToRect)/2, location.y - CGRectGetHeight(zoomToRect)/2);
        [self zoomToRect:zoomToRect animated:YES];
    }
}

#pragma mark - Notification

- (void)orientationChanged:(NSNotification *)notification {
    
}

#pragma mark - Helper

- (CGSize)getCutSize {
    CGFloat cutWidth = 0;
    CGFloat cutHeight = 0;
    if (_image == nil) {
        NSLog(@"getCutSize - image == nil");
    }
    if (self.currentIsVertica == NO) {
        //左右
        cutHeight = _image.size.height;
        cutWidth = cutHeight * self.frame.size.width / self.frame.size.height;
    }
    else {
        //上下
        cutWidth = _image.size.width;
        cutHeight = cutWidth * self.frame.size.height / self.frame.size.width;
    }
    return CGSizeMake(cutWidth, cutHeight);
}

- (CGFloat)getMaxScale {
    CGSize imageSize = self.imageView.image.size;
    CGSize imagePresentationSize = [self.imageView contentSizeWithType:_currentType block:nil];
    CGFloat maxScale = MAX(imageSize.height / imagePresentationSize.height, imageSize.width / imagePresentationSize.width);
    return MAX(1.5, maxScale);
}

- (void)setMaxMinZoomScale {
    self.maximumZoomScale = [self getMaxScale];
    self.minimumZoomScale = 1.0;
}

- (void)centerContent
{
    CGRect frame = self.containerView.frame;
    
    CGFloat top = 0, left = 0;
    if (self.contentSize.width < self.bounds.size.width) {
        left = (self.bounds.size.width - self.contentSize.width) * 0.5f;
    }
    if (self.contentSize.height < self.bounds.size.height) {
        top = (self.bounds.size.height - self.contentSize.height) * 0.5f;
    }
    
    top -= frame.origin.y;
    left -= frame.origin.x;
    
    self.contentInset = UIEdgeInsetsMake(top, left, top, left);
}

#pragma mark - getter

- (UITapGestureRecognizer *)doubleTapGestureRecognizer {
    if (_doubleTapGestureRecognizer == nil) {
        _doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
        _doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    }
    return _doubleTapGestureRecognizer;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UIView *)containerView {
    if (_containerView == nil) {
        _containerView = [[UIView alloc] initWithFrame:self.bounds];
        _containerView.backgroundColor = [UIColor clearColor];
    }
    return _containerView;
}

#pragma mark - dealloc

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
