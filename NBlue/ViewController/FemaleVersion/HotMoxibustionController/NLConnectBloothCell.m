//
//  NLConnectBloothCell.m
//  NBlue
//
//  Created by LYD on 15/12/31.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLConnectBloothCell.h"

@implementation NLConnectBloothCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI{
    self.bloothName = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:20], [ApplicationStyle control_height:10], SCREENWIDTH, [ApplicationStyle control_height:30])];
    self.bloothName.font = [UIFont   systemFontOfSize:13];
    [self.contentView addSubview:self.bloothName];
    
    self.bloothUUID = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:20], [ApplicationStyle control_height:40], SCREENWIDTH, [ApplicationStyle control_height:20])];
    self.bloothUUID.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.bloothUUID ];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
