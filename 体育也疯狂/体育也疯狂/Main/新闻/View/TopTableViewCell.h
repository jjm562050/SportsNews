//
//  TopTableViewCell.h
//  体育也疯狂
//
//  Created by MAC22 on 15/10/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface TopTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic , strong ) NSArray *data;

@property (nonatomic , strong) NewsModel *model;

@end
