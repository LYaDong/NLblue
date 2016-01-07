//
//  NLMaleNBluePlanCell.m
//  NBlue
//
//  Created by LYD on 16/1/7.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLMaleNBluePlanCell.h"

@implementation NLMaleNBluePlanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI{
    
    CGFloat x = [ApplicationStyle control_weight:38],y = [ApplicationStyle control_height:88];
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, SCREENWIDTH, y)];
    self.titleLab.textColor = [ApplicationStyle subjectMaleTextBlackColor];
    self.titleLab.font = [ApplicationStyle textThrityFont];
    [self.contentView addSubview:self.titleLab];
    
    self.switchOff = [[UISwitch alloc] initWithFrame:CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:104 + 24], ([ApplicationStyle control_height:88] - [ApplicationStyle control_height:64])/2, [ApplicationStyle control_weight:104], [ApplicationStyle control_height:64])];
    self.switchOff.on = YES;
    [self.contentView addSubview:self.switchOff];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
