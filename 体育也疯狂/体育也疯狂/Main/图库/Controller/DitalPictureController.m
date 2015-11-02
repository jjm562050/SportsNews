//
//  DitalPictureController.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "DitalPictureController.h"
#import "PictureCollectionView.h"
#import "AFNateWorking.h"
#include "PhotosModel.h"

@interface DitalPictureController ()
{
    PictureCollectionView *_collectionView;
    
    NSMutableArray *_photosUrl; //保存图片地址的数组
    
    UILabel *_label; //显示图片的图片个数
    
    NSString *_indexStr;  //图片的页码
}

@end

@implementation DitalPictureController

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
    //NSLog(@"%@",_model.news_id);
    
    self.view.backgroundColor = [UIColor blackColor];
    
    
    [self loadPictureData];
    
    [self _createCollectionView];
}


- (void)viewWillAppear:(BOOL)animated
{
    //设置导航栏的透明度为 不透明  iOS7 以后 导航栏默认为半透明
    self.navigationController.navigationBar.translucent = NO;
    _collectionView.frame = CGRectMake(0, 100, kScreenWidth, 200);
    
}


//创建collection
- (void)_createCollectionView
{
    _collectionView = [[PictureCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
//    _collectionView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:_collectionView];
    
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 70, kScreenHeight - 104 , 50, 40)];
    
    _label.textColor = [UIColor whiteColor];
    
    [self.view addSubview:_label];
    
    
    __weak DitalPictureController *blockSelf = self;
    //block的实现
    [_collectionView setBlock:^(NSString *index)
     {
         NSInteger num = [index integerValue] + 1;
         NSString *string = [NSString stringWithFormat:@"%ld",num];
         
         [blockSelf action:string];
         
     }];
    
}


- (void)action:(NSString *)indexStr
{
    if ([indexStr integerValue] <= _photosUrl.count)
    {
        _label.text = [NSString stringWithFormat:@"%@/%li",indexStr,_photosUrl.count];
    }
}


//获取数据
- (void)loadPictureData
{
    
    NSDictionary *dic = @{
                          @"m" : @"News",
                          @"a" : @"pictureDetail",
                          @"catid" : @"15",
                          @"news_id" : _model.news_id,
                          @"screen_size" : @"480x300",
                          };

    [AFNateWorking afNetWorking:kPictureUrl params:dic metod:@"GET" completionBlock:^(id completion) {
        //NSLog(@"%@",completion);
        
        NSDictionary *data = completion[@"data"];
        NSArray *photos = data[@"photos"];
        
        _photosUrl = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in photos)
        {
            PhotosModel *model = [[PhotosModel alloc] init];
            model.url = dic[@"url"];
            
            [_photosUrl addObject:model];
        }
        
        _collectionView.data = _photosUrl;
        
        
        [_collectionView reloadData];
        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
    
    
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
