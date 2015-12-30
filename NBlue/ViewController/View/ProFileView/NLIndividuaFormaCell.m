//
//  NLIndividuaFormaCell.m
//  NBlue
//
//  Created by LYD on 15/11/26.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLIndividuaFormaCell.h"

@implementation NLIndividuaFormaCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    return self;
}
-(void)buildUI{
    CGFloat x = [ApplicationStyle control_weight:36],h = self.frame.size.height;
    
    _cellHeadTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, [ApplicationStyle control_weight:300], h)];
    _cellHeadTitleLab.font = [ApplicationStyle textThrityFont];
    _cellHeadTitleLab.textColor = [@"1b1b1b" hexStringToColor];
    [self.contentView addSubview:_cellHeadTitleLab];
    
    _cellimageUrl = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:250], 0, [ApplicationStyle control_weight:200], h)];
    _cellimageUrl.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:26]];
    _cellimageUrl.textColor = [@"898989" hexStringToColor];
    _cellimageUrl.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_cellimageUrl];
    
    
    
    _imageArrow = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:24] - [ApplicationStyle control_weight:16], (h - [ApplicationStyle control_height:24])/2, [ApplicationStyle control_weight:16], [ApplicationStyle control_height:24])];
    _imageArrow.image = [UIImage imageNamed:@"Profile_Arrow"];
    [self.contentView addSubview:_imageArrow];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
