//
//  NLHealtCalenderCell.m
//  NBlue
//
//  Created by LYD on 15/12/14.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLHealtCalenderCell.h"

@implementation NLHealtCalenderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI{
    
    
    CGFloat heights = self.frame.size.height;
    CGFloat x = [ApplicationStyle control_weight:46],w = [ApplicationStyle control_weight:40],h = [ApplicationStyle control_height:40];
    
    
    
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:88])];
    back.image = [UIImage imageNamed:@"NLBackCalenderTableBack"];
    [self.contentView addSubview:back];
    
    self.cellImage = [[UIImageView alloc] initWithFrame:CGRectMake(x, (heights - h)/2, w, h)];
    [self.contentView addSubview:self.cellImage];
    
    
    self.cellLab = [[UILabel alloc] initWithFrame:CGRectMake(x + w + [ApplicationStyle control_weight:16], 0, [ApplicationStyle control_weight:177], heights)];
    self.cellLab.textColor = [@"434343" hexStringToColor];
    self.cellLab.font = [ApplicationStyle textThrityFont];
    [self.contentView addSubview:self.cellLab];
    
    
    self.switchs = [[UISwitch alloc] initWithFrame:CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:104] , (heights - [ApplicationStyle control_height:64])/2, [ApplicationStyle control_weight:104], [ApplicationStyle control_height:64])];
    self.switchs.on = false;
    self.switchs.hidden = YES;
    [self.contentView addSubview:self.switchs];

    self.cellCountImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH - w - [ApplicationStyle control_weight:24], (heights - h)/2, w, h)];
    [self.contentView addSubview:self.cellCountImage];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
