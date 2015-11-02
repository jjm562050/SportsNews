//
//  NewsTableViewCell.h
//  体育也疯狂
//
//  Created by MAC22 on 15/10/14.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "NewsDetailModel.h"

@interface NewsTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (nonatomic , strong) NewsModel *newsModel;
@property (nonatomic , strong) NewsDetailModel *detailModel;

@property (nonatomic ,strong ) NSArray *data;

@end
