//
//  NLMyEquipmentCell.m
//  NBlue
//
//  Created by LYD on 15/11/27.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLMyEquipmentCell.h"

@implementation NLMyEquipmentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI{
    CGFloat x = [ApplicationStyle control_weight:36],h = self.frame.size.height;
    
    self.liftTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, [ApplicationStyle control_weight:200], h)];
    self.liftTitleLab.textColor = [@"1b1b1b" hexStringToColor];
    self.liftTitleLab.font = [ApplicationStyle textThrityFont];
    [self.contentView addSubview:self.liftTitleLab];
    
    self.rightTitleLab = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:300], 0, SCREENWIDTH - [ApplicationStyle control_weight:300] - [ApplicationStyle control_weight:30], h)];
    self.rightTitleLab.textAlignment = NSTextAlignmentRight;
    self.rightTitleLab.textColor = [ApplicationStyle subjectTableCellLabColor];
    self.rightTitleLab.font = [ApplicationStyle textThrityFont];
//    self.rightTitleLab.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.rightTitleLab];
    
    self.imageArrow = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:24] - [ApplicationStyle control_weight:16], (h - [ApplicationStyle control_height:24])/2, [ApplicationStyle control_weight:16], [ApplicationStyle control_height:24])];
    self.imageArrow.image = [UIImage imageNamed:@"Profile_Arrow"];
    self.imageArrow.hidden = YES;
    [self.contentView addSubview:self.imageArrow];
    
    self.relivewBindingLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, h)];
    self.relivewBindingLab.textAlignment = NSTextAlignmentCenter;
    self.relivewBindingLab.font = [ApplicationStyle textThrityFont];
    self.relivewBindingLab.textColor = [@"f13c61" hexStringToColor];
    [self.contentView addSubview:self.relivewBindingLab];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
