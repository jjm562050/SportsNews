//
//  VideoTableViewCell.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/12.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "VideoTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation VideoTableViewCell
{
    UILabel *_titleLabel; //标题
    UIImageView *_imageView; //图片
    UILabel *_munLabel; // 播放次数
    
}
- (void)awakeFromNib {
    // Initialization code
    
    
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self _createSubViews];
    }
    
    return self;
}


- (void)setVideoModel:(VideoModel *)videoModel
{
    if(_videoModel != videoModel)
    {
        _videoModel = videoModel;
        
        [self setNeedsLayout];
    }
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSDictionary *dic = _videoModel.img;
    [_imageView setImageWithURL:[NSURL URLWithString:dic[@"u"]] placeholderImage:[UIImage imageNamed:@"fengkaung.png"]];
    
    _titleLabel.text = _videoModel.title;
    
    NSDictionary *dic1 = _videoModel.video_info;
    _munLabel.text = [dic1[@"play_times"] stringValue];
    
}

//创建各种UI控件
- (void)_createSubViews
{
    //标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, self.bounds.size.width - 115, 50)];
    
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    
    //图片
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, 70)];
    
    UIImageView *video = [[UIImageView alloc] initWithFrame:CGRectMake(_imageView.center.x - 25, _imageView.center.y - 25, 40, 40)];
    video.contentMode = UIViewContentModeScaleAspectFit;
    video.image = [UIImage imageNamed:@"movies.png"];
    
    [_imageView addSubview:video];

    [self.contentView addSubview:_imageView];
    
    //观看数
    _munLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 55, 200, 20)];
    _munLabel.font = [UIFont systemFontOfSize:12];
    
    [self.contentView addSubview:_munLabel];

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
