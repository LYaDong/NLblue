//
//  NLHealthMangerStepNumViewController.m
//  NBlue
//
//  Created by LYD on 15/12/2.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLHealthMangerStepNumViewController.h"
#import "LYDSetSegmentControl.h"
#import "LYDSegmentControl.h"
#import "NLColumnImage.h"
#import "NLStepCountLabView.h"
#import "NLSQLData.h"
@interface NLHealthMangerStepNumViewController ()<LYDSetSegmentDelegate,UIScrollViewDelegate,NLColumnImageDelegate>
@property(nonatomic,strong)UIScrollView *mainScrollew;
@property(nonatomic,strong)NLColumnImage *column;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)CGFloat convenImageWeight;
@property(nonatomic,strong)UIView *labViewBack;
@property(nonatomic,assign)NSInteger weekMonthCount;
@property(nonatomic,strong)UIImageView *imageArrow;

@end

@implementation NLHealthMangerStepNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArr = [NSMutableArray array];
    _weekMonthCount = 1;
    [self bulidUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _imageArrow.hidden = YES;
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
    segement.backGroupColor = [@"f3375a" hexStringToColor];
    segement.titleColor = [UIColor  whiteColor];
    segement.titleFont = [ApplicationStyle textSuperSmallFont];
    segement.lineHide = YES;
    
    LYDSegmentControl *sele = [[LYDSegmentControl alloc] initWithSetSegment:segement frame:frame];
    sele.delegate = self;
    [self.view addSubview:sele];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        _dataArr = [NLSQLData obtainSportDataBig];

       dispatch_async(dispatch_get_main_queue(), ^{
           [self imageConvenDataArr:_dataArr type:NLCalendarType_Day];
           
           NSMutableArray *arrDatas = [self sortArrayData:_dataArr];
           NSString *stepsAmount = [[arrDatas[0] objectForKey:@"stepsAmount"] length]==0?@"0":[arrDatas[0] objectForKey:@"stepsAmount"];
           NSString *distanceAmount = [[arrDatas[0] objectForKey:@"distanceAmount"] length]==0?@"0":[arrDatas[0] objectForKey:@"distanceAmount"];
           NSString *caloriesAmount = [[arrDatas[0] objectForKey:@"caloriesAmount"] length]==0l?@"0":[arrDatas[0] objectForKey:@"caloriesAmount"];
           NSString *timestamp = [[arrDatas[0] objectForKey:@"totalTimeCount"] length]==0?@"0":[arrDatas[0] objectForKey:@"totalTimeCount"];
           
           NSArray *dataLabArr = @[stepsAmount,distanceAmount,caloriesAmount,timestamp];
           NSArray *remarkLabText = @[NSLocalizedString(@"NLHealthManger_StepRemarkLab", nil),
                                      NSLocalizedString(@"NLHealthManger_StepDistance", nil),
                                      NSLocalizedString(@"NLHealthManger_StepEnergy", nil),
                                      NSLocalizedString(@"NLHealthManger_StepActovity", nil),];

           [self stepAndColAndTime:dataLabArr remarkLabText:remarkLabText];
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
    
    
    
    
    
    
}

#pragma mark 系统Delegate
#pragma mark 自己的Delegate

-(void)segmentedIndex:(NSInteger)index{
    
    [_column removeFromSuperview];
    switch (index) {
        case NLCalendarType_Day:
        {
            _weekMonthCount = 1;
            
            
            [self sildeIndex:[self dataThreeData:_dataArr][0]];
            [self imageConvenDataArr:_dataArr type:NLCalendarType_Day];
            
            
            break;
        }
        case NLCalendarType_Week:
        {
            
            _weekMonthCount = 7;
            [self sildeIndex:[self dataThreeData:_dataArr][0]];
            
            [self imageConvenDataArr:[self dataThreeData:_dataArr] type:NLCalendarType_Week];
            
            break;
        }
        case NLCalendarType_Month:
        {
            
            _weekMonthCount = 30;
            
            NSLog(@"%@",[self dataThreeData:_dataArr]);
            
            
            [self sildeIndex:[self dataThreeData:_dataArr][0]];
            [self imageConvenDataArr:[self dataThreeData:_dataArr] type:NLCalendarType_Month];
            
//            NSMutableArray *arrs = [NSMutableArray array];
//            for (NSInteger i=0; i<1; i++) {
//                NSInteger num = arc4random()%150;
//                [arrs addObject:[NSNumber numberWithInteger:num]];
//            }
//            [_dataArr addObjectsFromArray:arrs];
//            [self imageConvenDataArr:arrs type:NLCalendarType_Month];
            break;
        }
        default:
            break;
    }
}


-(void)stepAndColAndTime:(NSArray *)arr remarkLabText:(NSArray *)remarkLabText{
    

    
    _labViewBack = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - [ApplicationStyle control_height:492], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle control_height:492])];
    _labViewBack.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_labViewBack];
    
//    NSArray *remarkLabText = @[NSLocalizedString(@"NLHealthManger_StepRemarkLab", nil),
//                               NSLocalizedString(@"NLHealthManger_StepDistance", nil),
//                               NSLocalizedString(@"NLHealthManger_StepEnergy", nil),
//                               NSLocalizedString(@"NLHealthManger_StepActovity", nil),];
//    NSArray *dataLabArr = @[@"300",@"30千米",@"8千卡",@"00小时15分钟"];
    NSArray *typeLab = @[[NSNumber numberWithInteger:LabTextType_DayStepNum],
                         [NSNumber numberWithInteger:LabTextType_DayDistance],
                         [NSNumber numberWithInteger:LabTextType_DayEnergy],
                         [NSNumber numberWithInteger:LabTextType_DayActovity]];
    
    
    
    for (NSInteger i=0; i<arr.count; i++) {
        NSInteger x = 0 + i % 2 * SCREENWIDTH/2,
        y = [ApplicationStyle control_height:40] + i / 2 * [ApplicationStyle control_height:115],
        w = SCREENWIDTH/2,
        h = [ApplicationStyle control_height:115];
        
        CGRect frames = CGRectMake(x, y, w, h);
        
        NSInteger type = [[NSString stringWithFormat:@"%@",typeLab[i]] integerValue];
        
        NLStepCountLabView *labView = [[NLStepCountLabView alloc] initWithFrame:frames
                                                                           type:type
                                                                  remarkLabText:remarkLabText[i]
                                                                    dataLabText:arr[i]];
        [_labViewBack addSubview:labView];
    }
}

