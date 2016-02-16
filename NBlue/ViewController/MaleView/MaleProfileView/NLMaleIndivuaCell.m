//
//  NLMaleIndivuaCell.m
//  NBlue
//
//  Created by LYD on 16/1/13.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLMaleIndivuaCell.h"

@implementation NLMaleIndivuaCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI{
    
    CGFloat x = [ApplicationStyle control_weight:36] , y = [ApplicationStyle control_height:88];
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, SCREENWIDTH - x, y)];
    self.titleLab.textColor = [@"1b1b1b" hexStringToColor];
    self.titleLab.font = [ApplicationStyle textThrityFont];
    [self.contentView addSubview:self.titleLab];
    
    self.arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:16] - [ApplicationStyle control_weight:24], (y - [ApplicationStyle control_height:24])/2, [ApplicationStyle control_weight:16], [ApplicationStyle control_height:24])];
    self.arrowImg.image = [UIImage imageNamed:@"NL_Male_lightArrow"];
    [self.contentView addSubview:self.arrowImg];
    
    self.switchs = [[UISwitch alloc] initWithFrame:CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:104 + 24], ([ApplicationStyle control_height:88] - [ApplicationStyle control_height:64])/2, [ApplicationStyle control_weight:104], [ApplicationStyle control_height:64])];
    self.switchs.on = NO;
    [self.contentView addSubview:self.switchs];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, y - [ApplicationStyle control_height:1], SCREENWIDTH, [ApplicationStyle control_height:1])];
    line.backgroundColor = [@"d7d7d7" hexStringToColor];
    [self.contentView addSubview:line];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:1])];
    line1.backgroundColor = [@"d7d7d7" hexStringToColor];
    [self.contentView addSubview:line1];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
