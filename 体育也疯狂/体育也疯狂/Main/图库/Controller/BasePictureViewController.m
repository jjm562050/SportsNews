//
//  BasePictureViewController.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/14.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//


//图库：
//
//热门：http://u.api.5usport.com/PHP_works/api/index.php?m=News&a=getPictureList&hot=1&catid=15&page=1&page_size=12
//足球：http://u.api.5usport.com/PHP_works/api/index.php?m=News&a=getPictureList&catid=54&page=1&page_size=12
//篮球：http://u.api.5usport.com/PHP_works/api/index.php?m=News&a=getPictureList&catid=55&page=1&page_size=12
//综合：http://u.api.5usport.com/PHP_works/api/index.php?m=News&a=getPictureList&catid=58&page=1&page_size=12
//明星：http://u.api.5usport.com/PHP_works/api/index.php?m=News&a=getPictureList&catid=59&page=1&page_size=12

#import "BasePictureViewController.h"
#import "AFNateWorking.h"
#import "PictureTableView.h"
#import "PictureModel.h"

@interface BasePictureViewController ()
{
    PictureTableView *_tableView;
    NSMutableArray *_dataModelArray;
    
    NSInteger _index; //跟视频的一样
}
@end

@implementation BasePictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _createTableView];
}

//复写 set
- (void)setFeedID:(NSString *)feedID
{
    if(_feedID != feedID)
    {
        _feedID = [feedID copy];
        
        [self selectedParams];
    }
    
}

//创建tableview
- (void)_createTableView
{
    //初始化
    _index = 1;
    
    _tableView = [[PictureTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 100) style:UITableViewStylePlain];
    
    //下拉
    //_tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_createRequest:)];
    
    //上拉
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];
    
    [self.view addSubview:_tableView];
    
}


- (void)selectedParams
{
    //相同的四个
    NSString *str = _feedID;
    NSString *str1 = _hot;
    
    if(_hot == nil)
    {
        NSDictionary *dic = @{
                              @"m" : @"News",
                              @"a" : @"getPictureList",
                              @"catid" : str,
                              @"page" : @"1",
                              @"page_size" : @"12"
                              };
        
        [self _createRequest:dic];
        
        
    }
    else
    {
        NSDictionary *dic = @{
                              @"m" : @"News",
                              @"a" : @"getPictureList",
                              @"hot" : str1,
                              @"catid" : str,
                              @"page" : @"1",
                              @"page_size" : @"12"
                              };
        
        [self _createRequest:dic];
        
    }
    
}


//获取网络信息
- (void)_createRequest:(NSDictionary *)dictionary
{
    [self showHud:@"正在加载"];
    
    [AFNateWorking afNetWorking:kPictureUrl params:dictionary metod:@"GET" completionBlock:^(id completion) {
        // NSLog(@"completion:%@",completion);
        
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        
        NSArray *data = completion[@"data"];
        
        for(NSDictionary *dic in data)
        {
            PictureModel *model = [[PictureModel alloc] init];
            model.news_title = dic[@"news_title"];
            model.news_photo = dic[@"news_photo"];
            model.news_id = dic[@"news_id"];
            
            [dataArray addObject:model];
        }
        
        _dataModelArray = dataArray;
        _tableView.data = _dataModelArray;
        
        //关闭
        //[_tableView.header endRefreshing];
        [self completeHUD:@"加载完成"];
        
        [_tableView reloadData];
        
        
    } errorBlock:^(NSError *error) {
        NSLog(@"error:%@",error);
        
    }];
    
}


//加载更多的参数
- (void)selectedParams2
{
    _index++;
    NSString *indexStr = [NSString stringWithFormat:@"%li",_index];
    
    //相同的四个
    NSString *str = _feedID;
    NSString *str1 = _hot;
    
    if(_hot == nil)
    {
        NSDictionary *dic = @{
                              @"m" : @"News",
                              @"a" : @"getPictureList",
                              @"catid" : str,
                              @"page" : indexStr,
                              @"page_size" : @"12"
                              };
        
        [self loadMoreData:dic];
        
        
    }
    else
    {
    NSDictionary *dic = @{
                          @"m" : @"News",
                          @"a" : @"getPictureList",
                          @"hot" : str1,
                          @"catid" : str,
                          @"page" : indexStr,
                          @"page_size" : @"12"
                          };
        
        [self loadMoreData:dic];

    }
    
}


//获取网络信息
- (void)loadMoreData:(NSDictionary *)dictionary
{
    
    [AFNateWorking afNetWorking:kPictureUrl params:dictionary metod:@"GET" completionBlock:^(id completion) {
       // NSLog(@"completion:%@",completion);
        
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        
        NSArray *data = completion[@"data"];
        
        for(NSDictionary *dic in data)
        {
            PictureModel *model = [[PictureModel alloc] init];
            model.news_title = dic[@"news_title"];
            model.news_photo = dic[@"news_photo"];
            model.news_id = dic[@"news_id"];
            
            [dataArray addObject:model];
        }
        
        //添加数据
        [_dataModelArray addObjectsFromArray:dataArray];
        
        _tableView.data = _dataModelArray;
        
        
        //关闭
        [_tableView.footer endRefreshing];
        [_tableView reloadData];
        
        
    } errorBlock:^(NSError *error) {
        NSLog(@"error:%@",error);
        
    }];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    //半透明
    self.navigationController.navigationBar.translucent = YES;
    
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
