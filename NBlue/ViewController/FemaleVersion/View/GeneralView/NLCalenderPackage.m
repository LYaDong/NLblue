//
//  NLCalenderPackage.m
//  NBlue
//
//  Created by LYD on 15/11/25.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLCalenderPackage.h"

#define WidthSCalender [ApplicationStyle control_weight:66]

static const NSInteger CALENDERTAG = 1000;
static const NSInteger calenderVertical = 6;
static const NSInteger ARROWTAG = 1500;


@interface NLCalenderPackage()
@property(nonatomic,strong)UIView *calenderView;

@property(nonatomic,strong)UILabel *yearMonthLab;
//判断让谁圆角
@property(nonatomic,assign)NSInteger radinIndex;;
//判断要去哪天
@property(nonatomic,assign)NSInteger indexDay;
//判断点了哪天
@property(nonatomic,strong)NSString *dayText;
//判断加减
@property(nonatomic,assign)NSInteger index;
@end
@implementation NLCalenderPackage
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _indexDay = 0;
        _radinIndex = 0;
        [self buildUI:_indexDay];
    }
    return self;
}
-(void)buildUI:(NSInteger)day{
    _calenderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.frame.size.height)];
    [self addSubview:_calenderView];
    
    //时间
    NSDate *date = [ApplicationStyle whatMonth:[NSDate date] timeDay:day];
    
    UIView *viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:66])];
    viewBack.backgroundColor = [ApplicationStyle subjectWithColor];
    viewBack.alpha = 0.1;
    [_calenderView addSubview:viewBack];
    

    //年 月
    _yearMonthLab = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:47], 0, SCREENWIDTH - [ApplicationStyle control_weight:47 *2], [ApplicationStyle control_height:66])];
    _yearMonthLab.text = [NSString stringWithFormat:@"%ld年%ld月",(long)[ApplicationStyle whatYears:date],(long)[ApplicationStyle whatMonths:date]];
    _yearMonthLab.font = [ApplicationStyle textThrityFont];
    _yearMonthLab.textColor = [@"f13c61" hexStringToColor];
    _yearMonthLab.textAlignment = NSTextAlignmentCenter;
    [_calenderView addSubview:_yearMonthLab];
    
    NSArray *arrowImage = @[@"NLCalneder_Package_Lift",@"NLCalneder_Package_Right"];
    
    for (NSInteger i=0; i<arrowImage.count; i++) {
        UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        arrowBtn.frame = CGRectMake([ApplicationStyle control_weight:46] + i* (SCREENWIDTH - [ApplicationStyle control_weight:46 * 2] - [ApplicationStyle control_weight:18]), ([ApplicationStyle control_height:66] - [ApplicationStyle control_height:34])/2, [ApplicationStyle control_weight:18], [ApplicationStyle control_height:34]);
        arrowBtn.tag = ARROWTAG + i;
        arrowBtn.backgroundColor = [UIColor redColor];
        [arrowBtn setImage:[UIImage imageNamed:arrowImage[i]] forState:UIControlStateNormal];
        [arrowBtn addTarget:self action:@selector(arrowBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        [_calenderView addSubview:arrowBtn];
    }
    
    
    UIButton *goDay = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    goDay.frame = CGRectMake(SCREENWIDTH/2 + (SCREENWIDTH/2 - [ApplicationStyle control_weight:36])/2,([ApplicationStyle control_height:66] - [ApplicationStyle control_height:36])/2, [ApplicationStyle control_weight:36], [ApplicationStyle control_weight:36]);
    [goDay setTitle:@"今" forState:UIControlStateNormal];
    goDay.backgroundColor = [@"ffdbe2" hexStringToColor];
    goDay.layer.cornerRadius = [ApplicationStyle control_weight:36]/2;
    [goDay setTitleColor:[ApplicationStyle subjectPinkColor] forState:UIControlStateNormal];
    [goDay addTarget:self action:@selector(goDayDown) forControlEvents:UIControlEventTouchUpInside];
    [_calenderView addSubview:goDay];
    
    
    NSArray *weekArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    for (NSInteger i = 0; i<weekArray.count; i++) {
        UILabel *weekLab = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:41] + i * [ApplicationStyle control_weight:82], _yearMonthLab.bottomOffset, [ApplicationStyle control_weight:66], [ApplicationStyle control_weight:66])];
        weekLab.text = weekArray[i];
        weekLab.textColor = [@"ffc4d0" hexStringToColor];
        weekLab.textAlignment = NSTextAlignmentCenter;
        weekLab.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:20]];
        [_calenderView addSubview:weekLab];
    }
    
    
    
    for (NSInteger i = 0; i< calenderVertical * 7; i++) {
        CGFloat x = [ApplicationStyle control_weight:41] +  i%7*[ApplicationStyle control_weight:82];
        CGFloat y = _yearMonthLab.bottomOffset + [ApplicationStyle control_height:50] + i/7*[ApplicationStyle control_weight:82];

        UIButton *dayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        dayButton.frame = CGRectMake(x, y, WidthSCalender, WidthSCalender);
        [dayButton setTitleColor:[ApplicationStyle subjectPinkColor] forState:UIControlStateNormal];
        dayButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        dayButton.layer.cornerRadius = [ApplicationStyle control_weight:6];
        dayButton.tag = CALENDERTAG + i;
        [dayButton addTarget:self action:@selector(dayButtonDown:) forControlEvents:UIControlEventTouchUpInside];
        [_calenderView addSubview:dayButton];
        

        
        [self btnCalenderSortBtn:dayButton date:date i:i];
        [self calculationCalenderBtn:dayButton date:date i:i];
        
    }
}
//获取上个月的时间
- (NSInteger)getLastMonthDay:(NSInteger)day{
    NSDate *date = [ApplicationStyle whatMonth:[NSDate date] timeDay:day];
    NSInteger countDay = [ApplicationStyle totalDaysInMonth:date];
    return countDay;
}
//获取下个月的时间
- (NSInteger)getNextMonthDay:(NSInteger)day{
    NSDate *date = [ApplicationStyle whatMonth:[NSDate date] timeDay:day];
    NSInteger countDay = [ApplicationStyle totalDaysInMonth:date];
    return countDay;
}


