//
//  NLCalenderPackage.m
//  NBlue
//
//  Created by LYD on 15/11/25.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLCalenderPackage.h"

static const NSInteger Corss = 7;
//static const NSInteger Vertical = 7;
static const NSInteger calenderVertical = 5;

@interface NLCalenderPackage()
@property(nonatomic,strong)UILabel *yearMonthLab;

@end
@implementation NLCalenderPackage
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI:0];
    }
    return self;
}
-(void)buildUI:(NSInteger)day{
    NSDate *date = [ApplicationStyle whatMonth:[NSDate date] timeDay:0];
    CGFloat w = (self.frame.size.width - [ApplicationStyle control_weight:60 * 2]) / Corss;
//    CGFloat h = self.frame.size.height / Vertical;
    //年 月
    _yearMonthLab = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:47], 0, SCREENWIDTH - [ApplicationStyle control_weight:47 *2], [ApplicationStyle control_height:66])];
    _yearMonthLab.text = [NSString stringWithFormat:@"%ld年%ld月",(long)[ApplicationStyle whatYears:date],(long)[ApplicationStyle whatMonths:date]];
    _yearMonthLab.font = [ApplicationStyle textThrityFont];
    _yearMonthLab.textColor = [@"f13c61" hexStringToColor];
    _yearMonthLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_yearMonthLab];
    
    NSArray *weekArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    for (NSInteger i = 0; i<weekArray.count; i++) {
        UILabel *weekLab = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:47] + i * (w + [ApplicationStyle control_weight:10]), _yearMonthLab.bottomOffset, w, [ApplicationStyle control_height:50])];
        weekLab.text = weekArray[i];
        weekLab.textColor = [@"ffc4d0" hexStringToColor];
        weekLab.textAlignment = NSTextAlignmentCenter;
        weekLab.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:20]];
        [self addSubview:weekLab];
    }
    
    NSInteger theCurrent = [ApplicationStyle whatDays:date];
    
    
    NSLog(@"%ld",theCurrent);
    
    for (NSInteger i = 0; i< calenderVertical * 7; i++) {
//        NSInteger x = [ApplicationStyle control_weight:47] + (i % 7) * (w + [ApplicationStyle control_weight:10]), y = (i / 7) * (w + [ApplicationStyle control_weight:10]) + _yearMonthLab.bottomOffset + [ApplicationStyle control_height:50];
        
        
        CGFloat x = [ApplicationStyle control_weight:41] +  i%7*[ApplicationStyle control_weight:82];
        CGFloat y = _yearMonthLab.bottomOffset + [ApplicationStyle control_height:50] + i/7*[ApplicationStyle control_weight:82];
        CGFloat ww = [ApplicationStyle control_weight:66];
        CGFloat h = [ApplicationStyle control_weight:66];
        
        
        
        UIButton *dayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        dayButton.frame = CGRectMake(x, y, ww, h);
        [dayButton setTitleColor:[ApplicationStyle subjectPinkColor] forState:UIControlStateNormal];
        dayButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        NSInteger daysInLastMonth = [ApplicationStyle totalDaysInMonth:date];
        NSInteger firstWeekday    = [ApplicationStyle getWeekofFirstInDate:date];
        
        NSLog(@"%ld",firstWeekday);
        NSInteger day = 0;
        if (i < firstWeekday) {
            //上个月的日子
            day = daysInLastMonth - firstWeekday + i + 1;
//            dayButton.backgroundColor = [UIColor lightGrayColor];
        }else if (i > firstWeekday + daysInLastMonth - 1){
            //下个月的日子
            day = i + 1 - firstWeekday - daysInLastMonth;
//            dayButton.backgroundColor = [UIColor lightGrayColor];
        }else{
            //本月的日子
            day = i - firstWeekday + 1;
            dayButton.backgroundColor = [@"ffdbe2" hexStringToColor];
        }
        if (i - firstWeekday == theCurrent - 1) {
            dayButton.backgroundColor = [UIColor redColor];
            dayButton.layer.cornerRadius = w/2;
        }
        [dayButton setTitle:[NSString stringWithFormat:@"%ld",(long)day] forState:UIControlStateNormal];
        [self addSubview:dayButton];
        
    }
    
   
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
