//
//  CopyrightController.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/12.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "CopyrightController.h"

@interface CopyrightController ()

@end

@implementation CopyrightController

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

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, kScreenWidth - 20, 100)];
    
    label.numberOfLines = 0;
    
    label.text = @"      中超，亚冠，欧冠，CBA视频都来自于新浪视频，头条，足球，篮球，综合新闻都来自于5U体育，图库也是来自于5U体育。";
    
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
