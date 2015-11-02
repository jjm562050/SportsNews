//
//  MainTabBarController.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/12.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavigationController.h"

@interface MainTabBarController ()
{
    BOOL isSetecled; //tabbar的选中状态
}
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //加载子视图
    [self _createSubViews];
    
    
}



//加载子视图
- (void)_createSubViews
{
    
    NSArray *imageName = @[
                           @"tabbar_video@2x.png",
                           @"tabbar_news@2x.png",
                           @"tabbar_picture@2x.png",
                           @"tabbar_setting@2x.png"
                           ];
    
    NSArray *selectedImageNames = @[@"tabbar_video_hl@2x.png",@"tabbar_news_hl@2x.png",@"tabbar_picture_hl@2x.png",@"tabbar_setting_hl@2x.png"];
    
    
    NSArray *textName = @[
                              @"视频",
                              @"新闻",
                              @"图库",
                              @"其他"
                              ];

    
    
    //从故事版中加载
    NSArray *storyNames = @[@"Video",@"News",@"Picture",@"Other"];
    
    NSMutableArray *viewArray = [[NSMutableArray alloc] initWithCapacity:storyNames.count];
    
    for(int i = 0; i < storyNames.count ; i++)
    {
        UIStoryboard *story = [UIStoryboard storyboardWithName:storyNames[i] bundle:nil];
        
        BaseNavigationController *baseNavc = [story instantiateInitialViewController];
        
        [viewArray addObject:baseNavc];
        
    }
    
    self.viewControllers = viewArray;
    
    
    //设置tabbar  选中的默认颜色为 蓝色
    UITabBar *tabbar = self.tabBar;
    
    
    for(int i = 0; i <textName.count; i++)
    {
        UITabBarItem *tabbarItem = [tabbar.items objectAtIndex:i];
        
        NSString *imageStr = imageName[i];
        tabbarItem.image = [UIImage imageNamed:imageStr];
        //选中图片
        UIImage *selectedImage = [UIImage imageNamed:selectedImageNames[i]];
        tabbarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //设置字体
        UIColor *color = [UIColor colorWithRed:180 / 255.0 green:53 / 255.0 blue:55 /255.0 alpha:1];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : color} forState:UIControlStateSelected];
        
        
        tabbarItem.title = textName[i];
        tabbarItem.tag = i;
        
    }
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
