//
//  PictureCell.h
//  体育也疯狂
//
//  Created by MAC22 on 15/10/20.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotosModel.h"

@interface PictureCell : UICollectionViewCell<UIAlertViewDelegate>

@property (nonatomic ,strong) PhotosModel *model;
@property (nonatomic ,strong) UIImageView *imageView;

@end
