//
//  NLStepCountLabView.m
//  NBlue
//
//  Created by LYD on 15/12/3.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLStepCountLabView.h"
@interface NLStepCountLabView()

@end
@implementation NLStepCountLabView




-(instancetype)initWithFrame:(CGRect)frame type:(NSInteger)type remarkLabText:(NSString *)reamrkLab dataLabText:(NSString *)dataLabText{
    if (self = [super initWithFrame:frame]) {
        [self buildRemarkText:reamrkLab dataLabText:dataLabText type:type];
    }
    return self;
}
-(void)buildRemarkText:(NSString *)remarkText dataLabText:(NSString *)dataLabText type:(NSInteger)type{
    UILabel *remarkLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [ApplicationStyle control_height:32])];
    remarkLab.textColor = [@"ffc0cc" hexStringToColor];
    remarkLab.font = [ApplicationStyle textThrityFont];
    remarkLab.text = [NSString stringWithFormat:@"%@",remarkText];
    remarkLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:remarkLab];
    
    UILabel *dataLab = [[UILabel alloc] initWithFrame:CGRectMake(0, remarkLab.bottomOffset + [ApplicationStyle control_height:20], self.frame.size.width, [ApplicationStyle control_height:45])];
    dataLab.textColor = [ApplicationStyle subjectWithColor];
    dataLab.text = [NSString stringWithFormat:@"%@",dataLabText];
    dataLab.textAlignment = NSTextAlignmentCenter;
//    dataLab.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:48]];
    [self addSubview:dataLab];
    
//    switch (type) {
//        case LabTextType_DayStepNum:
//        {
//            
//            [self heartReatlab:dataLab rang:NSMakeRange(0, dataLab.text.length) rangTo:NSMakeRange(0, 0)];
//            
//            break;
//        }
//        case LabTextType_DayDistance:
//        {
//            [self heartReatlab:dataLab rang:NSMakeRange(0, dataLab.text.length - 2) rangTo:NSMakeRange(0, 0)];
//            break;
//        }
//        case LabTextType_DayEnergy:
//        {
//            [self heartReatlab:dataLab rang:NSMakeRange(0, dataLab.text.length - 2) rangTo:NSMakeRange(0, 0)];
//            break;
//        }
//        case LabTextType_DayActovity:
//        {
//            [self heartReatlab:dataLab rang:NSMakeRange(0, 2) rangTo:NSMakeRange(4, 2)];
//            break;
//        }
//        default:
//            break;
//    }
    
}

#pragma makr 字体大小
-(void)heartReatlab:(UILabel *)lab rang:(NSRange)rang rangTo:(NSRange)rangTo{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:lab.text];
    //设置大小
    [str addAttribute:NSFontAttributeName value:[UIFont  fontWithName:@"Helvetica-Bold" size:[ApplicationStyle control_weight:48]] range:rang];
    [str addAttribute:NSFontAttributeName value:[UIFont  fontWithName:@"Helvetica-Bold" size:[ApplicationStyle control_weight:48]] range:rangTo];
    //设置颜色
    //    [str addAttribute:NSForegroundColorAttributeName value:UIColorFromHEX(0x949799) range:rang2];
    lab.attributedText = str;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
