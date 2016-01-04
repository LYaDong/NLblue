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

@end

@implementation NLHealthMangerStepNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArr = [NSMutableArray array];
    _weekMonthCount = 0;
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
    
    LYDSegmentControl *sele = [[LYDSegmentControl alloc] initWithSetSegment:segement frame:frame];
    sele.delegate = self;
    [self.view addSubview:sele];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        _dataArr = [NLSQLData obtainSportDataBig];
       dispatch_async(dispatch_get_main_queue(), ^{
           
           
           
           NSMutableArray *arrData = [self sortArrayData:_dataArr];
           
           
          NSInteger week = (long)[ApplicationStyle currentDayWeek:[ApplicationStyle dateTransformationStringWhiffletree:[arrData[0] objectForKey:@"sportDate"]]] - 1;
           
           
           NSMutableArray *dddd = [NSMutableArray array];
           
           if (week == 0) {
               week = 7;
           }
           
           NSInteger nums = 0;
           NSInteger sportCount = 0;
           
       __goto:
           for (NSInteger i=nums; i<week+nums; i++) {
               sportCount =  sportCount + [[arrData[i] objectForKey:@"stepsAmount"] integerValue];
           }
           NSDictionary *dic = @{@"stepsAmount":[NSNumber numberWithInteger:sportCount]};
           [dddd addObject:dic];
           
           nums = nums + 7;
           
           NSLog(@"%ld",(long)nums);
           
           if (nums<=arrData.count) {
              week = (long)[ApplicationStyle currentDayWeek:[ApplicationStyle dateTransformationStringWhiffletree:[arrData[nums] objectForKey:@"sportDate"]]] - 1;
           }
           
           
           
           if (nums >=arrData.count) {
               [self imageConvenDataArr:arrData type:NLCalendarType_Day];
               return ;
           }else{
               sportCount = 0;
               goto __goto;
           }
           
           
           
           
           
           
           
           
       });
    });

    UIView *viewTimeBack = [[UIView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle control_height:480] + [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize], SCREENWIDTH, [ApplicationStyle control_height:60])];
    viewTimeBack.backgroundColor = [ApplicationStyle subjectWithColor];
    viewTimeBack.alpha = 0.1;
    [self.view addSubview:viewTimeBack];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, viewTimeBack.bottomOffset, SCREENWIDTH, [ApplicationStyle control_height:1])];
    line.backgroundColor = [ApplicationStyle subjectWithColor];
    [self.view addSubview:line];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:10])/2, [ApplicationStyle control_height:480] + [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize] - [ApplicationStyle control_weight:10], [ApplicationStyle control_weight:10], [ApplicationStyle control_weight:10])];
    view.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:view];
    
    
    
    
    
    NSArray *dataLabArr = @[@"6880",@"241千米",@"241千卡",@"02小时15分钟"];
    [self stepAndColAndTime:dataLabArr];
    
}

#pragma mark 系统Delegate
#pragma mark 自己的Delegate

-(void)segmentedIndex:(NSInteger)index{
    
    [_column removeFromSuperview];
//    [_dataArr removeAllObjects];
    
    switch (index) {
        case NLCalendarType_Day:
        {
            
//            _dataArr = [NLSQLData obtainSportDataBig];
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


-(void)stepAndColAndTime:(NSArray *)arr{
    

    
    _labViewBack = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - [ApplicationStyle control_height:492], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle control_height:492])];
    _labViewBack.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_labViewBack];
    
    NSArray *remarkLabText = @[NSLocalizedString(@"NLHealthManger_StepRemarkLab", nil),
                               NSLocalizedString(@"NLHealthManger_StepDistance", nil),
                               NSLocalizedString(@"NLHealthManger_StepEnergy", nil),
                               NSLocalizedString(@"NLHealthManger_StepActovity", nil),];
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

-(void)sildeIndex:(NSInteger)index{

    [_labViewBack removeFromSuperview];
    
    if (index == 0) {
        NSArray *dataLabArr = @[@"300",@"30千米",@"8千卡",@"00小时15分钟"];
        
        [self stepAndColAndTime:dataLabArr];
    }else{
        NSArray *dataLabArr = @[@"6880",@"241千米",@"241千卡",@"02小时15分钟"];
        
        [self stepAndColAndTime:dataLabArr];
    }
    
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
    _column = [[NLColumnImage alloc] initWithFrame:frame DataArr:arr strokeColor:[@"882a00" hexStringToColor] withColor:[@"fac96f" hexStringToColor] type:type timeLabArr:nil];
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

#pragma mark 返回7天的数据
-(NSArray *)dataThreeData:(NSMutableArray *)data{
    NSMutableArray *arrData = [self sortArrayData:data];
    
    NSInteger dayInt = 0;
    //取出第一条数据，判断是星期几，推断第一个循环
    NSInteger countS = 0;//总累计数的和
    
    NSDate  *currTime = [ApplicationStyle dateTransformationStringWhiffletree:[arrData[0] objectForKey:@"sportDate"]];
    
    if (_weekMonthCount == 7) {
         countS = [ApplicationStyle currentDayWeek:currTime] - 1;
    }else{ 
        countS =  [ApplicationStyle totalDaysInMonth:currTime] - ([ApplicationStyle totalDaysInMonth:currTime] - [ApplicationStyle whatDays:currTime]);
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
    //每7天加一次数据
    NSInteger sportCount = 0;
    NSString *dateTime = nil;
__goto:
    dateTime = [arrData[nums] objectForKey:@"sportDate"];
    for (NSInteger i=nums; i<countS+nums; i++) {
        //每7天加一次数据
        sportCount =  sportCount + [[arrData[i] objectForKey:@"stepsAmount"] integerValue];
    }
    //添加到数组
    NSDictionary *dic = @{@"stepsAmount":[NSNumber numberWithInteger:sportCount],@"sportDate":dateTime};
    [dataGather addObject:dic];
    
    
    NSLog(@"xxxxx   ====   %@",dataGather);
    
    dayInt  = dayInt - 1;
    if (_weekMonthCount == 7) {
        nums = nums + _weekMonthCount;//每次加7天
    }else{
        nums = nums + [ApplicationStyle totalDaysInMonth:[ApplicationStyle whatMonth:[NSDate date] timeDay:dayInt]];
    }
    if (nums<=arrData.count) {
        countS = (long)[ApplicationStyle currentDayWeek:[ApplicationStyle dateTransformationStringWhiffletree:[arrData[nums] objectForKey:@"sportDate"]]] - 1;
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

