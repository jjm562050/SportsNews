//
//  VideoModel.h
//  体育也疯狂
//
//  Created by MAC22 on 15/10/13.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

@property (nonatomic , copy) NSString *title; //视频的标题
@property (nonatomic , copy) NSString *url; //视频网址的ID
@property (nonatomic , strong) NSDictionary *img; //图片的字典
@property (nonatomic , strong) NSDictionary *video_info; //视频信息



@end
