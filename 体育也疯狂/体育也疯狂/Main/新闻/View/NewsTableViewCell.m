//
//  NewsTableViewCell.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/14.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation NewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNewsModel:(NewsModel *)newsModel
{
    if (_newsModel != newsModel) {
        _newsModel = newsModel;
        
        [self setNeedsLayout];
    }
}

- (void)setDetailModel:(NewsDetailModel *)detailModel
{
    if(_detailModel != detailModel)
    {
        _detailModel = detailModel;
        
        [self setNeedsLayout];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_pictureImageView setImageWithURL:[NSURL URLWithString:_detailModel.photo]];
    
    _titleLabel.text = _newsModel.news_title;
    
    _timeLabel.text = _newsModel.news_date;
    
    
}

@end
