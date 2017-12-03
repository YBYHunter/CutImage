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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage *image = [UIImage imageNamed:@"timg.jpeg"];
    VIPhotoView *photoView = [[VIPhotoView alloc] initWithFrame:CGRectMake(10, 20, self.view.frame.size.width - 20, self.view.frame.size.width - 220) andImage:image];
    photoView.backgroundColor = [UIColor redColor];
    photoView.autoresizingMask = (1 << 6) -1;
    _photoView = photoView;
    [self.view addSubview:photoView];
    [self.view addSubview:self.cutImageView];
    
    [self.photoView centerPositionWithAnimation:NO];
    
    self.cutImageView.frame = CGRectMake((self.view.frame.size.width - 100)/2, photoView.frame.origin.y + photoView.frame.size.height + 10, 100, 100);
    
    UIView * lineView = [[UIView alloc] init];
    lineView.frame = self.cutImageView.bounds;
    lineView.backgroundColor = [UIColor clearColor];
    lineView.layer.borderColor = [UIColor redColor].CGColor;
    lineView.layer.borderWidth = 2;
    [self.cutImageView addSubview:lineView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    NSLog(@"%@", NSStringFromCGRect([[[self.view subviews] lastObject] frame]));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan - rect = %@",NSStringFromCGRect(_photoView.cutRect));
    
    UIImage * cutImage = [self imageFromImage:_photoView.image inRect:_photoView.cutRect];
    self.cutImageView.image = cutImage;
    
}

- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
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
