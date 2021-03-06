//
//  HealthMangerViewController.m
//  NBlue
//
//  Created by LYD on 15/11/23.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLHealthMangerViewController.h"
#import "LYDSetSegmentControl.h"
#import "LYDSegmentControl.h"
#import "NLHealthCalenderView.h"
#import "NLHealthSleepView.h"
#import "NLHealthStepNumber.h"
#import "NLHealthMangerStepNumViewController.h"
#import "NLHealthMangerSleepViewController.h"
#import "NLSQLData.h"
@interface NLHealthMangerViewController ()<UIScrollViewDelegate,LYDSetSegmentDelegate>
@property(nonatomic,strong)UIScrollView *mainScrollew;
@property(nonatomic,assign)NSInteger numPage;
@property(nonatomic,strong)UIView *blackBackView;

@end

@implementation NLHealthMangerViewController
-(void)rightBtnDown{
    switch (_numPage) {
        case NLHealthMangerController_Sleep:
        {
            NLHealthMangerSleepViewController *vc = [[NLHealthMangerSleepViewController alloc] init];
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case NLHealthMangerController_Step:
        {
            NLHealthMangerStepNumViewController *vc = [[NLHealthMangerStepNumViewController alloc] init];
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
    
    

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _numPage = 0;
    
    
    self.returnBtn.hidden = YES;
    
    self.rightBtn.hidden = YES;
    [self.rightBtn setImage:[UIImage imageNamed:@"Step_T_B"] forState:UIControlStateNormal];
    
    [self bulidUI];
    [self initView];
//    [self loadStepData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self delNotification];
    [self addNotification];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self delNotification];
}
#pragma mark 基础UI
-(void)bulidUI{
   
    CGRect frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:360])/2, [ApplicationStyle statusBarSize] + ([ApplicationStyle navigationBarSize] - [ApplicationStyle control_height:60])/2, [ApplicationStyle control_weight:360], [ApplicationStyle control_height:60]);
    NSArray * items = @[NSLocalizedString(@"HealthManger_Calendar", nil), NSLocalizedString(@"HealthManger_Sleep", nil),NSLocalizedString(@"HealthManger_StepNumber", nil)];
    

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
                                      
    
    
    _mainScrollew = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle tabBarSize] - [ApplicationStyle navigationBarSize])];
    _mainScrollew.delegate = self;
    _mainScrollew.contentSize = CGSizeMake(SCREENWIDTH * items.count, SCREENHEIGHT - [ApplicationStyle tabBarSize] - [ApplicationStyle navigationBarSize]);
    _mainScrollew.scrollEnabled = NO;
    _mainScrollew.pagingEnabled = YES;
    _mainScrollew.bounces = NO;
    [self.view addSubview:_mainScrollew];
    

    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"2015-03-01" forKey:@"startDate"];
    [dic setValue:@"2016-03-29" forKey:@"endDate"];
    [[NLDatahub sharedInstance] getCalendar:dic];
    
    
}
-(void)initView{
    NLHealthCalenderView *calenderView = [[NLHealthCalenderView alloc] initWithFrame:CGRectMake(NLHealthManger_Calender * SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle statusBarSize] - [ApplicationStyle navigationBarSize] - [ApplicationStyle tabBarSize])];
    [_mainScrollew addSubview:calenderView];
    
    NLHealthSleepView *sleepView = [[NLHealthSleepView alloc] initWithFrame:CGRectMake(NLHealthManger_Sleep * SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle statusBarSize] - [ApplicationStyle navigationBarSize] - [ApplicationStyle tabBarSize])];
    [_mainScrollew addSubview:sleepView];

    NLHealthStepNumber *stepView = [[NLHealthStepNumber alloc] initWithFrame:CGRectMake(NLHealthManger_StepNumber * SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle statusBarSize] - [ApplicationStyle navigationBarSize] - [ApplicationStyle tabBarSize])];
    stepView.backgroundColor = [UIColor clearColor];
    [_mainScrollew addSubview:stepView];    
}
#pragma mark 系统Delegate
#pragma mark 自己的Delegate

-(void)segmentedIndex:(NSInteger)index{
    _numPage = index;
    switch (index) {
        case NLHealthManger_Calender:
        {
            self.rightBtn.hidden = YES;
            _mainScrollew.contentOffset = CGPointMake(NLHealthManger_Calender * SCREENWIDTH, 0);
            break;
        }
        case NLHealthManger_Sleep:
        {
            self.rightBtn.hidden = NO;
            _mainScrollew.contentOffset = CGPointMake(NLHealthManger_Sleep * SCREENWIDTH, 0);
            break;
        }
        case NLHealthManger_StepNumber:
        {
            self.rightBtn.hidden = NO;
            _mainScrollew.contentOffset = CGPointMake(NLHealthManger_StepNumber * SCREENWIDTH, 0);
            break;
        }
        default:
            break;
    }
}

-(void)loadStepData{
    [[NLDatahub sharedInstance] userStepNumberToken:[kAPPDELEGATE._loacluserinfo GetAccessToken]
                                         consumerId:[kAPPDELEGATE._loacluserinfo GetUser_ID]
                                          startDate:@"2015-10-01"
                                            endDate:@"2016-10-30"];
}
-(void)addNotification{
    NSNotificationCenter *notifi= [NSNotificationCenter defaultCenter];
    [notifi addObserver:self selector:@selector(calendarSuccess:) name:NLGetCalendarSuccessNotification object:nil];
    [notifi addObserver:self selector:@selector(calendarFicaled) name:NLGetCalendarFicaledNotification object:nil];
}

-(void)calendarSuccess:(NSNotification *)notifi{
    
    [NLSQLData upDateCanlendarData:notifi.object];
}
-(void)calendarFicaled{
    
}
-(void)delNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
