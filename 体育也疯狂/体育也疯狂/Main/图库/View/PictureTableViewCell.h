//
//  PictureTableViewCell.h
//  体育也疯狂
//
//  Created by MAC22 on 15/10/14.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureModel.h"

@interface PictureTableViewCell : UITableViewCell

@property (nonatomic , strong) PictureModel *pictureModel;

@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
