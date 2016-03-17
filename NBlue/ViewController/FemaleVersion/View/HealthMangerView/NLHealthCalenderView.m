//
//  NLHealthCalenderView.m
//  NBlue
//
//  Created by LYD on 15/11/24.
//  Copyright © 2015年 LYD. All rights reserved.
//

static const NSInteger CELLTAG = 500;//不可以大于1000

#import "NLHealthCalenderView.h"
#import "NLCalenderPackage.h"
#import "NLHealtCalenderCell.h"
#import "NLHealtCalenderPeriod.h"
#import "NLCalenderPicker.h"
#import "NLCalenderLifeHabit.h"
#import "NLCalenderUncomfortable.h"
#import "PlistData.h"
#import "NLSQLData.h"
#import "NLLHRatingView.h"
#import "NLBluetoothAgreement.h"
@interface NLHealthCalenderView()<
UIScrollViewDelegate,
UITableViewDataSource,
UITableViewDelegate,
NLCalenderPickerDelegate,
NLCalenderLifeHabitDelegate,
NLCalenderUncomfortableDelegate,
NLCalenderPackageDelegate,
NLLHRatingViewDelegate>
@property(nonatomic,strong)NSString *selectedTime;
@property(nonatomic,strong)UIScrollView *mainScrollew;
@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)UILabel *periodTimeDay;
@property(nonatomic,strong)UIView *blackBack;
@property(nonatomic,strong)NLCalenderPicker *calenderPickerView;
@property(nonatomic,strong)NLCalenderLifeHabit *calenLifeHabitView;
@property(nonatomic,strong)NLCalenderUncomfortable *uncomfortableView;
@property(nonatomic,assign)NSInteger cellRow;
@property(nonatomic,assign)NSInteger switchOffNum;
@property(nonatomic,strong)NLLHRatingView *starView;
@property(nonatomic,assign)BOOL isQuert;
@property(nonatomic,assign)NSInteger isCurrentDay;
@property(nonatomic,strong)UIView *cartoonBackview;

@property(nonatomic,strong)NSMutableDictionary *canledarDataDic;
//@property(nonatomic,strong)NSString *loveloveStr;
//@property(nonatomic,strong)NSString *habitsLivingStr;
//@property(nonatomic,strong)NSString *uncomfortableStr;


