//
//  NLHyHerCell.m
//  NBlue
//
//  Created by LYD on 16/3/22.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLHyHerCell.h"

@implementation NLHyHerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI{
    
    CGFloat heights = [ApplicationStyle control_height:88];
    CGFloat imgWidth = [ApplicationStyle control_weight:36];
    
    _imageViews = [[UIImageView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:40], (heights - imgWidth)/2, imgWidth, imgWidth)];
    [self.contentView addSubview:_imageViews];
    
    _titleLabs = [[UILabel alloc] initWithFrame:CGRectMake(_imageViews.bottomOffset + [ApplicationStyle control_weight:36], (heights - [ApplicationStyle control_height:30])/2, [ApplicationStyle control_weight:130], [ApplicationStyle control_height:30])];
    _titleLabs.font = [ApplicationStyle textThrityFont];
    _titleLabs.textColor = [@"ffffff" hexStringToColor];
    [self.contentView addSubview:_titleLabs];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
