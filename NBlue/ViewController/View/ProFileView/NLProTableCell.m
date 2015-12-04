//
//  ProTableCell.m
//  NBlue
//
//  Created by LYD on 15/11/25.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLProTableCell.h"

@implementation NLProTableCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI{
    
    CGFloat x = [ApplicationStyle control_weight:36], y = self.frame.size.height, w = [ApplicationStyle control_weight:48];
    
    self.cellImages = [[UIImageView alloc] initWithFrame:CGRectMake(x, (y - w)/2, w, w)];
    [self.contentView addSubview:self.cellImages];
    
    self.cellLabs = [[UILabel alloc] initWithFrame:CGRectMake(x + w + x, 0, SCREENWIDTH - (x + w + x), y)];
    self.cellLabs.textColor = [@"1b1b1b" hexStringToColor];
    self.cellLabs.font = [ApplicationStyle textThrityFont];
    [self.contentView addSubview:self.cellLabs];
    
    UIImageView *imageArrow = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:24] - [ApplicationStyle control_weight:16], (y - [ApplicationStyle control_height:24])/2, [ApplicationStyle control_weight:16], [ApplicationStyle control_height:24])];
    imageArrow.image = [UIImage imageNamed:@"Profile_Arrow"];
    [self.contentView addSubview:imageArrow];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, [ApplicationStyle control_height:88] - [ApplicationStyle control_height:2], SCREENWIDTH - x, [ApplicationStyle control_height:1])];
    line.backgroundColor = [ApplicationStyle subjectLineViewColor];
    [self.contentView addSubview:line];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
