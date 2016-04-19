//
//  LeMusicTableCell.m
//  Walle
//
//  Created by 飞 刘 on 16/4/14.
//  Copyright © 2016年 LeSpeech. All rights reserved.
//

#import "LeMusicTableCell.h"
#import "UIImageView+WebCache.h"

@interface LeMusicTableCell ()

@property (nonatomic) IBOutlet UIImageView* thumbnailImage;
@property (nonatomic) IBOutlet UILabel* albumLabel;
@property (nonatomic) IBOutlet UILabel* titleLabel;

@end

@implementation LeMusicTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setSingleModel:(SingleModel *)singleModel{
    _singleModel = singleModel;
    // SD 加载图片
    NSString *string = self.singleModel.coverLarge;
    NSURL *url = [NSURL URLWithString:string];
    
    [self.thumbnailImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"F0AB9D064E5D1695CB1857176EBE14A6"]];
    
    self.albumLabel.text = self.singleModel.albumTitle;
    self.titleLabel.text = self.singleModel.title;
}

@end
