//
//  PictureTableView.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/14.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "PictureTableView.h"
#import "PictureTableViewCell.h"
#import "DitalPictureController.h"
#import "UIView+UIViewController.h"

@implementation PictureTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if(self)
    {
        self.dataSource = self;
        self.delegate = self;
        
        UINib *uib = [UINib nibWithNibName:@"PictureTableViewCell" bundle:nil];
        [self registerNib:uib forCellReuseIdentifier:@"picturecell"];
        
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
    PictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"picturecell" forIndexPath:indexPath];
    
    
    cell.pictureModel = _data[indexPath.row];
    
    return cell;
    
}

//设置单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
    
}

//选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PictureModel *model = _data[indexPath.row];
    
    DitalPictureController *dvc = [[DitalPictureController alloc] init];
    
    dvc.title = @"图片详情";
    dvc.model = model;
        
    [self.viewController.navigationController pushViewController:dvc animated:YES];
    
}




@end
