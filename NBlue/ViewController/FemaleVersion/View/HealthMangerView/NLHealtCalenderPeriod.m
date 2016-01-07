//
//  NLHealtCalenderPeriod.m
//  NBlue
//
//  Created by LYD on 15/12/15.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLHealtCalenderPeriod.h"

@implementation NLHealtCalenderPeriod
- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color text:(NSString *)text{
    if (self = [super initWithFrame:frame]) {
        [self buildUIColor:color text:text];
    }
    return self;
}
-(void)buildUIColor:(UIColor *)color text:(NSString *)text{
    
    CGSize textSize = [ApplicationStyle textSize:text font:[UIFont systemFontOfSize:[ApplicationStyle control_weight:20]] size:SCREENWIDTH];
    
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ApplicationStyle control_weight:32], [ApplicationStyle control_height:20])];
    back.layer.cornerRadius = [ApplicationStyle control_weight:6];
    back.backgroundColor = color;
    [self addSubview:back];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(back.rightSideOffset + [ApplicationStyle control_weight:10], 0, textSize.width, textSize.height)];
    lab.text = text;
    lab.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:20]];
    lab.textColor = color;
    [self addSubview:lab];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