@end
@implementation NLHealthCalenderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor yellowColor];
        _canledarDataDic = [NSMutableDictionary dictionary];
        [_canledarDataDic setValue:CommonText_Canlender_uncomfortable forKey:@"uncomfortable"];
        [_canledarDataDic setValue:CommonText_Canlender_habitsAndCustoms forKey:@"lifeHabit"];
        [_canledarDataDic setValue:@"0" forKey:@"haveSex"];
        [_canledarDataDic setValue:@"0" forKey:@"dysmenorrhea"];
        
        
        [self judgePeriof:[ApplicationStyle datePickerTransformationCorss:[NSDate date]]];//判断今天的时间在不在经期内，在的话打开Switch开关
        _isCurrentDay = 0;  //是否是今天时间  默认是0 代表是 大于今天的时间 则是1
        [self bulidUI];
        
    }
    return self;
}
-(void)sleepDataQuery{
    
    
}
#pragma mark 基础UI
-(void)bulidUI{
    [self controlUI];
    
    
    NSString *years = [NSString stringWithFormat:@"%ld",(long)[ApplicationStyle whatYears:[NSDate date]]];
    NSString *month = nil;
    NSString *days = nil;
    if ((long)[ApplicationStyle whatMonths:[NSDate date]]>=10) {
        month = [NSString stringWithFormat:@"%ld",(long)[ApplicationStyle whatMonths:[NSDate date]]];
    }else{
        month = [NSString stringWithFormat:@"0%ld",(long)[ApplicationStyle whatMonths:[NSDate date]]];
    }
    if ((long)[ApplicationStyle whatDays:[NSDate date]]>=10) {
        days = [NSString stringWithFormat:@"%ld",(long)[ApplicationStyle whatDays:[NSDate date]]];
    }else{
        days = [NSString stringWithFormat:@"0%ld",(long)[ApplicationStyle whatDays:[NSDate date]]];
    }
    
    _selectedTime = [NSString stringWithFormat:@"%@-%@-%@",years,month,days];
    
    _mainScrollew = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.frame.size.height)];
    _mainScrollew.delegate = self;
    _mainScrollew.bounces = NO;
    [self addSubview:_mainScrollew];
    
    
    
    NLCalenderPackage *calenderView = [[NLCalenderPackage alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:598 + 30])];
    calenderView.delegate = self;
    [_mainScrollew addSubview:calenderView];
    
    
    {//经期时间
//        UIImageView *calenderback = [[UIImageView alloc] initWithFrame:CGRectMake(0, calenderView.bottomOffset , SCREENWIDTH, [ApplicationStyle control_height:100])];
//        calenderback.image = [UIImage imageNamed:@"NLBackCalender"];
//        [_mainScrollew addSubview:calenderback];
        
        
        UIView *calenderback = [[UIView alloc] initWithFrame:CGRectMake(0, calenderView.bottomOffset + [ApplicationStyle control_height:0], SCREENWIDTH, [ApplicationStyle control_height:120])];
        calenderback.backgroundColor = [@"fbf2d8" hexStringToColor];
        [_mainScrollew addSubview:calenderback];
        
        NSArray *periodArr = @[NSLocalizedString(@"NLHealthCalender_JQ", nil),
                               NSLocalizedString(@"NLHealthCalender_YCQ", nil),
                               NSLocalizedString(@"NLHealthCalender_AQQ", nil),
                               NSLocalizedString(@"NLHealthCalender_YYQ", nil),];
//        NSArray *periodColor = @[[@"ff7b47" hexStringToColor],
//                                 [@"ffad54" hexStringToColor],
//                                 [@"fee69a" hexStringToColor],
//                                 [@"ffdbe2" hexStringToColor],];
        
        
        NSArray *periodColor = @[[@"ff6c32" hexStringToColor],
                                 [@"ff9e34" hexStringToColor],
                                 [@"fcc20c" hexStringToColor],
                                 [@"ffa1b4" hexStringToColor],];
        
        NLHealtCalenderPeriod *periodView;
        for (NSInteger i = 0; i<periodArr.count; i++) {
            CGRect frame = CGRectMake([ApplicationStyle control_weight:52] + i * ((SCREENWIDTH - [ApplicationStyle control_weight:52])/4), [ApplicationStyle control_height:10], (SCREENWIDTH - [ApplicationStyle control_weight:52])/4, [ApplicationStyle control_height:20]);
            periodView = [[NLHealtCalenderPeriod alloc] initWithFrame:frame
                                                                                       color:periodColor[i]
                                                                                        text:periodArr[i]];
            [calenderback addSubview:periodView];
        }
        
        _periodTimeDay = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:52],
                                                                  [ApplicationStyle control_height:40] + ((calenderback.viewHeight - [ApplicationStyle control_height:40]) - [ApplicationStyle control_height:35])/2,
                                                                   SCREENWIDTH - [ApplicationStyle control_weight:100 * 2],
                                                                   [ApplicationStyle control_height:35])];
        
        _periodTimeDay.textColor = [@"e93a3a" hexStringToColor];
        _periodTimeDay.font = [UIFont    systemFontOfSize:[ApplicationStyle control_weight:30]];
        _periodTimeDay.text = [self periodOfTime];
        [calenderback addSubview:_periodTimeDay];
    }
    

    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, calenderView.bottomOffset + [ApplicationStyle control_height:120] + [ApplicationStyle control_height:2], SCREENWIDTH, [ApplicationStyle control_height:5*88]) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.scrollEnabled = NO;
    _mainTableView.backgroundColor = [UIColor clearColor];
    [_mainScrollew addSubview:_mainTableView];
    
    
    NSInteger tableHeight = 0;
    if (_switchOffNum == 1) {
        tableHeight = [ApplicationStyle control_height:5*88];
    }else{
        tableHeight = [ApplicationStyle control_height:4*88];
    }
    
    _mainScrollew.contentSize = CGSizeMake(SCREENWIDTH, [ApplicationStyle control_height:520] + [ApplicationStyle control_height:100] + tableHeight + [ApplicationStyle control_height:22] + [ApplicationStyle control_height:78] + [ApplicationStyle control_height:30]);
}
-(void)controlUI{
    
    _blackBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    _blackBack.backgroundColor = [UIColor blackColor];
    _blackBack.alpha = 0.5;
    _blackBack.hidden = YES;
    [[[UIApplication sharedApplication] keyWindow] addSubview:_blackBack];
    
    _calenderPickerView = [[NLCalenderPicker alloc] initWithFrame:CGRectMake(0, (SCREENHEIGHT - [ApplicationStyle control_height:500])/2, SCREENWIDTH, [ApplicationStyle control_height:500])];
    _calenderPickerView.delegate = self;
    _calenderPickerView.hidden = YES;
    [[[UIApplication sharedApplication] keyWindow] addSubview:_calenderPickerView];
    
    
     _calenLifeHabitView = [[NLCalenderLifeHabit alloc] initWithFrame:CGRectMake(0, (SCREENHEIGHT - [ApplicationStyle control_height:500])/2, SCREENWIDTH, [ApplicationStyle control_height:500])];
    _calenLifeHabitView.delegate = self;
    _calenLifeHabitView.hidden = YES;
    [[[UIApplication sharedApplication] keyWindow] addSubview:_calenLifeHabitView];
    
    _uncomfortableView = [[NLCalenderUncomfortable alloc] initWithFrame:CGRectMake(0, (SCREENHEIGHT - [ApplicationStyle control_height:660])/2, SCREENWIDTH, [ApplicationStyle control_height:660])];
    _uncomfortableView.delegate = self;
    _uncomfortableView.hidden = YES;
    [[[UIApplication sharedApplication] keyWindow] addSubview:_uncomfortableView];
}

