//
//  NLMaleHealthMangerViewController.m
//  NBlue
//
//  Created by LYD on 16/1/6.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLMaleHealthMangerViewController.h"
#import "LYDSetSegmentControl.h"
#import "LYDSegmentControl.h"
#import "NLHealthSleepView.h"
#import "NLHealthStepNumber.h"
#import "NLHealthMangerViewController.h"

@interface NLMaleHealthMangerViewController ()<UIScrollViewDelegate,LYDSetSegmentDelegate>
@property(nonatomic,strong)UIScrollView *mainScrollew;
@end

@implementation NLMaleHealthMangerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [@"fffeeb" hexStringToColor];
    self.returnBtn.hidden = YES;
    self.rightBtn.hidden = YES;
    
    
    
    
    
    [self bulidUI];
    [self initView];
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
    NSArray * items = @[NSLocalizedString(@"HealthManger_Sleep", nil),NSLocalizedString(@"HealthManger_StepNumber", nil)];
    
    
    LYDSetSegmentControl *segement = [LYDSetSegmentControl shareInstance];
    segement.titleArray = items;
    segement.cornerRedius = 15;
    segement.borderWidth = 1;
    segement.selectedSegmentIndex = 0;
    segement.borderColors = [UIColor whiteColor];
    segement.clipsBounds = YES;
    segement.backGroupColor = [@"05b9ff" hexStringToColor];
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
    
}
- (void)initView{
    NLHealthSleepView *sleepView = [[NLHealthSleepView alloc] initWithFrame:CGRectMake(0 * SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle statusBarSize] - [ApplicationStyle navigationBarSize] - [ApplicationStyle tabBarSize])];
    [_mainScrollew addSubview:sleepView];
    
    NLHealthStepNumber *stepView = [[NLHealthStepNumber alloc] initWithFrame:CGRectMake(1 * SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle statusBarSize] - [ApplicationStyle navigationBarSize] - [ApplicationStyle tabBarSize])];
    stepView.backgroundColor = [UIColor clearColor];
    [_mainScrollew addSubview:stepView];
}
#pragma mark 系统Delegate
#pragma mark 自己的Delegate
-(void)segmentedIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            self.rightBtn.hidden = NO;
            _mainScrollew.contentOffset = CGPointMake(0 * SCREENWIDTH, 0);
            break;
        }
        case 1:
        {
            self.rightBtn.hidden = NO;
            _mainScrollew.contentOffset = CGPointMake(1 * SCREENWIDTH, 0);
            break;
        }
        default:
            break;
    }
}
#pragma mark 自己的按钮事件

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