//回到今天
-(void)goDayDown{
    _radinIndex = 0;
    _index = 0;
    [_calenderView removeFromSuperview];
    [self buildUI:0];
    
}
//日历按钮
-(void)dayButtonDown:(UIButton *)btn{
    
    [self resetRadius];
    btn.layer.cornerRadius = WidthSCalender/2;
    _radinIndex = 1;
    _dayText = btn.titleLabel.text;
}
//重置btn
-(void)resetRadius{
    for (NSInteger i = 0; i<calenderVertical * 7; i++) {
        UIButton *btnC = (UIButton *)[self viewWithTag:CALENDERTAG + i];
        btnC.layer.cornerRadius = [ApplicationStyle control_weight:6];
    }
}
//切换日期
-(void)arrowBtnDown:(UIButton *)btn{
    
    [_calenderView removeFromSuperview];
    
    if (btn.tag == ARROWTAG) {
        _index --;
        [self buildUI:_indexDay + _index];
    }else{
        _index ++;
        [self buildUI:_indexDay + _index];
    }
}
//计算内容
-(void)btnCalenderSortBtn:(UIButton *)dayButton date:(NSDate*)date i:(NSInteger)i{
    NSInteger theCurrent = [ApplicationStyle whatDays:date];
    NSInteger daysInLastMonth = [ApplicationStyle totalDaysInMonth:date];
    NSInteger firstWeekday    = [ApplicationStyle getWeekofFirstInDate:date];

    
    NSInteger lastCountDay = [self getLastMonthDay:_index - 1];

//    NSInteger nextCountDay = [self getNextMonthDay:_index + 1];

    NSInteger day = 0;
    if (i < firstWeekday) {
        //上个月的日子
//        day = daysInLastMonth - firstWeekday + i ;
        day = lastCountDay - (firstWeekday - 1 - i);
    }else if (i > firstWeekday + daysInLastMonth - 1){
        //下个月的日子
        day = i + 1 - firstWeekday - daysInLastMonth;
        //            dayButton.backgroundColor = [UIColor lightGrayColor];
    }else{
        //本月的日子
        day = i - firstWeekday + 1;
        dayButton.backgroundColor = [@"fee39a" hexStringToColor];
        
    }
    //判断让谁圆角
    if (_radinIndex==0) {
        //等于当天的日子
        if (i - firstWeekday == theCurrent - 1) {
            //            dayButton.backgroundColor = [UIColor redColor];
            dayButton.layer.cornerRadius = WidthSCalender/2;
        }
    }else{
        //等于点击的日子
        if (day == [_dayText integerValue]) {
            dayButton.layer.cornerRadius = WidthSCalender/2;
        }
    }
    [dayButton setTitle:[NSString stringWithFormat:@"%ld",(long)day] forState:UIControlStateNormal];
}

//计算经期
-(void)calculationCalenderBtn:(UIButton *)dayButton date:(NSDate *)date i:(NSInteger)i{
    NSInteger firstWeekday    = [ApplicationStyle getWeekofFirstInDate:date];
    //间隔周期
    NSInteger ZQ = 28;
    
    NSDate *userDate = [ApplicationStyle dateTransformationStr:@"20151201"];
    NSString *currentTime = [ApplicationStyle datePickerTransformationStr:date];
    //预计计算多少周
    for (NSInteger j=0; j<6; j++) {
        
        NSString *ycq = [ApplicationStyle datePickerTransformationStr:[userDate dateByAddingTimeInterval:(60 * 60 * 24) * ZQ * j]];
        NSString *currentYearMonth = [currentTime substringWithRange:NSMakeRange(0, 6)];
        NSString *userYearMonth = [ycq  substringWithRange:NSMakeRange(0, 6)];
        
        
        if ([currentYearMonth isEqualToString:userYearMonth]) {
            
            NSInteger day = 0;
            if (i>=firstWeekday) {
                day = i - firstWeekday + 1;
            }
            NSString *yddd = [ycq substringWithRange:NSMakeRange(ycq.length-2, 2)];
            for (NSInteger z=0; z<5; z++) {
                //经期来临的日子
                if (day == [yddd integerValue] + z) {
                    dayButton.backgroundColor = [@"ffad54" hexStringToColor];//预测期
                    if (j==0) {
                        dayButton.backgroundColor = [@"ff6c32" hexStringToColor];//经期
                    }
                }
            }
            //易孕期
            for (NSInteger x = 0; x<10; x++) {
                if ([yddd integerValue] - 14 + x == day) {
                    dayButton.backgroundColor = [@"ffe9ed" hexStringToColor];//易孕期
                }
            }
        }
    }
}

-(void)periodAndforecast{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
