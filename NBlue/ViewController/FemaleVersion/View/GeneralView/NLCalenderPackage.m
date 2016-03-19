//
//  NLCalenderPackage.m
//  NBlue
//
//  Created by LYD on 15/11/25.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLCalenderPackage.h"
#import "NLSQLData.h"
#define WidthSCalender [ApplicationStyle control_weight:66]

static const NSInteger CALENDERTAG = 1000;
static const NSInteger calenderVertical = 6;
static const NSInteger ARROWTAG = 1500;
static const NSInteger DIFFERDAYINDEX = 90;


@interface NLCalenderPackage()

@property(nonatomic,strong)NSString *yearTime;
@property(nonatomic,strong)NSString *monthTime;
@property(nonatomic,strong)NSString *dayTime;

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


@property(nonatomic,assign)NSInteger countIndex;
@end
@implementation NLCalenderPackage
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _indexDay = 0;
        _radinIndex = 0;
        
        self.backgroundColor = [@"fffff0" hexStringToColor];
        
        [self registerNotification];
        [self buildUI:_indexDay];
    }
    return self;
}
-(void)registerNotification{
    NSNotificationCenter *notifi= [NSNotificationCenter defaultCenter];
    [notifi addObserver:self selector:@selector(goBackToDay) name:CalenderGoBackToDayNotification object:nil];
}
-(void)goBackToDay{
    [self goDayDown];
}
-(void)buildUI:(NSInteger)day{
    _calenderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.frame.size.height)];
    [self addSubview:_calenderView];
    
    //时间
    NSDate *date = [ApplicationStyle whatMonth:[NSDate date] timeDay:day];
    
    UIView *viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:66])];
    viewBack.backgroundColor = [ApplicationStyle subjectWithColor];
    [_calenderView addSubview:viewBack];
    
    
    UIView *lineViewBack = [UIView statusBackView:CGRectMake(0, [ApplicationStyle control_height:65], SCREENWIDTH, [ApplicationStyle control_height:4])];
    [self addSubview:lineViewBack];
    
    
    _yearTime = [NSString stringWithFormat:@"%ld",(long)[ApplicationStyle whatYears:date]];
    if ((long)[ApplicationStyle whatMonths:date]>=10) {
      _monthTime = [NSString stringWithFormat:@"%ld",(long)[ApplicationStyle whatMonths:date]];
    }else{
      _monthTime = [NSString stringWithFormat:@"0%ld",(long)[ApplicationStyle whatMonths:date]];
    }
    
    //年 月
    _yearMonthLab = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:47], 0, SCREENWIDTH - [ApplicationStyle control_weight:47 *2], [ApplicationStyle control_height:66])];
    _yearMonthLab.text = [NSString stringWithFormat:@"%@年%@月",_yearTime,_monthTime];
    _yearMonthLab.font = [ApplicationStyle textThrityFont];
    _yearMonthLab.textColor = [@"f13c61" hexStringToColor];
    _yearMonthLab.textAlignment = NSTextAlignmentCenter;
    [_calenderView addSubview:_yearMonthLab];
    
    NSArray *arrowImage = @[@"NLCalneder_Package_Lift",@"NLCalneder_Package_Right"];
    NSArray *arrowImage_D = @[@"NLCalneder_Package_Lift_D",@"NLCalneder_Package_Right_D"];
    
    for (NSInteger i=0; i<arrowImage.count; i++) {
        UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        arrowBtn.frame = CGRectMake([ApplicationStyle control_weight:46] + i* (SCREENWIDTH - [ApplicationStyle control_weight:46 * 2] - [ApplicationStyle control_weight:50]), ([ApplicationStyle control_height:66] - [ApplicationStyle control_height:50])/2, [ApplicationStyle control_weight:50], [ApplicationStyle control_height:50]);
        arrowBtn.tag = ARROWTAG + i;
//        arrowBtn.backgroundColor = [UIColor redColor];
        [arrowBtn setImage:[UIImage imageNamed:arrowImage[i]] forState:UIControlStateNormal];
        [arrowBtn setImage:[UIImage imageNamed:arrowImage_D[i]] forState:UIControlStateHighlighted];
        [arrowBtn addTarget:self action:@selector(arrowBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        [_calenderView addSubview:arrowBtn];
    }
    
    
    UIButton *goDay = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    goDay.frame = CGRectMake(SCREENWIDTH/2 + (SCREENWIDTH/2 - [ApplicationStyle control_weight:50])/2,([ApplicationStyle control_height:66] - [ApplicationStyle control_height:50])/2, [ApplicationStyle control_weight:50], [ApplicationStyle control_weight:50]);
    [goDay setTitle:@"今" forState:UIControlStateNormal];
    goDay.backgroundColor = [@"ffdbe2" hexStringToColor];
    goDay.layer.cornerRadius = [ApplicationStyle control_weight:50]/2;
    [goDay setTitleColor:[ApplicationStyle subjectPinkColor] forState:UIControlStateNormal];
    [goDay addTarget:self action:@selector(goDayDown) forControlEvents:UIControlEventTouchUpInside];
//    goDay.backgroundColor = [UIColor redColor];
    [_calenderView addSubview:goDay];
    
    
    NSArray *weekArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    for (NSInteger i = 0; i<weekArray.count; i++) {
        UILabel *weekLab = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:41] + i * [ApplicationStyle control_weight:82], _yearMonthLab.bottomOffset, [ApplicationStyle control_weight:66], [ApplicationStyle control_weight:66])];
        weekLab.text = weekArray[i];
        weekLab.textColor = [@"929292" hexStringToColor];
        weekLab.textAlignment = NSTextAlignmentCenter;
        weekLab.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:20]];
        [_calenderView addSubview:weekLab];
    }
    
    
    
    for (NSInteger i = 0; i< calenderVertical * 7; i++) {
        CGFloat x = [ApplicationStyle control_weight:41] +  i%7*([ApplicationStyle control_weight:66] + [ApplicationStyle control_weight:16]);
        CGFloat y = _yearMonthLab.bottomOffset + [ApplicationStyle control_height:50] + i/7*([ApplicationStyle control_weight:66] + [ApplicationStyle control_height:10]);

        UIButton *dayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        dayButton.frame = CGRectMake(x, y, WidthSCalender, WidthSCalender);
        [dayButton setTitleColor:[ApplicationStyle subjectPinkColor] forState:UIControlStateNormal];
        dayButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        dayButton.layer.cornerRadius = [ApplicationStyle control_weight:6];
        dayButton.tag = CALENDERTAG + i;
        dayButton.titleLabel.font = [UIFont  systemFontOfSize:[ApplicationStyle control_weight:24]];
        [dayButton setTitleColor:[@"fe5a7b" hexStringToColor] forState:UIControlStateNormal];
        
        [_calenderView addSubview:dayButton];
        

        
        [self btnCalenderSortBtn:dayButton date:date i:i];
        [self calculationCalenderBtn:dayButton date:date i:i dayIndex:day];
        
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
    
    NSString *dayDate = [ApplicationStyle datePickerTransformationCorss:[NSDate date]];
    [self.delegate returnCalenderTime:dayDate];
    
}
//日历按钮
-(void)dayButtonDown:(UIButton *)btn{

    
    NSString *dayss = btn.titleLabel.text;
    
    if ([dayss integerValue]>=10) {
        _dayTime = [NSString stringWithFormat:@"%@",dayss];
    }else{
        _dayTime = [NSString stringWithFormat:@"0%@",dayss];
    }
    
    NSString *times = [NSString stringWithFormat:@"%@-%@-%@",_yearTime,_monthTime,_dayTime];
    [self.delegate returnCalenderTime:[NSString stringWithFormat:@"%@",times]];
    
    [self resetRadius];
    btn.layer.cornerRadius = WidthSCalender/2;
    _radinIndex = 1;
    _dayText = btn.titleLabel.text;
    
    
    
    
    
    //获得现在是时间
    NSString *toTime = [ApplicationStyle datePickerTransformationCorss:[NSDate date]];
    
    
//    NSLog(@"%ld",_countIndex + [ApplicationStyle whatDays:[NSDate date]]);
    
    //时间比较
    if (![times isEqualToString:toTime]) {
        //现在的时间
        NSDate *toDate = [ApplicationStyle dateTransformationStringWhiffletree:toTime];
        //点击的时间
        NSDate *clickDate = [ApplicationStyle dateTransformationStringWhiffletree:times];
        //计算相差多少天
        NSInteger maxDay = [ApplicationStyle dateInteverCurrentDate:clickDate afferentDate:toDate];
        if (labs(maxDay)>DIFFERDAYINDEX) {
            //清除按钮编辑。重新绘制
            NSDate *date = [ApplicationStyle whatMonth:[NSDate date] timeDay:_index];
            
            for (NSInteger i = 0; i<calenderVertical * 7; i++) {
                UIButton *btnC = (UIButton *)[self viewWithTag:CALENDERTAG + i];
                NSInteger daysInLastMonth = [ApplicationStyle totalDaysInMonth:date];
                NSInteger firstWeekday    = [ApplicationStyle getWeekofFirstInDate:date];
                NSInteger lastCountDay = [self getLastMonthDay:_index - 1];
                NSInteger day = 0;
                if (i < firstWeekday) {
                    //上个月的日子
                    day = lastCountDay - (firstWeekday - 1 - i);
                }else if (i > firstWeekday + daysInLastMonth - 1){
                    //下个月的日子
                    day = i + 1 - firstWeekday - daysInLastMonth;
                }else{
                    //本月的日子
                    day = i - firstWeekday + 1;
                    btnC.backgroundColor = [self safePeriodColor];
                    
                }
            }
            //重新绘制
            for (NSInteger i=0; i<5; i++) {
                UIButton *btns = (UIButton *)[self viewWithTag:btn.tag + i];
                btns.backgroundColor = [self periodColor];
            }
            NSMutableDictionary *dics = [NSMutableDictionary dictionary];
            [dics setValue:times forKey:@"isMenstruation"];
            [dics setValue:times forKey:@"currentDate"];
            [dics setValue:[times substringWithRange:NSMakeRange(0, 7)] forKey:@"yearOrMonth"];
            [[NLDatahub sharedInstance] calendarUpLoadDataDic:dics];
            [NLSQLData insterCanlenderDysmenorrheaDateData:dics];
        }else{//如果在三个月内。直接暴力把所有数据重新绘制
            [kAPPDELEGATE._loacluserinfo lastTimeGoPeriodDate:times];
            [_calenderView removeFromSuperview];
            [self buildUI:_indexDay + _index];
        }
        
    }
    
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
        
//        NSDate *date = [ApplicationStyle whatMonth:[NSDate date] timeDay:_indexDay + _index];
//        _countIndex += [ApplicationStyle totalDaysInMonth:date];
        
    }else{
        _index ++;
        [self buildUI:_indexDay + _index];
//        NSDate *date = [ApplicationStyle whatMonth:[NSDate date] timeDay:_indexDay + _index];
//        _countIndex -= [ApplicationStyle totalDaysInMonth:date];
    }
}
//计算内容
-(void)btnCalenderSortBtn:(UIButton *)dayButton date:(NSDate*)date i:(NSInteger)i{
    
    
    
    
    
    
    
    
    NSInteger theCurrent = [ApplicationStyle whatDays:date];
    NSInteger daysInLastMonth = [ApplicationStyle totalDaysInMonth:date];
    NSInteger firstWeekday    = [ApplicationStyle getWeekofFirstInDate:date];
    NSInteger lastCountDay = [self getLastMonthDay:_index - 1];
    NSInteger day = 0;
    if (i < firstWeekday) {
        //上个月的日子
        day = lastCountDay - (firstWeekday - 1 - i);
    }else if (i > firstWeekday + daysInLastMonth - 1){
        //下个月的日子
        day = i + 1 - firstWeekday - daysInLastMonth;
    }else{
        //本月的日子
        [dayButton addTarget:self action:@selector(dayButtonDown:) forControlEvents:UIControlEventTouchUpInside];
        day = i - firstWeekday + 1;
        dayButton.backgroundColor = [self safePeriodColor];
        
    }
    //判断让谁圆角
    if (_radinIndex==0) {
        //等于当天的日子
        if (i - firstWeekday == theCurrent - 1) {
            if ([[ApplicationStyle datePickerTransformationCorss:[NSDate date]] isEqualToString:[ApplicationStyle datePickerTransformationCorss:date]]) {
                dayButton.layer.cornerRadius = WidthSCalender/2;
            }
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
-(void)calculationCalenderBtn:(UIButton *)dayButton date:(NSDate *)date i:(NSInteger)i dayIndex:(NSInteger)dayIndex{
    
    
    NSLog(@"点击的年月 = %@  \n 当前的年月 = %@",[ApplicationStyle datePickerTransformationYearOrMonth:date],[ApplicationStyle datePickerTransformationYearOrMonth:[NSDate date]]);
    
    
    NSString *strClickDate = [ApplicationStyle datePickerTransformationCorss:date];
    //现在的时间
    NSDate *lastToDate = [ApplicationStyle dateTransformationStringWhiffletree:[kAPPDELEGATE._loacluserinfo getLastTimeGoPeriodDate]];
    //点击的时间
    NSDate *clickDate = [ApplicationStyle dateTransformationStringWhiffletree:strClickDate];

    
    NSLog(@"%@  %@",lastToDate,clickDate);
    NSLog(@"xxxxx = =  %ld",[ApplicationStyle dateCompareDateCurrentDate:clickDate afferentDate:lastToDate]);
    
    if ([ApplicationStyle dateCompareDateCurrentDate:clickDate afferentDate:lastToDate] == -1) {
        NSLog(@"%@",strClickDate);
        NSLog(@"%@",[NLSQLData canlenderDysmenorrheaDateData:[strClickDate substringWithRange:NSMakeRange(0, 7)]]);
        
    }else{
        /*
         ZQ                     周期
         ycq                    预测期
         ycqDay                 预测期的哪天
         */
        NSInteger firstWeekday    = [ApplicationStyle getWeekofFirstInDate:date];//获得本周的时间,在周几
        NSDictionary *dataDic = [PlistData getIndividuaData];//获得用户数据
        
        //间隔周期
        NSInteger ZQ = [[dataDic objectForKey:@"cycleTime"] integerValue];//获得周期
        NSInteger periodTime = [[dataDic objectForKey:@"periodTime"] integerValue];//获得经期
        
        NSDate *lastTimepPeriod = [ApplicationStyle dateTransformationStringWhiffletree:[kAPPDELEGATE._loacluserinfo getLastTimeGoPeriodDate]];//获得上一次来的时间
        NSString *currentTime = [ApplicationStyle datePickerTransformationStr:date];//获得当前时间
        //预计计算多少周
        for (NSInteger j=0; j<12+dayIndex; j++) {
            
            NSString *ycq = [ApplicationStyle datePickerTransformationStr:[lastTimepPeriod dateByAddingTimeInterval:(60 * 60 * 24) * ZQ * j]];//每次的预测期
            NSString *currentYearMonth = [currentTime substringWithRange:NSMakeRange(0, 6)];//来的年月日
            NSString *userYearMonth = [ycq  substringWithRange:NSMakeRange(0, 6)];//用户的年月日
            
            
            if ([currentYearMonth isEqualToString:userYearMonth]) {
                
                NSInteger day = 0;
                if (i>=firstWeekday) {
                    day = i - firstWeekday + 1;//获得本月的天数
                }
                
                NSString *ycqDay = [ycq substringWithRange:NSMakeRange(ycq.length-2, 2)];//预测期的天数
                for (NSInteger z=0; z<periodTime; z++) {
                    //经期来临的日子  经期每次循环用户选择的次数
                    if (day == [ycqDay integerValue] + z) {
                        dayButton.backgroundColor = [self theForecastPeriodColor];//预测期
                        if (j==0) {
                            dayButton.backgroundColor = [self periodColor];//经期
                        }
                    }
                }
                //易孕期
                for (NSInteger x = 0; x<10; x++) {
                    if (!day == 0) {//退14天，如果相等当前的day 则是易孕期
                        if ([ycqDay integerValue] - 14 + x == day) {
                            dayButton.backgroundColor = [self easyPregnancyColor];//易孕期
                        }
                    }
                }
            }
        }

    }
    
    
    
    
//    NSString *toDate = [ApplicationStyle datePickerTransformationYearOrMonth:[NSDate date]];
//    NSString *clickDate = [ApplicationStyle datePickerTransformationYearOrMonth:date];
//    if (![toDate isEqualToString:clickDate]) {
//        
//    }
    
    
    
}



- (UIColor *)safePeriodColor{
    UIColor *color = [@"fee69a" hexStringToColor];
    return color;
}
- (UIColor *)periodColor{
    UIColor *color = [@"ff7b47" hexStringToColor];
    return color;
}
- (UIColor *)theForecastPeriodColor{
    UIColor *color = [@"ffad54" hexStringToColor];
    return color;
}
- (UIColor *)easyPregnancyColor{
    UIColor *color = [@"ffdbe2" hexStringToColor];
    return color;
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
