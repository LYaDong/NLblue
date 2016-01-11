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
@interface NLHealthCalenderView()<
UIScrollViewDelegate,
UITableViewDataSource,
UITableViewDelegate,
NLCalenderPickerDelegate,
NLCalenderLifeHabitDelegate,
NLCalenderUncomfortableDelegate,
NLCalenderPackageDelegate>
@property(nonatomic,strong)NSString *selectedTime;
@property(nonatomic,strong)UIScrollView *mainScrollew;
@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)UILabel *periodTimeDay;
@property(nonatomic,strong)UIView *blackBack;
@property(nonatomic,strong)NLCalenderPicker *calenderPickerView;
@property(nonatomic,strong)NLCalenderLifeHabit *calenLifeHabitView;
@property(nonatomic,strong)NLCalenderUncomfortable *uncomfortableView;
@property(nonatomic,assign)NSInteger cellRow;

@end
@implementation NLHealthCalenderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor yellowColor];
        [self bulidUI];
    }
    return self;
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
    
    
    
    NLCalenderPackage *calenderView = [[NLCalenderPackage alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:598])];
    calenderView.delegate = self;
    [_mainScrollew addSubview:calenderView];
    
    
    {//经期时间
        UIImageView *calenderback = [[UIImageView alloc] initWithFrame:CGRectMake(0, calenderView.bottomOffset , SCREENWIDTH, [ApplicationStyle control_height:100])];
        calenderback.image = [UIImage imageNamed:@"NLBackCalender"];
        [_mainScrollew addSubview:calenderback];
        
        NSArray *periodArr = @[NSLocalizedString(@"NLHealthCalender_JQ", nil),
                               NSLocalizedString(@"NLHealthCalender_YCQ", nil),
                               NSLocalizedString(@"NLHealthCalender_AQQ", nil),
                               NSLocalizedString(@"NLHealthCalender_YYQ", nil),];
        NSArray *periodColor = @[[@"ff6c32" hexStringToColor],
                                 [@"ffad54" hexStringToColor],
                                 [@"fee39a" hexStringToColor],
                                 [@"ffe9ed" hexStringToColor],];
        
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
        
        _periodTimeDay.textColor = [ApplicationStyle subjectWithColor];
        _periodTimeDay.font = [UIFont    systemFontOfSize:[ApplicationStyle control_weight:28]];
        _periodTimeDay.text = @"距离下次来临大约还有15天";
        [calenderback addSubview:_periodTimeDay];
    }
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, calenderView.bottomOffset + [ApplicationStyle control_height:100] + [ApplicationStyle control_height:2 ], SCREENWIDTH, [ApplicationStyle control_height:4 * 88]) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.backgroundColor = [UIColor clearColor];
    [_mainScrollew addSubview:_mainTableView];
    
    
    _mainScrollew.contentSize = CGSizeMake(SCREENWIDTH, [ApplicationStyle control_height:520] + [ApplicationStyle control_height:100] + [ApplicationStyle control_height:4 * 88] + [ApplicationStyle control_height:2] + [ApplicationStyle control_height:78]);
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
    return 4;
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
    
    
    NSArray *imageArr = @[@"NLHClen_DYM",
                          @"NLHClen_AA",
                          @"NLHClen_SHXG",
                          @"NLHClen_BSF"];
    
    NSArray *labArr = @[NSLocalizedString(@"NLHealthCalender_DYM", nil),
                        NSLocalizedString(@"NLHealthCalender_AA", nil),
                        NSLocalizedString(@"NLHealthCalender_SHXG", nil),
                        NSLocalizedString(@"NLHealthCalender_BSF", nil),];
    cell.cellImage.image = [UIImage imageNamed:imageArr[indexPath.row]];
    cell.cellLab.text = labArr[indexPath.row];
    cell.cellCountImage.image = [UIImage imageNamed:@"NLHClen_DDD"];
    if (indexPath.row==0) {
        cell.cellCountImage.image = [UIImage imageNamed:@"NLHClen_DYM_NO"];
    }

    cell.backgroundColor = [UIColor  clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            
            break;
        }
        case 1:
        {
            _blackBack.hidden = NO;
            _calenderPickerView.hidden = NO;
            _cellRow = indexPath.row;
            break;
        }
        case 2:
        {
            _blackBack.hidden = NO;
            _calenLifeHabitView.hidden = NO;
            
            _calenLifeHabitView.commonTime = _selectedTime;
            [_calenLifeHabitView buildUI];
            
            break;
        }
        case 3:
        {
            _blackBack.hidden = NO;
            _uncomfortableView.hidden = NO;
            _uncomfortableView.commonTime = _selectedTime;
            [_uncomfortableView buildUI];
            
            break;
        }
        default:
            break;
    }
    
}
#pragma mark 自己的Delegate
-(void)returnCalenderTime:(NSString *)time{
    _selectedTime = time;
}
//爱爱代理
-(void)pickerIndex:(NSInteger)index{
    [self hideBack];
    NLHealtCalenderCell *cell = (NLHealtCalenderCell *)[self viewWithTag:_cellRow+CELLTAG];
    switch (index) {
        case PlayLove_MYZ:
        {
            cell.cellCountImage.image = [UIImage imageNamed:@"NLHClen_AA_XX"];
            break;
        }
        case PlayLove_DTZ:
        {
            cell.cellCountImage.image = [UIImage imageNamed:@"NLHClen_AA_TT"];
            break;
        }
        case PlayLove_CLYSH:
        {
            cell.cellCountImage.image = [UIImage imageNamed:@"NLHClen_AA_YY"];
            break;
        }
        case PlayLove_WBHCS:
        {
            cell.cellCountImage.image = [UIImage imageNamed:@"NLHClen_AA_N_TT"];
            break;
        }
        case PlayLove_QC:
        {
            cell.cellCountImage.image = [UIImage imageNamed:@"NLHClen_DDD"];
            break;
        }
        default:
            break;
    }
    NSDictionary *dataDic = @{@"loveLove":[NSString stringWithFormat:@"%ld",index],@"time":_selectedTime};
    [NLSQLData upDataCanlenderLoveLove:dataDic];
    
}
//生活习惯
-(void)lifeHabitCount:(NSArray *)array{
    [self hideBack];
    NSDictionary *dataDic = nil;
    if (array==nil) {
        dataDic = @{@"habitsAndCustoms":CommonText_Canlender_habitsAndCustoms,@"time":_selectedTime};
    }else{
        dataDic = @{@"habitsAndCustoms":[self countString:array]==nil?@"":[self countString:array],@"time":_selectedTime};
    }
    [NLSQLData upDataCanlenderhabitsAndCustoms:dataDic];
}
//不舒服
-(void)uncomfortableArr:(NSArray *)array{
    
    [self hideBack];
    NSDictionary *dataDic = nil;
    if (array == nil) {
        dataDic = @{@"uncomfortable":CommonText_Canlender_uncomfortable,@"time":_selectedTime};
    }else{
        dataDic = @{@"uncomfortable":[self countString:array]==nil?@"":[self countString:array],@"time":_selectedTime};
    }
    [NLSQLData upDataCanlenderuncomfortable:dataDic];
}

-(NSMutableString *)countString:(NSArray *)array{
    NSMutableString *count = [NSMutableString string];
    for (NSInteger i=0; i<array.count; i++) {
        if (i==array.count-1) {
            [count appendFormat:@"%@",array[i]];
        }else{
            [count appendFormat:@"%@-",array[i]];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
