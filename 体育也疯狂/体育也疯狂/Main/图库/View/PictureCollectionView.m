//
//  PictureCollectionView.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "PictureCollectionView.h"
#import "PictureCell.h"

@implementation PictureCollectionView


//初始化
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    //创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置基本属性
    //设置水平间隙
    //flowLayout.minimumInteritemSpacing = 0;
    
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //单元格的大小
    flowLayout.itemSize = CGSizeMake(frame.size.width - 10, frame.size.height);
    
    //水平滑动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if(self)
    {
        self.dataSource = self;
        self.delegate = self;
        
        //分页
        self.pagingEnabled = YES;
        
        //注册单元格
        [self registerClass:[PictureCell class] forCellWithReuseIdentifier:@"collectioncell"];
    }
    
    return  self;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //NSLog(@"%@",_data);
    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectioncell" forIndexPath:indexPath];

    cell.model = _data[indexPath.item];
    
    return cell;
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat width = scrollView.frame.size.width;
    
    NSInteger page = scrollView.contentOffset.x / width + 1;
    
    NSString *pageStr = [NSString stringWithFormat:@"%li",page];
    
    //NSLog(@"2dfdsfsdf%@",pageStr);
    
    _block(pageStr);
    
}


@end
