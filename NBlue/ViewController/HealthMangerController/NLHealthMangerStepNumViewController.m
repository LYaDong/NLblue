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
@interface NLHealthMangerStepNumViewController ()<LYDSetSegmentDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *mainScrollew;
@property(nonatomic,strong)NLColumnImage *column;

@end

@implementation NLHealthMangerStepNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    
    
    _mainScrollew = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle statusBarSize] - [ApplicationStyle navigationBarSize])];
    _mainScrollew.delegate = self;
    
    

//    _mainScrollew.pagingEnabled = YES;
    _mainScrollew.bounces = NO;
    [self.view addSubview:_mainScrollew];
    
    
    
    
    
    
    
    NSMutableArray *arrs = [NSMutableArray array];
    for (NSInteger i=0; i<22; i++) {
        NSInteger num = arc4random()%150;
        [arrs addObject:[NSNumber numberWithInteger:num]];
    }
    
    [self imageConvenDataArr:arrs type:NLCalendarType_Day];
    
    
    
    UIView *viewTimeBack = [[UIView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle control_height:480] + [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize], SCREENWIDTH, [ApplicationStyle control_height:60])];
    viewTimeBack.backgroundColor = [ApplicationStyle subjectWithColor];
    viewTimeBack.alpha = 0.1;
    [self.view addSubview:viewTimeBack];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, viewTimeBack.bottomOffset, SCREENWIDTH, [ApplicationStyle control_height:1])];
    line.backgroundColor = [ApplicationStyle subjectWithColor];
    [self.view addSubview:line];
    
    
    
    
    
    NSArray *remarkLabText = @[NSLocalizedString(@"NLHealthManger_StepRemarkLab", nil),
                               NSLocalizedString(@"NLHealthManger_StepDistance", nil),
                               NSLocalizedString(@"NLHealthManger_StepEnergy", nil),
                               NSLocalizedString(@"NLHealthManger_StepActovity", nil),];
    NSArray *dataLabArr = @[@"6880",@"241千米",@"241千卡",@"02小时15分钟"];
    NSArray *typeLab = @[[NSNumber numberWithInteger:LabTextType_DayStepNum],
                         [NSNumber numberWithInteger:LabTextType_DayDistance],
                         [NSNumber numberWithInteger:LabTextType_DayEnergy],
                         [NSNumber numberWithInteger:LabTextType_DayActovity]];
    
    CGFloat heights = [ApplicationStyle control_height:480 + 60] + [ApplicationStyle control_height:64] + [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize];
    
    for (NSInteger i=0; i<dataLabArr.count; i++) {
        NSInteger x = 0 + i % 2 * SCREENWIDTH/2,
        y = heights + i / 2 * [ApplicationStyle control_height:115],
        w = SCREENWIDTH/2,
        h = [ApplicationStyle control_height:115];
        
        CGRect frames = CGRectMake(x, y, w, h);
        
        NSInteger type = [[NSString stringWithFormat:@"%@",typeLab[i]] integerValue];
        
        NLStepCountLabView *labView = [[NLStepCountLabView alloc] initWithFrame:frames
                                                                           type:type
                                                                  remarkLabText:remarkLabText[i]
                                                                    dataLabText:dataLabArr[i]];
        [self.view addSubview:labView];
        
    }
    
    
    
    
    
    

    
    
}
#pragma mark 系统Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
  
    
}

#pragma mark 自己的Delegate
-(void)segmentedIndex:(NSInteger)index{
    
    [_column removeFromSuperview];
    
    switch (index) {
        case NLCalendarType_Day:
        {
            
            NSMutableArray *arrs = [NSMutableArray array];
            for (NSInteger i=0; i<10; i++) {
                NSInteger num = arc4random()%150;
                [arrs addObject:[NSNumber numberWithInteger:num]];
            }
            
            [self imageConvenDataArr:arrs type:NLCalendarType_Day];
            break;
        }
        case NLCalendarType_Week:
        {
            NSMutableArray *arrs = [NSMutableArray array];
            for (NSInteger i=0; i<12; i++) {
                NSInteger num = arc4random()%150;
                [arrs addObject:[NSNumber numberWithInteger:num]];
            }
            
           [self imageConvenDataArr:arrs type:NLCalendarType_Week];
            break;
        }
        case NLCalendarType_Month:
        {
            
            NSMutableArray *arrs = [NSMutableArray array];
            for (NSInteger i=0; i<1; i++) {
                NSInteger num = arc4random()%150;
                [arrs addObject:[NSNumber numberWithInteger:num]];
            }
            
            [self imageConvenDataArr:arrs type:NLCalendarType_Month];
            break;
        }
        default:
            break;
    }
    
    
    
    
    //    > SCREENWIDTH + arrs.count * [ApplicationStyle control_weight:10]?arrs.count * [ApplicationStyle control_weight:50] + arrs.count * [ApplicationStyle control_weight:10]: SCREENWIDTH + arrs.count * [ApplicationStyle control_weight:10]
    
    
    
}
#pragma mark 自己的按钮事件



-(void)imageConvenDataArr:(NSArray *)arr type:(NSInteger)type{
    
    
    CGFloat convenImageWeight = 0;
    switch (type) {
        case NLCalendarType_Day:
        {
            convenImageWeight = [ApplicationStyle control_weight:50];

            break;
        }
        case NLCalendarType_Week:
        {
            convenImageWeight = [ApplicationStyle control_weight:90];
            break;
        }
        case NLCalendarType_Month:
        {
            convenImageWeight = [ApplicationStyle control_weight:120];
            break;
        }
        default:
            break;
    }
    
    NSInteger weight = arr.count * convenImageWeight + arr.count * [ApplicationStyle control_weight:10] - [ApplicationStyle control_weight:10];
    
    _mainScrollew.contentSize = CGSizeMake(weight + SCREENWIDTH/2 , SCREENHEIGHT - [ApplicationStyle statusBarSize] - [ApplicationStyle navigationBarSize]);
    _mainScrollew.contentOffset = CGPointMake(weight - SCREENWIDTH/2 , 0);
    
    _column = [[NLColumnImage alloc] initWithDataArr:arr strokeColor:[@"882a00" hexStringToColor] withColor:[@"fac96f" hexStringToColor] type:type timeLabArr:nil];
    _column.frame = CGRectMake(0, 0, weight , [ApplicationStyle control_height:480]);
    _column.backgroundColor = [UIColor clearColor];
    [_mainScrollew addSubview:_column];
    

    
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

