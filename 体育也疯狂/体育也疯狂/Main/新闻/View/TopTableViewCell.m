//
//  TopTableViewCell.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "TopTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TopTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setModel:(NewsModel *)model
{
    if(_model != model)
    {
        _model = model;
        
        [self setNeedsLayout];
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_topImageView setImageWithURL:[NSURL URLWithString:_model.news_photo]];
    
    _titleLabel.text = _model.news_title;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