#pragma mark 系统Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isCurrentDay == 0) {
        if (_switchOffNum == 1) {
            return 5;
        }else{
            return 4;
        }
    }else{
        
        return 0;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ApplicationStyle control_height:88];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"LYD";
    NLHealtCalenderCell *cell = [tableView   dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell = [[NLHealtCalenderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.tag = indexPath.row + CELLTAG;
    }
    NSArray *imageArr = nil;
    NSArray *labArr = nil;
    
    
    
    
    if (_switchOffNum == 1) {
        imageArr = @[@"NLHClen_DYM",
                     @"NLHClen_DYM_TJ",
                     @"NLHClen_AA",
                     @"NLHClen_SHXG",
                     @"NLHClen_BSF"];
        
        labArr = @[NSLocalizedString(@"NLHealthCalender_DYM", nil),
                   NSLocalizedString(@"NLHealthCalender_DYM_TJ", nil),
                   NSLocalizedString(@"NLHealthCalender_AA", nil),
                   NSLocalizedString(@"NLHealthCalender_SHXG", nil),
                   NSLocalizedString(@"NLHealthCalender_BSF", nil),];
        cell.switchs.on = true;
        if (indexPath.row == 0) {
            cell.switchs.hidden = NO;
            cell.cellCountLab.hidden = YES;
        }
        
        if (indexPath.row==1) {
            cell.cellCountLab.hidden = YES;
            CGFloat scroes = [[[NLSQLData canlenderDayData:_selectedTime] objectForKey:@"dysmenorrheaLevel"] floatValue];
            _starView = [[NLLHRatingView alloc] initWithFrame:CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:240] - [ApplicationStyle control_weight:24], ([ApplicationStyle control_height:88] - [ApplicationStyle control_height:40])/2, [ApplicationStyle control_weight:240], [ApplicationStyle control_height:40])];
            _starView.ratingType = INTEGER_TYPE;//整颗星
            _starView.clipsToBounds = YES;
            _starView.hidden = NO;
            _starView.delegate = self;
            _starView.score = scroes;
            [cell addSubview:_starView];
        }
    }else{
        _starView.hidden = YES;
        cell.cellCountLab.hidden = NO;
        cell.switchs.on = false;
        if (indexPath.row == 0) {
            cell.switchs.hidden = NO;
            cell.cellCountLab.hidden = YES;
        }
        imageArr = @[@"NLHClen_DYM",
                     @"NLHClen_AA",
                     @"NLHClen_SHXG",
                     @"NLHClen_BSF"];
        
        labArr = @[NSLocalizedString(@"NLHealthCalender_DYM", nil),
                   NSLocalizedString(@"NLHealthCalender_AA", nil),
                   NSLocalizedString(@"NLHealthCalender_SHXG", nil),
                   NSLocalizedString(@"NLHealthCalender_BSF", nil),];
        
        
    }
    
    cell.cellImage.image = [UIImage imageNamed:imageArr[indexPath.row]];
    cell.cellLab.text = labArr[indexPath.row];
    cell.cellCountLab.text = @"...";
    [cell.switchs addTarget:self action:@selector(switchOffDown:) forControlEvents:UIControlEventValueChanged];
    cell.backgroundColor = [@"fffdfd"  hexStringToColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_switchOffNum == 1) {
        switch (indexPath.row) {
            case 2:
            {
                _blackBack.hidden = NO;
                _calenderPickerView.hidden = NO;
                _cellRow = indexPath.row;
                break;
            }
            case 3:
            {
                _blackBack.hidden = NO;
                _calenLifeHabitView.hidden = NO;
                _cellRow = indexPath.row;
                _calenLifeHabitView.commonTime = _selectedTime;
                [_calenLifeHabitView buildUI];
                break;
            }
            case 4:
            {
                _blackBack.hidden = NO;
                _uncomfortableView.hidden = NO;
                _cellRow = indexPath.row;
                _uncomfortableView.commonTime = _selectedTime;
                [_uncomfortableView buildUI];
                break;
            }
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:{
                
                break;
            }
            case 1:{
                _blackBack.hidden = NO;
                _calenderPickerView.hidden = NO;
                _cellRow = indexPath.row;
                break;
            }
            case 2:{
                _blackBack.hidden = NO;
                _calenLifeHabitView.hidden = NO;
                _cellRow = indexPath.row;
                _calenLifeHabitView.commonTime = _selectedTime;
                [_calenLifeHabitView buildUI];
                
                break;
            }
            case 3:{
                _blackBack.hidden = NO;
                _uncomfortableView.hidden = NO;
                _cellRow = indexPath.row;
                _uncomfortableView.commonTime = _selectedTime;
                [_uncomfortableView buildUI];
                
                break;
            }
            default:
                break;
        }
    }
}
#pragma mark 自己的Delegate
-(void)returnCalenderTime:(NSString *)time{

    NSString *dayDate = [ApplicationStyle datePickerTransformationCorss:[NSDate date]];
    
    NSDate *dayTime = [ApplicationStyle dateTransformationStringWhiffletree:dayDate];
    NSDate *selectTime = [ApplicationStyle dateTransformationStringWhiffletree:time];
    
    NSInteger comperDate = [ApplicationStyle dateCompareDateCurrentDate:dayTime afferentDate:selectTime];
    
    if (comperDate<0) {
        [_starView removeFromSuperview];
        [_cartoonBackview removeFromSuperview];//删除下面卡通人物
        _isCurrentDay = 1;
        _mainTableView.hidden = YES;
        [_mainTableView reloadData];

       _mainScrollew.contentSize = CGSizeMake(SCREENWIDTH, [ApplicationStyle control_height:520] + [ApplicationStyle control_height:100] + [ApplicationStyle control_height:2] + [ApplicationStyle control_height:78] + [ApplicationStyle control_height:266]+ [ApplicationStyle control_height:30]);
        
        [self cartoon:[ApplicationStyle control_height:520] + [ApplicationStyle control_height:100] + [ApplicationStyle control_height:2] + [ApplicationStyle control_height:78] ];
        
        
    }else{
        
        [self judgePeriof:time];
        [_starView removeFromSuperview];
        [_cartoonBackview removeFromSuperview];//删除下面卡通人物
        _isCurrentDay = 0;
        _selectedTime = time;
        _mainTableView.hidden = NO;
        [_mainTableView reloadData];
        
        NSInteger tableHeight = 0;
        if (_switchOffNum == 1) {
            tableHeight = [ApplicationStyle control_height:5*88];
        }else{
            tableHeight = [ApplicationStyle control_height:4*88];
        }
        _mainScrollew.contentSize = CGSizeMake(SCREENWIDTH, [ApplicationStyle control_height:520] + [ApplicationStyle control_height:100] + tableHeight + [ApplicationStyle control_height:22] + [ApplicationStyle control_height:78]+ [ApplicationStyle control_height:30]);
    }
}
//爱爱代理
-(void)pickerIndex:(NSInteger)index{
    [self hideBack];
    NLHealtCalenderCell *cell = (NLHealtCalenderCell *)[self viewWithTag:_cellRow+CELLTAG];
    switch (index) {
        case PlayLove_MYZ:
        {
            cell.cellCountLab.text = NSLocalizedString(@"NLHealthCalender_Picker_MYZ", nil);
            break;
        }
        case PlayLove_DTZ:
        {
            cell.cellCountLab.text = NSLocalizedString(@"NLHealthCalender_Picker_DTZ", nil);
            break;
        }
        case PlayLove_CLYSH:
        {
            cell.cellCountLab.text = NSLocalizedString(@"NLHealthCalender_Picker_CLSHY", nil);
            break;
        }
        case PlayLove_WBHCS:
        {
            cell.cellCountLab.text = NSLocalizedString(@"NLHealthCalender_Picker_WBHCS", nil);
            break;
        }
        case PlayLove_QC:
        {
            cell.cellCountLab.text = @"...";
            break;
        }
        default:
            break;
    }
    NSDictionary *dataDic = @{@"loveLove":[NSString stringWithFormat:@"%ld",(long)index],@"time":_selectedTime};
    [NLSQLData upDataCanlenderLoveLove:dataDic];
    
}
//生活习惯
-(void)lifeHabitCount:(NSArray *)array{
    
   
    
    [self hideBack];
    NSDictionary *dataDic = nil;
    if (array==nil) {
        dataDic = @{@"habitsAndCustoms":CommonText_Canlender_habitsAndCustoms,@"time":_selectedTime};
        [_canledarDataDic setValue:CommonText_Canlender_habitsAndCustoms forKey:@"lifeHabit"];
    }else{
        dataDic = @{@"habitsAndCustoms":[self countString:array]==nil?@"":[self countString:array],@"time":_selectedTime};
        [_canledarDataDic setValue:[self countString:array] forKey:@"lifeHabit"];
    }
    [_canledarDataDic setValue:_selectedTime forKey:@"currentDate"];
    [NLSQLData upDataCanlenderhabitsAndCustoms:dataDic];
    [[NLDatahub sharedInstance] calendarUpLoadDataDic:_canledarDataDic];
    
    NLHealtCalenderCell *cell = (NLHealtCalenderCell *)[self viewWithTag:_cellRow+CELLTAG];
    cell.cellCountLab.text = [self canledarStrHandle:array];
    
}
//不舒服
-(void)uncomfortableArr:(NSArray *)array{
    
    [self hideBack];
    NSDictionary *dataDic = nil;
    if (array == nil) {
        dataDic = @{@"uncomfortable":CommonText_Canlender_uncomfortable,@"time":_selectedTime};
        [_canledarDataDic setValue:CommonText_Canlender_uncomfortable forKey:@"uncomfortable"];
    }else{
        dataDic = @{@"uncomfortable":[self countString:array]==nil?@"":[self countString:array],@"time":_selectedTime};
        [_canledarDataDic setValue:[self countString:array] forKey:@"uncomfortable"];
    }
    [_canledarDataDic setValue:_selectedTime forKey:@"currentDate"];
    [NLSQLData upDataCanlenderuncomfortable:dataDic];
    [[NLDatahub sharedInstance] calendarUpLoadDataDic:_canledarDataDic];
    
    NLHealtCalenderCell *cell = (NLHealtCalenderCell *)[self viewWithTag:_cellRow+CELLTAG];
    cell.cellCountLab.text = [self canledarStrHandle:array];
}

