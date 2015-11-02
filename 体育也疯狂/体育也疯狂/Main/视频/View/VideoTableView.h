//
//  VideoTableView.h
//  体育也疯狂
//
//  Created by MAC22 on 15/10/13.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyBlock)(NSString *);

@interface VideoTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) NSArray *data;

@property (nonatomic , strong) MyBlock block;

@end
