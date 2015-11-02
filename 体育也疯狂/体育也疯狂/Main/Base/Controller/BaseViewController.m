//
//  BaseViewController.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/12.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()
{
    MBProgressHUD *_hud;
    
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


//加载
- (void)showHud:(NSString *)title
{
    if(_hud == nil)
    {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
    }
    
    _hud.labelText = title;
    
    _hud.dimBackground = YES;
    
    [_hud show:YES];
    
    
}


//结束加载
- (void)completeHUD:(NSString *)title
{
    
    _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    
    _hud.mode = MBProgressHUDModeCustomView;
    
    _hud.labelText = title;
    
    //持续1.5隐藏
    [_hud hide:YES afterDelay:1.5];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