#pragma mark - 星星代理
- (void)ratingView:(NLLHRatingView *)view score:(CGFloat)score
{
    NSDictionary *dataDic = @{@"dysmenorrheaLevel":[NSString stringWithFormat:@"%0.0f",score],@"time":_selectedTime};
    [NLSQLData upDataCanlenderDysmenorrheaLevel:dataDic];
}
//字符拼接
-(NSMutableString *)countString:(NSArray *)array{
    NSMutableString *count = [NSMutableString string];
    for (NSInteger i=0; i<array.count; i++) {
        if (i==array.count-1) {
            [count appendFormat:@"%@",array[i]];
        }else{
            [count appendFormat:@"%@.",array[i]];
        }
    }
    return count;
}
-(NSMutableString *)canledarStrHandle:(NSArray *)arr{
    NSMutableString *count = [NSMutableString string];
    
    NSMutableArray *arrayStr = [NSMutableArray array];
    for (NSString *str in arr) {
        if (![str isEqualToString:@"0"]) {
            [arrayStr addObject:str];
        }
    }
    for (NSInteger i=0; i<arrayStr.count; i++) {
        if (i==arrayStr.count-1) {
            [count appendFormat:@"%@",arrayStr[i]];
        }else{
            [count appendFormat:@"%@.",arrayStr[i]];
        }
    }
    return count;
}
#pragma mark 隐藏
-(void)hideBack{
    _blackBack.hidden = YES;
    _calenLifeHabitView.hidden = YES;
    _uncomfortableView.hidden = YES;
    _calenderPickerView.hidden = YES;
}
#pragma 自己按钮事件
-(void)switchOffDown:(UISwitch *)sw{
    if (sw.on == YES) {
        _switchOffNum = 1;
    }else{
        _switchOffNum = 0;
    }
    
    
    
    
    
    
    NSInteger tableHeight = 0;
    if (_switchOffNum == 1) {
        tableHeight = [ApplicationStyle control_height:5*88];
    }else{
        tableHeight = [ApplicationStyle control_height:4*88];
    }
    _mainScrollew.contentSize = CGSizeMake(SCREENWIDTH, [ApplicationStyle control_height:520] + [ApplicationStyle control_height:100] + tableHeight + [ApplicationStyle control_height:22] + [ApplicationStyle control_height:78]+ [ApplicationStyle control_height:30]);
    [_mainTableView reloadData];
}


