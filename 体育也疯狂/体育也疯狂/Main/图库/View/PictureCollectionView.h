//
//  PictureCollectionView.h
//  体育也疯狂
//
//  Created by MAC22 on 15/10/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureModel.h"

typedef void (^MyBlock)(NSString *);

@interface PictureCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) PictureModel *model;
@property (nonatomic, strong) NSArray *data;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) MyBlock block;

@end
