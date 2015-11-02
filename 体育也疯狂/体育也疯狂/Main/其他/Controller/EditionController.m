//
//  EditionController.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/12.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "EditionController.h"

@interface EditionController ()

@end

@implementation EditionController

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, kScreenWidth - 20, 200)];
    
    image.image = [UIImage imageNamed:@"fengkaung.png"];
    
    [self.view addSubview:image];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, kScreenWidth - 20, 150)];
        
    label.numberOfLines = 0;
    label.text = @"      体育也疯狂以体育视频，新闻，图库为主，24小时不间断全球采编，搜罗全球最新，最劲爆的体育情报。为用户提供中超，亚冠，欧冠，CBA经典视频集锦，足球，篮球实时新闻和高清图片。";
    
    [self.view addSubview:label];
    
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