-(NSString *)periodOfTime{
    NSDate *date = [NSDate date];
    NSDate *lastTimepPeriod = [ApplicationStyle dateTransformationStringWhiffletree:[kAPPDELEGATE._loacluserinfo getLastTimeGoPeriodDate]];//获得上一次来的时间
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//     NSDate *lastTimepPeriod = [dateFormatter dateFromString:@"2016-02-29"];
    
    
    
    
    switch ([ApplicationStyle dateCompareDateCurrentDate:date afferentDate:lastTimepPeriod]) {
        case  0:{
            return @"你的月经来了";
            break;
        }
        case  1:{
            NSDictionary *dataDic = [PlistData getIndividuaData];//获得用户数据
            NSInteger periodTime = [[dataDic objectForKey:@"periodTime"] integerValue];//获得经期
            
            if ([ApplicationStyle dateInteverCurrentDate:date afferentDate:lastTimepPeriod]<=periodTime) {
                NSInteger minDay = [ApplicationStyle dateInteverCurrentDate:date afferentDate:lastTimepPeriod];
                return [NSString stringWithFormat:@"你已经来了第%ld天",(long)minDay];
            }else{
                
                NSInteger cycle = [[dataDic objectForKey:@"cycleTime"] integerValue];//获得周期
                NSInteger maxDay = [ApplicationStyle dateInteverCurrentDate:date afferentDate:lastTimepPeriod];
                NSDate *d = [NSDate dateWithTimeIntervalSinceNow: (cycle - maxDay) * (3600 * 24)];
                return [NSString stringWithFormat:@"距离经期来临还有%ld天",labs([ApplicationStyle dateInteverCurrentDate:date afferentDate:d])];
            }
            break;
        }
        default:
            break;
    }
    return nil;
//    NSDate *d = [NSDate dateWithTimeIntervalSinceNow: 26 * (3600 * 24)];
}

