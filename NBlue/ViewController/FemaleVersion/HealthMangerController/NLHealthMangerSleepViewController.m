//
//  NLHealthMangerSleepViewController.m
//  NBlue
//
//  Created by LYD on 15/12/2.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLHealthMangerSleepViewController.h"
#import "LYDSetSegmentControl.h"
#import "LYDSegmentControl.h"
#import "NLStepCountLabView.h"
#import "NLSQLData.h"
#import "NLColumnImage.h"
@interface NLHealthMangerSleepViewController ()<LYDSetSegmentDelegate,NLColumnImageDelegate>
@property(nonatomic,strong)UIView *labViewBack;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)CGFloat convenImageWeight;
@property(nonatomic,strong)NLColumnImage *column;
@property(nonatomic,assign)NSInteger weekMonthCount;
@property(nonatomic,strong)UIImageView *imageArrow;
@end

@implementation NLHealthMangerSleepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [NSMutableArray array];
    [self bulidUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark 基础UI
-(void)bulidUI{
    CGRect frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:360])/2, [ApplicationStyle statusBarSize] + ([ApplicationStyle navigationBarSize] - [ApplicationStyle control_height:60])/2, [ApplicationStyle control_weight:360], [ApplicationStyle control_height:60]);
    NSArray * items = @[NSLocalizedString(@"NLHealthManger_StepDay", nil),
                        NSLocalizedString(@"NLHealthManger_StepWeek", nil),
                        NSLocalizedString(@"NLHealthManger_StepMonth", nil)];
    
    LYDSetSegmentControl *segement = [LYDSetSegmentControl shareInstance];
    segement.titleArray = items;
    segement.cornerRedius = 15;
    segement.borderWidth = 1;
    segement.selectedSegmentIndex = 0;
    segement.borderColors = [UIColor whiteColor];
    segement.clipsBounds = YES;
    segement.backGroupColor = [ApplicationStyle subjectShowAllPinkColor];
    segement.titleColor = [UIColor  whiteColor];
    segement.titleFont = [ApplicationStyle textSuperSmallFont];
    segement.lineHide = YES;
    
    LYDSegmentControl *sele = [[LYDSegmentControl alloc] initWithSetSegment:segement frame:frame];
    sele.delegate = self;
    [self.view addSubview:sele];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        NSMutableArray *arrs = [NLSQLData sleepDataObtain];
        NSLog(@"%@",[self sortArrayData:arrs]);
        
        [_dataArr removeAllObjects];
        [_dataArr addObjectsFromArray:arrs];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self imageConvenDataArr:_dataArr type:NLCalendarType_Day];
        });
    });
    
    
    UIView *viewTimeBack = [[UIView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle control_height:480] + [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize], SCREENWIDTH, [ApplicationStyle control_height:60])];
    viewTimeBack.backgroundColor = [ApplicationStyle subjectWithColor];
    viewTimeBack.alpha = 0.1;
    [self.view addSubview:viewTimeBack];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, viewTimeBack.bottomOffset, SCREENWIDTH, [ApplicationStyle control_height:1])];
    line.backgroundColor = [ApplicationStyle subjectWithColor];
    [self.view addSubview:line];
    
    
    _imageArrow = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:28])/2, [ApplicationStyle control_height:480] + [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize] - [ApplicationStyle control_weight:14], [ApplicationStyle control_weight:28], [ApplicationStyle control_weight:14])];
    _imageArrow.image = [UIImage imageNamed:@"NL_Step_Arrow"];
    [[[UIApplication sharedApplication] keyWindow] addSubview:_imageArrow];
    
    
    NSArray *dataLabArr = @[@"23:08",@"07:26",@"07:26",@"3h15m",@"2h15m",@"良"];
    [self stepAndColAndTime:dataLabArr];
    
}
#pragma mark 系统Delegate
#pragma mark 自己的Delegate
- (void)segmentedIndex:(NSInteger)index{
    [_column removeFromSuperview];
    switch (index) {
        case NLCalendarType_Day:
        {
            [self imageConvenDataArr:_dataArr type:NLCalendarType_Day];
            break;
        }
        case NLCalendarType_Week:
        {
            _weekMonthCount = 7;
            [self imageConvenDataArr:[self dataThreeData:_dataArr] type:NLCalendarType_Week];
            break;
        }
        case NLCalendarType_Month:
        {
            _weekMonthCount = 30;
            [self imageConvenDataArr:[self dataThreeData:_dataArr] type:NLCalendarType_Month];
            break;
        }
        default:
            break;
    }
}
-(void)stepAndColAndTime:(NSArray *)arr{
    _labViewBack = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - [ApplicationStyle control_height:492], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle control_height:492])];
    _labViewBack.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_labViewBack];
    
    NSArray *remarkLabText = @[NSLocalizedString(@"NLHealthMangerSleep_FallAsleepTime", nil),
                               NSLocalizedString(@"NLHealthMangerSleep_WakeupTime", nil),
                               NSLocalizedString(@"NLHealthMangerSleep_SleepTime", nil),
                               NSLocalizedString(@"NLHealthMangerSleep_ShallowSleepTime", nil),
                               NSLocalizedString(@"NLHealthMangerSleep_DeepSleepTime", nil),
                               NSLocalizedString(@"NLHealthMangerSleep_SleepQualityTime", nil),];
    for (NSInteger i=0; i<arr.count; i++) {
        CGFloat  x = 0+i % 3 * SCREENWIDTH/3,
        y = [ApplicationStyle control_height:40] + i / 3 * [ApplicationStyle control_height:120],
        w = SCREENWIDTH/3,
        h = [ApplicationStyle control_height:115];
        
        CGRect frams = CGRectMake(x, y, w, h);
        NLStepCountLabView *view = [[NLStepCountLabView alloc] initWithFrame:frams type:0 remarkLabText:remarkLabText[i] dataLabText:arr[i]];
        [_labViewBack addSubview:view];
    }
    
}

