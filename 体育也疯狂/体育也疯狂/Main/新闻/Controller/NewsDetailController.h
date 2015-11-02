//
//  NewsDetailController.h
//  体育也疯狂
//
//  Created by MAC22 on 15/10/20.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "BaseViewController.h"
#import "NewsModel.h"

@interface NewsDetailController : BaseViewController

@property (nonatomic ,strong) NewsModel *model;
@property (nonatomic ,strong) NSArray *photoArray;


@end
