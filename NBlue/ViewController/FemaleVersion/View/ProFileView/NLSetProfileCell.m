//
//  NLSetProfileCell.m
//  NBlue
//
//  Created by LYD on 15/12/25.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLSetProfileCell.h"

@implementation NLSetProfileCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI{
    CGFloat  y = self.frame.size.height;
    
    UIView *viewBack = [[UIView alloc] initWithFrame:CGRectMake(-10, ([ApplicationStyle control_height:128] - [ApplicationStyle control_height:88])/2, SCREENWIDTH+10, [ApplicationStyle control_height:88])];
    viewBack.backgroundColor = [UIColor whiteColor];
    viewBack.layer.borderColor = [@"ffc5c5" hexStringToColor].CGColor;
    viewBack.layer.borderWidth = 0.5;
    [self.contentView addSubview:viewBack];
    
    
    self.cellTitleLab = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:36], 0, SCREENWIDTH - [ApplicationStyle control_weight:35], [ApplicationStyle control_height:88])];
    self.cellTitleLab.textColor = [@"1b1b1b" hexStringToColor];
    self.cellTitleLab.font = [ApplicationStyle textThrityFont];
    [viewBack addSubview:self.cellTitleLab];
    
    self.cellImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:24] - [ApplicationStyle control_weight:16], (y - [ApplicationStyle control_height:24])/2, [ApplicationStyle control_weight:16], [ApplicationStyle control_height:24])];
    self.cellImage.image = [UIImage imageNamed:@"Profile_Arrow"];
    [viewBack addSubview:self.cellImage];
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
