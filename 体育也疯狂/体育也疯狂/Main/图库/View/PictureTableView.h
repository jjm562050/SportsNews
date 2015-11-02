//
//  PictureTableView.h
//  体育也疯狂
//
//  Created by MAC22 on 15/10/14.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) NSArray *data;


@end
