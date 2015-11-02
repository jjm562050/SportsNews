//
//  NewsDetailController.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/20.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "NewsDetailController.h"
#import "AFNateWorking.h"
#import "NewsDetailModel.h"
#import "UIImageView+AFNetworking.h"

@interface NewsDetailController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
    NSMutableArray *_detailArray;
    
    UILabel *_titleLabel;
    UILabel *_timeLabel;
    UIImageView *_newsImageView;
    UILabel *_contentLabel;
    
    
}
@end

@implementation NewsDetailController

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
    
    //加载网络数据
    [self loadData];
    
    //创建tableview
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    //注册单元格
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
    
}


//加载网络数据
- (void)loadData
{
    [self showHud:@"正在加载...."];
    
    //NSLog(@"%@",_model.news_id);
    NSDictionary *params = @{
                             @"m" : @"News",
                             @"a" : @"detail",
                             @"catid" : @"-1",
                             @"news_id" : _model.news_id,
                             @"screen_size" : @"480x300"
                             };
    
    [AFNateWorking afNetWorking:kNewsUrl params:params metod:@"GET" completionBlock:^(id completion) {
        //NSLog(@"%@",completion);

        if(completion != nil)
        {
            _detailArray = [[NSMutableArray alloc] init];
            
            NSDictionary *dic = completion[@"data"];
            NewsDetailModel *detailModel = [[NewsDetailModel alloc] init];
            detailModel.content = dic[@"news_content"];
            detailModel.title = dic[@"news_title"];
            detailModel.date = dic[@"news_date"];
            detailModel.photo = dic[@"news_photo"];
            
            [_detailArray addObject:detailModel];
            
        }
        
        [self completeHUD:@"加载完成"];
        
        //刷新tableview
        [_tableView reloadData];
        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NewsDetailModel *model = _detailArray[0];
    
    if(indexPath.row == 0)
    {
        //标题
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth, 40)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = model.title;
        
        //时间
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 20)];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.text = model.date;

        [cell.contentView addSubview:_timeLabel];
        [cell.contentView addSubview:_titleLabel];
        
    }
    else
    {
        
        //图片
        _newsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth - 20,200)];
        [_newsImageView setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"fengkaung.png"]];
        
        //计算正文的大小
        CGFloat contentRect = [self calculateContentSize:model.content];
        
        //正文
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 , 5 + 200, kScreenWidth - 10,contentRect)];
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = model.content;
        _contentLabel.font = [UIFont systemFontOfSize:14];

        [cell.contentView addSubview:_newsImageView];
        [cell.contentView addSubview:_contentLabel];
        
    }
    
    //取消选中状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 70;
    }
    
    
    return 205 + _contentLabel.frame.size.height + 50;
}


//计算正文的大小
- (CGFloat)calculateContentSize:(NSString *)content
{
    CGSize size = CGSizeMake(kScreenWidth, 10000);
    
    NSDictionary *attributes = @{
                                NSFontAttributeName : [UIFont systemFontOfSize:14],
                                NSForegroundColorAttributeName : [UIColor blackColor]
                                };
    
    
    CGRect rect = [content boundingRectWithSize:size
                          options:NSStringDrawingUsesLineFragmentOrigin
                       attributes:attributes
                          context:nil];
    
    CGFloat height = rect.size.height + 50;
    
    return height;
    
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
