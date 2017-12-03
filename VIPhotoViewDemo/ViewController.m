//
//  ViewController.m
//  VIPhotoViewDemo
//
//  Created by Vito on 1/7/15.
//  Copyright (c) 2015 vito. All rights reserved.
//

#import "ViewController.h"
#import "VIPhotoView.h"

@interface ViewController ()

@property (nonatomic,strong) UIImageView * cutImageView;

@property (nonatomic,strong) VIPhotoView * photoView;;

@property (nonatomic,strong) UIButton * verticaButton;

@property (nonatomic,strong) UIButton * horizontalButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage *image = [UIImage imageNamed:@"d53f8794a4c27d1eef5c850c11d5ad6edcc438fb.jpg"];
    VIPhotoView *photoView = [[VIPhotoView alloc] initWithFrame:CGRectMake(10, 20, self.view.frame.size.width - 20, self.view.frame.size.width - 20) andImage:image type:VIPhotoImageTypeAspectFill];
    photoView.backgroundColor = [UIColor redColor];

    _photoView = photoView;
    [self.view addSubview:photoView];
    [self.view addSubview:self.cutImageView];
    [self.view addSubview:self.horizontalButton];
    [self.view addSubview:self.verticaButton];
    
    self.cutImageView.frame = CGRectMake((self.view.frame.size.width - 100)/2, photoView.frame.origin.y + photoView.frame.size.height + 10, 100, 100);
    
    self.verticaButton.frame = CGRectMake((self.view.frame.size.width/2 - 64)/2, self.cutImageView.frame.origin.y + self.cutImageView.frame.size.height + 10, 64, 64);
    
    self.horizontalButton.frame = CGRectMake(self.view.frame.size.width/2 + 10, self.cutImageView.frame.origin.y + self.cutImageView.frame.size.height + 10, 64, 64);
}

#pragma mark - touch method

- (void)horizontalButtonAction {
    [_photoView updataDataWithImage:[UIImage imageNamed:@"timg.jpeg"]];
}

- (void)verticaButtonAction {
    [_photoView updataDataWithImage:[UIImage imageNamed:@"d53f8794a4c27d1eef5c850c11d5ad6edcc438fb.jpg"]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan - rect = %@",NSStringFromCGRect(_photoView.cutRect));
    
    UIImage * cutImage = [self imageFromImage:_photoView.image inRect:_photoView.cutRect];
    self.cutImageView.image = cutImage;
    
}

#pragma mark - cut image

- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}

#pragma mark - getter

- (UIButton *)horizontalButton {
    if (_horizontalButton == nil) {
        _horizontalButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_horizontalButton setTitle:@"horizontal" forState:UIControlStateNormal];
        _horizontalButton.backgroundColor = [UIColor blackColor];
        [_horizontalButton addTarget:self action:@selector(horizontalButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _horizontalButton;
}

- (UIButton *)verticaButton {
    if (_verticaButton == nil) {
        _verticaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_verticaButton setTitle:@"vertica" forState:UIControlStateNormal];
        _verticaButton.backgroundColor = [UIColor blackColor];
        [_verticaButton addTarget:self action:@selector(verticaButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verticaButton;
}

- (UIImageView *)cutImageView {
    if (_cutImageView == nil) {
        _cutImageView = [[UIImageView alloc] init];
        _cutImageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _cutImageView;
}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
