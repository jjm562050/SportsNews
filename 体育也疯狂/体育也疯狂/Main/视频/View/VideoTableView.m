//
//  VideoTableView.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/13.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "VideoTableView.h"
#import "VideoTableViewCell.h"
#import "VideoModel.h"
#import "UIView+UIViewController.h"


@implementation VideoTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if(self)
    {
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[VideoTableViewCell class] forCellReuseIdentifier:@"cellvideo"];
    }
    
    return self;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellvideo" forIndexPath:indexPath];
    
    cell.videoModel = _data[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


//选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoModel *model = _data[indexPath.row];
    
    NSString *videoid = model.video_info[@"ipad_url"];
    
    //NSLog(@"%@",videoid);
    
    
    _block(videoid);
    
}

//- (NSString *)playerVideo:(NSString *)videoID
//{
//    
////     MPMoviePlayerController *player = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:videoID]];
////    
////    NSLog(@"fsf%@",videoID);
////    //player.view.frame = CGRectMake(0, 0, 320, 480);
//    
//}


@end
