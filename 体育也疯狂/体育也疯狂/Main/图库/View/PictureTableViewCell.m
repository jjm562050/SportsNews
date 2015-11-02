//
//  PictureTableViewCell.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/14.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "PictureTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation PictureTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setPictureModel:(PictureModel *)pictureModel
{
    if(_pictureModel != pictureModel)
    {
        _pictureModel = pictureModel;
        
        [self setNeedsLayout];
    }
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_pictureImageView setImageWithURL:[NSURL URLWithString:_pictureModel.news_photo]];
    
    _titleLabel.text = _pictureModel.news_title;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