//卡通人物
-(void)cartoon:(CGFloat)floats{
    _cartoonBackview = [[UIView alloc] initWithFrame:CGRectMake(0, floats, SCREENWIDTH, [ApplicationStyle control_height:266])];
    _cartoonBackview.backgroundColor = [UIColor whiteColor];
    [_mainScrollew addSubview:_cartoonBackview];
    

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:96], [ApplicationStyle control_height:54 ], [ApplicationStyle control_weight:114], [ApplicationStyle control_height:160])];
    imageView.image = [UIImage imageNamed:@"NLHClen_Cartoon"];
    [_cartoonBackview addSubview:imageView];
    
    UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake(imageView.rightSideOffset + [ApplicationStyle control_weight:24], [ApplicationStyle control_height:54+28], SCREENWIDTH - [ApplicationStyle control_weight:96*2 + 114 + 24], [ApplicationStyle control_height:30])];
    countLab.text = NSLocalizedString(@"NLHealthCalender_CartoonText", nil);
    countLab.font = [ApplicationStyle textThrityFont];
    countLab.textColor = [@"535353" hexStringToColor];
    [_cartoonBackview addSubview:countLab];
    
    UIButton *countBtn = [UIButton  buttonWithType:UIButtonTypeRoundedRect];
    countBtn.frame = CGRectMake(imageView.rightSideOffset +[ApplicationStyle control_weight:80], countLab.bottomOffset + [ApplicationStyle control_height:24], [ApplicationStyle control_weight:200], [ApplicationStyle control_height:60]);
    [countBtn setTitle:NSLocalizedString(@"NLHealthCalender_GoDay", nil) forState:UIControlStateNormal];
    countBtn.titleLabel.font = [ApplicationStyle textThrityFont];
    [countBtn setTitleColor:[@"ffffff" hexStringToColor] forState:UIControlStateNormal];
    countBtn.layer.cornerRadius = [ApplicationStyle control_weight:10];
    countBtn.backgroundColor = [@"fe6987" hexStringToColor];
    [countBtn addTarget:self action:@selector(cartoonBtn) forControlEvents:UIControlEventTouchUpInside];
    [_cartoonBackview addSubview:countBtn];
}
//判断经期
-(void)judgePeriof:(NSString *)time{
    NSDate *lastTimepPeriod = [ApplicationStyle dateTransformationStringWhiffletree:[kAPPDELEGATE._loacluserinfo getLastTimeGoPeriodDate]];//获得上一次来的时间
    NSDictionary *dataDic = [PlistData getIndividuaData];//获得用户数据
    NSInteger cycle = [[dataDic objectForKey:@"cycleTime"] integerValue];//获得周期
    NSInteger periodTime = [[dataDic objectForKey:@"periodTime"] integerValue];//获得经期
    
    for (NSInteger j=0; j<6; j++) {
        for (NSInteger z=0; z<periodTime; z++) {
            NSString *ycq = [ApplicationStyle datePickerTransformationCorss:[lastTimepPeriod dateByAddingTimeInterval:((60 * 60 * 24) * cycle * j) + (z * (3600 * 24))]];//每次的预测期     预测的时间+每次来的经期次数，如果相等说明在经期内
            
            if ([time isEqualToString:ycq]) {
                _switchOffNum = 1;
                return;
            }else{
                _switchOffNum = 0;
            }
        }
    }
}

-(void)cartoonBtn{
    [[NSNotificationCenter defaultCenter] postNotificationName:CalenderGoBackToDayNotification object:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
