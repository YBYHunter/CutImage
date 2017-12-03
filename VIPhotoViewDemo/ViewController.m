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
    [photoView centerPositionWithAnimation:NO];
    _photoView = photoView;
    [self.view addSubview:photoView];
    [self.view addSubview:self.cutImageView];
    
    self.cutImageView.frame = CGRectMake((self.view.frame.size.width - 100)/2, photoView.frame.origin.y + photoView.frame.size.height + 10, 100, 100);
}

#pragma mark - touch method

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
