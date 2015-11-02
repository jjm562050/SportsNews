//
//  VideoTableViewCell.h
//  体育也疯狂
//
//  Created by MAC22 on 15/10/12.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"

@interface VideoTableViewCell : UITableViewCell

@property (nonatomic ,strong) VideoModel *videoModel;

@property (nonatomic ,copy ) NSString *title; //标题
@property (nonatomic ,copy ) NSString *url;   //
@property (nonatomic ,copy ) NSString *imgStrUrl; //图片网址


@end
