//
//  BaseVideoController.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/13.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "BaseVideoController.h"
#import "VideoModel.h"
#import "VideoTableView.h"

//视频播放框架
#import <MediaPlayer/MediaPlayer.h>


@interface BaseVideoController ()
{
    VideoTableView *_tableView;
    NSArray *_dataArray; //保存数据的数组
    NSMutableArray *_data; //保存model的数组
    
    NSString *_urlString; //视频网络地址
    
    NSInteger _index;//计算 用来获取不同的视频新闻
    
    MBProgressHUD *_hud; //加载的三方
}


@end

@implementation BaseVideoController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建tableview
    [self createTableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    //半透明
    self.navigationController.navigationBar.translucent = YES;
    
}

- (void)setFeedID:(NSString *)feedID
{
    if(_feedID != feedID)
    {
        _feedID = [feedID copy];
        
        [self _createRequest];
    }
}


//创建tableview
- (void)createTableView
{
    //初始化
    _index = 1;
    
    _tableView = [[VideoTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 100) style:UITableViewStylePlain];
    
    //下拉刷新
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_createRequest)];
    
    //上拉刷新
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreData)];
    
    //block 的实现
    __weak BaseVideoController *weakSelf = self;
    [_tableView setBlock:^(NSString *str)
     {
         
         _urlString = str;
         
         [weakSelf playVideo];
         
     }];
    
    [self.view addSubview:_tableView];
    
    
}


//获取网络信息
- (void)_createRequest
{
    //开始加载 hud
    [self showHud:@"正在加载..."];
    
    NSString *str = _feedID;
    NSDictionary *dic = @{
                                 @"app_key" : @"2586208540",
                                 @"feed_id" : str,
                                 @"f" : @"title%2Curl%2Ccategoryid%2Cimg%2Ccomment_show%2Cctime%2Cvid%2Cvideo_info",
                                 @"mum" : @"10",
                                 @"pdps_params" : @"%7B%22app%22%3A%7B%22timestamp%22%3A%221426662145292%22%2C%22os%22%3A%22Android%22%2C%22model%22%3A%22MI+2SC%22%2C%22device_type%22%3A%224%22%2C%22osv%22%3A%224.1.1%22%2C%22name%22%3A%22cn.com.sina.sports%22%2C%22carrier%22%3A%22%E4%B8%AD%E5%9B%BD%E7%94%B5%E4%BF%A1%22%2C%22device_id%22%3A%2299000519437585%22%2C%22make%22%3A%22MI+2SC%22%2C%22channel%22%3A%22%22%2C%22connection_type%22%3A%222%22%2C%22version%22%3A30000012%2C%22ip%22%3A%2210.0.2.15%22%7D%7D"
                                 };
    
    [AFNateWorking afNetWorking:kVideoUrl params:dic metod:@"GET" completionBlock:^(id completion) {
        //NSLog(@"%@",completion);
        NSDictionary *result = completion[@"result"];
        NSDictionary *data = result[@"data"];
        NSDictionary *feed = data[@"feed"];
        
        _dataArray = feed[@"data"];
        
        //NSLog(@"--%@",_dataArray);
        
        NSMutableArray *dataModel = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in _dataArray)
        {
            VideoModel *model = [[VideoModel alloc] init];
            
            model.title = dic[@"title"];
            model.url = dic[@"url"];
            model.img = dic[@"img"];
            model.video_info = dic[@"video_info"];
            
            [dataModel addObject:model];
        }
        
        //关闭刷新
        [_tableView.header endRefreshing];
        
        //关闭加载 hud
        [self completeHUD:@"加载完成"];
        
        //将第一次加载的数据保存到全局的可辨数组中
        _data = dataModel;
        
        //给tableview 的属性data 赋值
        _tableView.data = _data;
        
        //刷新tableview
        [_tableView reloadData];
        
        //NSLog(@"===%@",_dataModel);
        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}

//加载更多数据
- (void)_loadMoreData
{
    _index++;
    NSLog(@"%li",_index);
    
    NSString *indexStr = [NSString stringWithFormat:@"%li",_index];
    
    NSString *str = _feedID;
    NSDictionary *dic = @{
                          @"app_key" : @"2586208540",
                          @"feed_id" : str,
                          @"f" : @"title%2Curl%2Ccategoryid%2Cimg%2Ccomment_show%2Cctime%2Cvid%2Cvideo_info",
                          @"mum" : @"10",
                          @"page" : indexStr,
                          @"pdps_params" : @"%7B%22app%22%3A%7B%22timestamp%22%3A%221426662145292%22%2C%22os%22%3A%22Android%22%2C%22model%22%3A%22MI+2SC%22%2C%22device_type%22%3A%224%22%2C%22osv%22%3A%224.1.1%22%2C%22name%22%3A%22cn.com.sina.sports%22%2C%22carrier%22%3A%22%E4%B8%AD%E5%9B%BD%E7%94%B5%E4%BF%A1%22%2C%22device_id%22%3A%2299000519437585%22%2C%22make%22%3A%22MI+2SC%22%2C%22channel%22%3A%22%22%2C%22connection_type%22%3A%222%22%2C%22version%22%3A30000012%2C%22ip%22%3A%2210.0.2.15%22%7D%7D"
                          };

    [AFNateWorking afNetWorking:kVideoUrl params:dic metod:@"GET" completionBlock:^(id completion) {
        //NSLog(@"%@",completion);
        NSDictionary *result = completion[@"result"];
        NSDictionary *data = result[@"data"];
        NSDictionary *feed = data[@"feed"];
        
        _dataArray = feed[@"data"];
        
        //NSLog(@"--%@",_dataArray);
        
        NSMutableArray *dataModel1 = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in _dataArray)
        {
            VideoModel *model = [[VideoModel alloc] init];
            
            model.title = dic[@"title"];
            model.url = dic[@"url"];
            model.img = dic[@"img"];
            model.video_info = dic[@"video_info"];
            
            [dataModel1 addObject:model];
        }
        

        //将新加载的数据加到数组的最后
        [_data addObjectsFromArray:dataModel1];
        
        //关闭刷新
        [_tableView.footer endRefreshing];
        _tableView.data = _data;
        
        [_tableView reloadData];
        
        //NSLog(@"===%@",_dataModel);
        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];

    
}


//播放视频
-(void)playVideo
{
    MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:_urlString]];
    
    [self presentMoviePlayerViewControllerAnimated:player];
    
//    NSLog(@"sdfsdfsdfds%@",_urlString);
    
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