-(void)sildeIndex:(NSInteger)index{}
#pragma mark 自己的按钮事件

-(void)imageConvenDataArr:(NSArray *)arr type:(NSInteger)type{
    
    switch (type) {
        case NLCalendarType_Day:
        {
            _convenImageWeight = [ApplicationStyle control_weight:50];
            break;
        }
        case NLCalendarType_Week:
        {
            _convenImageWeight = [ApplicationStyle control_weight:90];
            break;
        }
        case NLCalendarType_Month:
        {
            _convenImageWeight = [ApplicationStyle control_weight:120];
            break;
        }
        default:
            break;
    }
    
    CGRect frame = CGRectMake(0, [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize], SCREENWIDTH, [ApplicationStyle control_height:540]);
    _column = [[NLColumnImage alloc] initWithFrame:frame DataArr:arr strokeColor:[@"882a00" hexStringToColor] withColor:[@"fac96f" hexStringToColor] type:type timeLabArr:nil dataType:NLDataExhibitionType_Sleep];
    _column.delegate = self;
    [self.view addSubview:_column];
    
}
#pragma mark 排序

- (NSMutableArray *)sortArrayData:(NSMutableArray *)arr{
    
    NSLog(@"%@",arr);
    
    for (NSInteger i = 0; i<arr.count; i++) {
        for (NSInteger j=i+1; j<arr.count; j++) {
            
            int aa = [[arr[i] objectForKey:@"timestamp"] intValue];
            int bb = [[arr[j] objectForKey:@"timestamp"] intValue];
            NSArray *one = arr[i];
            NSArray *tow = arr[j];
            
            if (aa<bb) {
                [arr replaceObjectAtIndex:i withObject:tow];
                [arr replaceObjectAtIndex:j withObject:one];
            }
        }
    }
    
    return arr;
}
#pragma mark 返回7天的数据或者一个月内的数据
-(NSArray *)dataThreeData:(NSMutableArray *)data{
    NSLog(@"%@",data);
    NSMutableArray *arrData = [self sortArrayData:data];
    
    NSInteger dayInt = 0;
    //取出第一条数据，判断是星期几，推断第一个循环
    NSInteger countS = 0;//总累计数的和
    
    NSDate  *currTime = [ApplicationStyle dateTransformationStringWhiffletree:[arrData[0] objectForKey:@"sleepDate"]];
    
    if (_weekMonthCount == 7) {
        countS = [ApplicationStyle currentDayWeek:currTime] - 1;
    }else{
        //        countS =  [ApplicationStyle totalDaysInMonth:currTime] - ([ApplicationStyle totalDaysInMonth:currTime] - [ApplicationStyle whatDays:currTime]);
        countS  = [ApplicationStyle whatDays:currTime];
    }
    
    //放数据的数组
    NSMutableArray *dataGather = [NSMutableArray array];
    
    if (_weekMonthCount ==0) {
        if (countS == 0) {
            countS = _weekMonthCount;
        }
    }
    
    //累加值
    NSInteger nums = 0;
    //每7天加一次数据/或者30天加一次数据
    NSInteger sportCount = 0;
    NSString *dateTime = nil;
__goto:
    dateTime = [arrData[nums] objectForKey:@"sleepDate"];
    
    if (countS>arrData.count) {
        
    }else{
        for (NSInteger i=nums; i<countS; i++) {
            //每7天加一次数据/或者30天加一次数据
            sportCount =  sportCount + [[arrData[i] objectForKey:@"deepSleep_mins"] integerValue];
        }
    }
    
    NSLog(@"%@",dateTime);
    //添加到数组
    NSDictionary *dic = @{@"deepSleep_mins":[NSNumber numberWithInteger:sportCount],@"sleepDate":dateTime};
    [dataGather addObject:dic];
    dayInt  = dayInt - 1;
    if (_weekMonthCount == 7) {
        nums =  countS;
    }else{
        nums = countS;
    }
    if (nums<=arrData.count) {
        if (_weekMonthCount == 7) {
            countS = countS + _weekMonthCount;
        }else{
            countS = countS + [ApplicationStyle totalDaysInMonth:[ApplicationStyle whatMonth:[NSDate date] timeDay:dayInt]];
        }
    }
    //判断是不是大于总数，如果没有继续算，如果大于则返回数组
    if (nums >=arrData.count) {
        return dataGather;
    }else{
        sportCount = 0;
        goto __goto;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
