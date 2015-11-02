//
//  PictureCell.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/20.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "PictureCell.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"

@implementation PictureCell
{
    UIScrollView *_scrollView;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self _createSubView];
    }
    
    return self;
}


- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self _createSubView];
    }
    
    return self;
}


- (void)setModel:(PhotosModel *)model
{
    if (_model != model)
    {
        _model = model;
        
        [self setNeedsLayout];
    }
    
}

- (void)_createSubView
{
    
    if(_scrollView == nil)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        //设置最大放大倍数
        _scrollView.maximumZoomScale = 3;
        _scrollView.minimumZoomScale = 1;
        
        //
        //_scrollView.contentSize = self.frame.size;
        
        
        [self.contentView addSubview:_scrollView];

        //图片
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height)];
        
        //图片的拉伸模式
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        //开启图片的点击事件
        _imageView.userInteractionEnabled = YES;
        
        [_scrollView addSubview:_imageView];
        
        //长按保存图片
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(savePicture:)];
        
        
        [_imageView addGestureRecognizer:longPress];
        
        
        //单击图片放大
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomIN)];
        //手指数
        tap.numberOfTouchesRequired = 1;
        
        [_imageView addGestureRecognizer:tap];
        
    }
    
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_imageView setImageWithURL:[NSURL URLWithString:_model.url] placeholderImage:[UIImage imageNamed:@"fengkaung.png"]];
    
}

//放大
- (void)zoomIN
{
        
    if(_scrollView.zoomScale >= 2)
    {
        [_scrollView setZoomScale:1 animated:YES];
    }
    else
    {
        [_scrollView setZoomScale:3 animated:YES];
    }
    
}


//长按保存的方法
- (void)savePicture:(UILongPressGestureRecognizer *)longPress
{
    if(longPress.state == UIGestureRecognizerStateBegan)
    {
        //提示是否保存
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否保存图片" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
    
        [alterView show];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        UIImage *image = self.imageView.image;
        
        //把图片保存到相册
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
    }
    
}

//保存后调用的方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    //提示保存成功
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    
    //显示模式改为：自定义视图模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"保存成功";
    
    //延迟隐藏
    [hud hide:YES afterDelay:1.5];

}


@end
