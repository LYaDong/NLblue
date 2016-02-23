//
//  NLMyMessageCell.m
//  NBlue
//
//  Created by LYD on 16/2/23.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLMyMessageCell.h"

@implementation NLMyMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    return self;
}
-(void)buildUI{
    _headImage = [[UIImageView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:24], [ApplicationStyle control_height:20], [ApplicationStyle control_weight:96], [ApplicationStyle control_weight:96])];
    _headImage.layer.cornerRadius = [ApplicationStyle control_weight:10];
    [self addSubview:_headImage];
    
    _headTitle = [[UILabel alloc] initWithFrame:CGRectMake(_headImage.rightSideOffset+[ApplicationStyle control_weight:24], [ApplicationStyle control_height:28], SCREENWIDTH - [ApplicationStyle control_weight:96 + 48], [ApplicationStyle control_height:40])];
    _headTitle.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:34]];
    _headTitle.textColor = [@"313131" hexStringToColor];
    [self addSubview:_headTitle];
    
    _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:154+24], [ApplicationStyle control_height:28], [ApplicationStyle control_weight:154], [ApplicationStyle control_height:30])];
    _timeLab.textColor = [@"999696" hexStringToColor];
    _timeLab.font = [ApplicationStyle textSuperSmallFont];
    [self addSubview:_timeLab];
    
    _countLab = [[UILabel alloc] initWithFrame:CGRectMake(_headImage.rightSideOffset+[ApplicationStyle control_weight:24], _headTitle.bottomOffset + [ApplicationStyle control_height:12], SCREENWIDTH - [ApplicationStyle control_weight:96 + 48 + 24] , [ApplicationStyle control_height:110])];
    _countLab.textColor = [@"999999" hexStringToColor];
    _countLab.font = [ApplicationStyle textThrityFont];
    _countLab.numberOfLines = 0;
    [self addSubview:_countLab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(_headImage.rightSideOffset+[ApplicationStyle control_weight:24], [ApplicationStyle control_height:200], SCREENWIDTH - [ApplicationStyle control_weight:96 + 48], [ApplicationStyle control_height:1])];
    line.backgroundColor = [@"c8c8cc" hexStringToColor];
    [self addSubview:line];
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
