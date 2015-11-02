//
//  BaseNewsViewController.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/14.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//


//新闻：
//头条：http://u.api.5usport.com/PHP_works/api/index.php?m=News&a=headline&page=1&page_size=12&screen_size=160x120&big_pic=1

//足球：http://u.api.5usport.com/PHP_works/api/index.php?m=News&a=getList&catid=6&page=1&page_size=12&screen_size=160x120&big_pic=1

//篮球：http://u.api.5usport.com/PHP_works/api/index.php?m=News&a=getList&catid=7&page=1&page_size=12&screen_size=160x120&big_pic=1

//综合：http://u.api.5usport.com/PHP_works/api/index.php?m=News&a=getList&catid=12&page=1&page_size=12&screen_size=160x120&big_pic=1



#import "BaseNewsViewController.h"
#import "AFNateWorking.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"
#include "TopTableViewCell.h"
#import "NewsDetailController.h"
#import "MJRefresh.h"

@interface BaseNewsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
    NSMutableArray *_dataModelArray;
    
    NSInteger _index; //计数 跟视频的一样
}
@end

@implementation BaseNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    //半透明
    self.navigationController.navigationBar.translucent = YES;
    
}

//创建表视图
- (void)createTableView
{
    //初始化
    _index = 1;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 100)];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //下拉刷新
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createRequest)];
    
    //上拉刷新
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.view addSubview:_tableView];
    
    
}


- (void)setCatid:(NSString *)catid
{
    if(_catid != catid)
    {
        _catid = [catid copy];
        
        [self createRequest];
    }
}

//加载更多数据
- (void)loadMoreData
{
    _index++;
    NSString *indexStr = [NSString stringWithFormat:@"%li",_index];
    
    NSDictionary *dic = @{
                          @"m":@"News",
                          @"a":_aName,
                          @"page_size":@"12",
                          @"catid":_catid,
                          @"page":indexStr,
                          @"version":@"1.0.4",
                          @"screen_size":@"160x120",
                          @"big_pic":@"1"
                          };
    
    [AFNateWorking afNetWorking:kNewsUrl params:dic metod:@"GET" completionBlock:^(id completion) {
        
        //NSLog(@"%@",completion);
        NSArray *data = completion[@"data"];
        
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        
        for(NSDictionary *dic in data)
        {
            NewsModel *newsModel = [[NewsModel alloc] init];
            newsModel.news_date = dic[@"news_date"];
            newsModel.news_title = dic[@"news_title"];
            newsModel.news_photo = dic[@"news_photo"];
            newsModel.news_id = dic[@"news_id"];
            
            [dataArray addObject:newsModel];
        }
        
        [_dataModelArray addObjectsFromArray:dataArray];
        
        //关闭刷新
        [_tableView.footer endRefreshing];
        
        [_tableView reloadData];
        
        
    } errorBlock:^(NSError *error) {
        NSLog(@"error:%@",error);
        
    }];
}


//网络加载数据
- (void)createRequest
{
    //开始加载 hud
    [self showHud:@"正在加载..."];
    
    NSDictionary *dic = @{
                          @"m":@"News",
                          @"a":_aName,
                          @"page_size":@"12",
                          @"catid":_catid,
                          @"page":@"1",
                          @"version":@"1.0.4",
                          @"screen_size":@"160x120",
                          @"big_pic":@"1"
                          };

    [AFNateWorking afNetWorking:kNewsUrl params:dic metod:@"GET" completionBlock:^(id completion) {
        
        //NSLog(@"%@",completion);
        NSArray *data = completion[@"data"];
        
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        
        for(NSDictionary *dic in data)
        {
            NewsModel *newsModel = [[NewsModel alloc] init];
            newsModel.news_date = dic[@"news_date"];
            newsModel.news_title = dic[@"news_title"];
            newsModel.news_photo = dic[@"news_photo"];
            newsModel.news_id = dic[@"news_id"];
            
            [dataArray addObject:newsModel];
        }
        
        _dataModelArray = dataArray;
        
        //关闭
        [self completeHUD:@"加载完成"];
        
        //关闭刷新
        [_tableView.header endRefreshing];
        
        [_tableView reloadData];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"error:%@",error);
        
    }];
    
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataModelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 0)
    {
        TopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topnewscell"];
        
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TopTableViewCell" owner:self options:nil] firstObject];
        }
        
        cell.model = _dataModelArray[indexPath.row];
        
        return cell;

    }
    else
    {
        NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newscell"];
        
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsTableViewCell" owner:self options:nil] lastObject];
        }
        
        NewsDetailController *dev = [[NewsDetailController alloc] init];
        
        cell.detailModel = dev.photoArray[0];
        
        //NSLog(@"%@",dev.photoArray);
        
        cell.newsModel = _dataModelArray[indexPath.row];
        
        return cell;

    }
    
    
}

//设置单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 200;
    }
    
    return 100;
}

//选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = _dataModelArray[indexPath.row];
    
    //创建
    NewsDetailController *detial = [[NewsDetailController alloc] init];
    detial.title = @"新闻详情";
    
    detial.model = model;
    
    [self.navigationController pushViewController:detial animated:YES];
    
    
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