-(void)sildeIndex:(NSDictionary *)index{
    [_labViewBack removeFromSuperview];
    
    
    NSLog(@"%@",index);
    
    
    NSString *stepsAmount = [index objectForKey:@"stepsAmount"]==nil?@"0":[index objectForKey:@"stepsAmount"];
    NSString *distanceAmount = [index objectForKey:@"distanceAmount"]==nil?@"0":[index objectForKey:@"distanceAmount"];
    NSString *caloriesAmount = [index objectForKey:@"caloriesAmount"]==nil?@"0":[index objectForKey:@"caloriesAmount"];
    NSString *totalTimeCount = [index objectForKey:@"totalTimeCount"]==nil?@"0":[index objectForKey:@"totalTimeCount"];

    NSArray *dataLabArr = @[[NSString stringWithFormat:@"%ld",[stepsAmount integerValue]/_weekMonthCount],
                            [NSString stringWithFormat:@"%ld",[distanceAmount integerValue]/_weekMonthCount],
                            [NSString stringWithFormat:@"%ld",[caloriesAmount integerValue]/_weekMonthCount],
                            [NSString stringWithFormat:@"%ld",[totalTimeCount integerValue]/60/_weekMonthCount]];
    
    NSArray *remarkLabText = nil;

    
    if (_weekMonthCount == 7 || _weekMonthCount == 30) {
        remarkLabText = @[NSLocalizedString(@"NLHealthManger_StepRemarkLab_average", nil),
                          NSLocalizedString(@"NLHealthManger_StepDistance_average", nil),
                          NSLocalizedString(@"NLHealthManger_StepEnergy_average", nil),
                          NSLocalizedString(@"NLHealthManger_StepActovity_average", nil),];
    }else{
        remarkLabText = @[NSLocalizedString(@"NLHealthManger_StepRemarkLab", nil),
                          NSLocalizedString(@"NLHealthManger_StepDistance", nil),
                          NSLocalizedString(@"NLHealthManger_StepEnergy", nil),
                          NSLocalizedString(@"NLHealthManger_StepActovity", nil),];
    }
    
    
    
    [self stepAndColAndTime:dataLabArr remarkLabText:remarkLabText];
//
//    if (index == 0) {
//        NSArray *dataLabArr = @[@"300",@"30千米",@"8千卡",@"00小时15分钟"];
//        
//        [self stepAndColAndTime:dataLabArr];
//    }else{
//        NSArray *dataLabArr = @[@"6880",@"241千米",@"241千卡",@"02小时15分钟"];
//        
//        [self stepAndColAndTime:dataLabArr];
//    }
    
}
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
    _column = [[NLColumnImage alloc] initWithFrame:frame DataArr:arr strokeColor:[@"882a00" hexStringToColor] withColor:[@"fac96f" hexStringToColor] type:type timeLabArr:nil dataType:NLDataExhibitionType_step];
    _column.delegate = self;
    [self.view addSubview:_column];
    
}

#pragma mark 排序

- (NSMutableArray *)sortArrayData:(NSMutableArray *)arr{
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
    NSMutableArray *arrData = [self sortArrayData:data];
    
    NSLog(@"%@",arrData);
    
    
    NSInteger dayInt = 0;
    //取出第一条数据，判断是星期几，推断第一个循环
    NSInteger countS = 0;//总累计数的和
    
    NSDate  *currTime = [ApplicationStyle dateTransformationStringWhiffletree:[arrData[0] objectForKey:@"sportDate"]];
    
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
    NSInteger caloriesAmount = 0;
    NSInteger distanceAmount = 0;
    NSInteger totalTimeCount = 0;
    NSString *dateTime = nil;
__goto:
    dateTime = [arrData[nums] objectForKey:@"sportDate"];
    
    if (countS>arrData.count) {

    }else{
        for (NSInteger i=nums; i<countS; i++) {
            //每7天加一次数据/或者30天加一次数据
            sportCount =  sportCount + [[arrData[i] objectForKey:@"stepsAmount"] integerValue];
            caloriesAmount = caloriesAmount + [[arrData[i] objectForKey:@"caloriesAmount"] integerValue];
            distanceAmount = distanceAmount + [[arrData[i] objectForKey:@"distanceAmount"] integerValue];
            totalTimeCount = totalTimeCount + [[arrData[i] objectForKey:@"totalTimeCount"] integerValue];
        }
    }
    
    NSLog(@"%@",dateTime);
    //添加到数组
    NSDictionary *dic = @{@"stepsAmount":[NSNumber numberWithInteger:sportCount],@"sportDate":dateTime,@"caloriesAmount":[NSNumber numberWithInteger:caloriesAmount],@"distanceAmount":[NSNumber numberWithInteger:distanceAmount],@"totalTimeCount":[NSNumber numberWithInteger:totalTimeCount]};
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
        caloriesAmount = 0;
        distanceAmount = 0;
        totalTimeCount = 0;
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

