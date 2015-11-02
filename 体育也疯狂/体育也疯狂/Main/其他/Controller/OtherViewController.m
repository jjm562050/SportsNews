//
//  OtherViewController.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/12.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "OtherViewController.h"
#import "AboutOurController.h"
#import "EditionController.h"
#import "CopyrightController.h"

@interface OtherViewController ()<UIAlertViewDelegate>

{
    UILabel *_cacheLabel; //缓存大小
}
@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //加载
    [self _createOtherButton];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    _cacheLabel.text = [NSString stringWithFormat:@"%.2fMB",[self countCacheFileSize]];
    
}

//创建其他视图的按钮
- (void)_createOtherButton
{
    NSArray *names = @[@"关于我们",
                       @"版本介绍",
                       @"版权声明",
                       @"清除缓存"
                       ];
    
    NSArray *introduceNames = @[
                                @"制作团队和联系方式",
                                @"版本1.0",
                                @"版权的最终声明",
                                @"清除缓存的图片"
                                ];
    
    CGFloat buttonWidth = kScreenWidth - 80;
    
    for(int i = 0 ; i <names.count ; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((kScreenWidth - buttonWidth) / 2, 80 + 60 * i, buttonWidth, 50);
        
        [button setTitle:names[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        
        //设置位置
        [button setTitleEdgeInsets:UIEdgeInsetsMake(10, -(kScreenHeight - buttonWidth) / 2, 30, 0)];
        
        button.tag = i;
        
        [button addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //创建UIlabel
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, button.bounds.size.width, 15)];
        
        label.font = [UIFont systemFontOfSize:15];
        label.text = introduceNames[i];
        
        [button addSubview:label];
        
        [self.view addSubview:button];
        
        
        //添加缓存label
        if (button.tag == 3)
        {
            _cacheLabel = [[UILabel alloc] initWithFrame:CGRectMake(button.frame.size.width - 70, 0, 65, 30)];
            _cacheLabel.font = [UIFont systemFontOfSize:15];
            //_cacheLabel.backgroundColor = [UIColor purpleColor];
            
            [button addSubview:_cacheLabel];

        }
        
    }
    
    
}


//按钮的方法
- (void)selectedAction:(UIButton *)button
{
    if(button.tag == 0)
    {
        AboutOurController *other = [[AboutOurController alloc] init];
        
        [self.navigationController pushViewController:other animated:YES];
    }
    else if (button.tag == 1)
    {
        EditionController *edition = [[EditionController alloc] init];
        
        [self.navigationController pushViewController:edition animated:YES];
        
    }
    else if (button.tag == 2)
    {
        CopyrightController *copyright = [[CopyrightController alloc] init];
        
        [self.navigationController pushViewController:copyright animated:YES];
    }
    else
    {
        if([self countCacheFileSize] > 0)
        {
            UIAlertView * alterView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"是否清除缓存" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alterView show];

            
        }
        
        
    }
    
}


#pragma mark - 获取缓存文件的路径 并 计算当前应用程序缓存文件的大小

-(CGFloat)countCacheFileSize
{
    
    //1.获取缓存文件夹的路径
    // 函数  用于获取当前程序的沙盒路径
    NSString *homePath = NSHomeDirectory();
    
    //NSLog(@"%@",homePath);
    
    /*
     字文件夹1： 视频缓存 /tmp/
     字文件夹2:  /Library/Caches/com.huiwenjiaoyu.-----/fsCachedData/
     */
    
    //2.使用- (CGFloat)getFileSize:(NSString *)filePath  来计算这些文件夹中文件的大小
    NSArray *pathArray = @[@"/tmp/",
                           @"/Library/Caches/com.huiwenjiaoyu.-----/fsCachedData/"
                           ];

    //初始化filesize
    CGFloat fileSize = 0;
    
    //文件大小之和
    for (NSString *string in pathArray)
    {
        //拼接路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@",homePath,string];
        
        fileSize += [self getFileSize:filePath];
        
    }
    
    //3.对上一步计算的结果进行求和  并返回
    return fileSize;
}

#pragma mark - 计算此路径下的文件大小
- (CGFloat)getFileSize:(NSString *)filePath
{
    //文件管理对象 单例
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //数组 存储文件夹中所有的字文件夹以及文件的名字
    NSArray *fileNames = [manager subpathsOfDirectoryAtPath:filePath error:nil];
    
    //初始化size
    long long size = 0;
    
    //遍历文件夹
    for (NSString *fileName in fileNames)
    {
        //拼接获取文件夹的路径
        NSString *subFilePath = [NSString stringWithFormat:@"%@%@",filePath,fileName];
        
        //获取文件的信息
        NSDictionary *dic = [manager attributesOfItemAtPath:subFilePath error:nil];
        
        //获取缓存文件的大小
        NSNumber *sizeNumber = dic[NSFileSize];
        
        //使用一个 long long 类型来存储文件的大小
        long long subFileSize = [sizeNumber longLongValue];
        
        //文件大小求和
        size += subFileSize;
        
    }
    
    return size / 1024.0 / 1024.0;
}

#pragma mark - 清除缓存
- (void)clearCache
{
    //1.获取文件路径
    //1.获取缓存文件夹的路径
    //函数 用于获取当前程序的沙盒路径
    NSString *homePath = NSHomeDirectory();

    NSArray *pathArray = @[@"/tmp/",
                           @"/Library/Caches/com.huiwenjiaoyu.-----/fsCachedData/"
                           ];
    
    //2.删除文件
    for (NSString *string in pathArray)
    {
        //拼接路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@",homePath,string];
        
        // 文件管理对象  单例
        NSFileManager *manager = [NSFileManager defaultManager];
        
        //数组 存储文件夹中所有的字文件夹以及文件的名字
        NSArray *fileNames = [manager subpathsOfDirectoryAtPath:filePath error:nil];
        
        //遍历文件夹
        for(NSString *fileName in fileNames)
        {
            //拼接获取文件夹的路径
            NSString *subFilePath = [NSString stringWithFormat:@"%@%@",filePath,fileName];
            
            //删除文件
            [manager removeItemAtPath:subFilePath error:nil];
            
        }
    }
    
    //3.重新计算缓存大小
    _cacheLabel.text = [NSString stringWithFormat:@"%.2fMB",[self countCacheFileSize]];
    
}



#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //清除缓存
        [self clearCache];
        
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
