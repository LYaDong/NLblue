//
//  NLMyMaleSetViewController.m
//  NBlue
//
//  Created by LYD on 16/3/18.
//  Copyright © 2016年 LYD. All rights reserved.
//
static const NSInteger SWITCHTAG = 1000;
#import "NLMyMaleSetViewController.h"

@interface NLMyMaleSetViewController ()
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UIImageView *userHaadImage;
@property(nonatomic,strong)UILabel *userHeadName;
@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)NSMutableDictionary *maleSetDic;
@end

@implementation NLMyMaleSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titles.text = NSLocalizedString(@"", nil);
    _maleSetDic = [NSMutableDictionary dictionary];
    [_maleSetDic setValue:@"yes" forKey:@"calendar"];
    [_maleSetDic setValue:@"no" forKey:@"sport"];
    [_maleSetDic setValue:@"no" forKey:@"sleep"];
    
    [self bulidUI];
    [self loadDataPermisson];
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
    
    
    
   
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(-5, [ApplicationStyle navBarAndStatusBarSize] + [ApplicationStyle control_height:20], SCREENWIDTH+10, [ApplicationStyle control_height:156])];
    _headView.backgroundColor = [UIColor whiteColor];
    _headView.layer.borderColor = [self userLineColor].CGColor;
    _headView.layer.borderWidth = [ApplicationStyle control_height:1];
    [self.view addSubview:_headView];
    
    _userHaadImage = [[UIImageView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:30], [ApplicationStyle control_height:30], [ApplicationStyle control_weight:96], [ApplicationStyle control_weight:96])];
    _userHaadImage.backgroundColor = [UIColor redColor];
    _userHaadImage.layer.cornerRadius = [ApplicationStyle control_weight:10];
    [_headView addSubview:_userHaadImage];
    
    _userHeadName = [[UILabel alloc] initWithFrame:CGRectMake(_userHaadImage.rightSideOffset + [ApplicationStyle control_weight:30], [ApplicationStyle control_height:40], [ApplicationStyle control_weight:248], [ApplicationStyle control_height:40])];
    _userHeadName.text = @"小丑";
    _userHeadName.font = [ApplicationStyle textThrityFont];
    _userHeadName.textColor = [self userNameColor];
    [_headView addSubview:_userHeadName];
    
    UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:30], _headView.bottomOffset + [ApplicationStyle control_height:28], [ApplicationStyle control_weight:267], [ApplicationStyle control_height:30])];
    countLab.textColor = [self userCountColor];
    countLab.text = @"允许他看你的健康数据";
    countLab.font = [ApplicationStyle textSuperSmallFont];
    [self.view addSubview:countLab];
    
    _footerView = [[UIView alloc] initWithFrame:CGRectMake(-5, _headView.bottomOffset + [ApplicationStyle control_height:60], SCREENWIDTH+10, [ApplicationStyle control_height:88 * 2])];
    _footerView.backgroundColor = [UIColor whiteColor];
    _footerView.layer.borderColor = [self userLineColor].CGColor;
    _footerView.layer.borderWidth = [ApplicationStyle control_height:1];
    [self.view addSubview:_footerView];
    
    NSArray *jurisdictionArr = @[NSLocalizedString(@"NLProfileView_MyMaleSoport", nil),
                                 NSLocalizedString(@"NLProfileView_MyMaleSleep", nil)];
    for (NSInteger i=0; i<jurisdictionArr.count; i++) {
        UILabel *labjurisdiction = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:30], [ApplicationStyle control_height:1]+i*[ApplicationStyle control_height:86], [ApplicationStyle control_weight:150], [ApplicationStyle control_height:86])];
        labjurisdiction.textColor = [self userNameColor];
        labjurisdiction.text = jurisdictionArr[i];
        labjurisdiction.font = [ApplicationStyle textThrityFont];
        [_footerView addSubview:labjurisdiction];
    }
    
    for (NSInteger i=0; i<jurisdictionArr.count; i++) {
        UISwitch *switchs = [[UISwitch    alloc] initWithFrame:CGRectMake(_footerView.viewWidth - [ApplicationStyle control_weight:130] - [ApplicationStyle control_weight:24], [ApplicationStyle control_height:18]+i*[ApplicationStyle control_height:88], [ApplicationStyle control_weight:130], [ApplicationStyle control_height:88])];
        switchs.tag = SWITCHTAG +i;
        [switchs addTarget:self action:@selector(switchOffDown:) forControlEvents:UIControlEventValueChanged];
        [_footerView addSubview:switchs];
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:30], [ApplicationStyle control_height:88], SCREENWIDTH - [ApplicationStyle control_weight:30], [ApplicationStyle control_height:1])];
    line.backgroundColor = [self userLineColor];
    [_footerView addSubview:line];
    
    UIButton *deleMale = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    deleMale.frame = CGRectMake(-5, SCREENHEIGHT - [ApplicationStyle control_height:50] - [ApplicationStyle control_height:88], SCREENWIDTH+10, [ApplicationStyle control_height:88]);
    [deleMale setTitle:NSLocalizedString(@"NL_Del_Texr", nil) forState:UIControlStateNormal];
    [deleMale setTitleColor:[@"f13c61" hexStringToColor] forState:UIControlStateNormal];
    deleMale.backgroundColor = [UIColor whiteColor];
    deleMale.layer.borderColor = [self userLineColor].CGColor;
    deleMale.layer.borderWidth = [ApplicationStyle control_weight:1];
    [deleMale addTarget:self action:@selector(deleMaleDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleMale];
    
    
    [[NLDatahub sharedInstance] getMalePermission:_maleID];
    
    
//    NSString *strx = @"{\"calendar\":\"yes\",\"sport\":\"yes\",\"sleep\":\"yes\"}";
//    [dic setValue:@"yes" forKey:@"calendar"];
//    [dic setValue:@"yes" forKey:@"sport"];
//    [dic setValue:@"yes" forKey:@"sleep"];
//    [ApplicationStyle jsonDataTransString:dic];
    //481078
}

-(void)loadDataPermisson{
    
}
#pragma mark 系统Delegate
#pragma mark 自己的Delegate
#pragma mark 自己的按钮事件
- (void)switchOffDown:(UISwitch *)switchs{
    switch (switchs.tag - SWITCHTAG) {
        case 0:
        {
            if (switchs.on == YES) {
                [_maleSetDic setValue:@"yes" forKey:@"sport"];
            }else{
                [_maleSetDic setValue:@"no" forKey:@"sport"];
            }
//            switchs.on = switchs.on;
            [[NLDatahub sharedInstance] permissionStr:_maleSetDic];
            break;
        }
        case 1:
        {
            if (switchs.on == YES) {
                [_maleSetDic setValue:@"yes" forKey:@"sleep"];
            }else{
                [_maleSetDic setValue:@"no" forKey:@"sleep"];
            }
//            switchs.on = !switchs.on;
            [[NLDatahub sharedInstance] permissionStr:_maleSetDic];
            break;
        }
        default:
            break;
    }
}
-(void)deleMaleDown{
    [[NLDatahub sharedInstance] delMaleFamile:self.maleID];
}
#pragma mark 通知处理
#pragma mark Color

- (UIColor *)userNameColor{
    UIColor *color = [@"313131" hexStringToColor];
    return color;
}
- (UIColor *)userCountColor{
    UIColor *color = [@"707070" hexStringToColor];
    return color;
}
- (UIColor *)userLineColor{
    UIColor *color = [@"ffc5c5" hexStringToColor];
    return color;
}
-(void)addNotification{
    NSNotificationCenter *notifi = [NSNotificationCenter defaultCenter];
    [notifi addObserver:self selector:@selector(perMissionSuccessNotifi:) name:NLMaleGetPermissionSuccessNotification object:nil];
    [notifi addObserver:self selector:@selector(delMaleFamileSuccessNotifi:) name:NLMaleDELETEPermissionSuccessNotification object:nil];
}
-(void)perMissionSuccessNotifi:(NSNotification *)notifi{
    NSLog(@"%@",notifi.object);
    NSDictionary *dic = notifi.object;
    UISwitch *switchSleep = (UISwitch *)[self.view viewWithTag:SWITCHTAG+0];
    UISwitch *switchSport = (UISwitch *)[self.view viewWithTag:SWITCHTAG+1];
    
    if ([[dic objectForKey:@"sport"] isEqualToString:@"no"]) {
        switchSleep.on = NO;
        [_maleSetDic setValue:@"no" forKey:@"sport"];
    }else{
        switchSleep.on = YES;
        [_maleSetDic setValue:@"yes" forKey:@"sport"];
    }
    
    if ([[dic objectForKey:@"sleep"] isEqualToString:@"no"]) {
        switchSport.on = NO;
        [_maleSetDic setValue:@"no" forKey:@"sleep"];
    }else{
        switchSport.on = YES;
        [_maleSetDic setValue:@"yes" forKey:@"sleep"];
    }
}
-(void)delMaleFamileSuccessNotifi:(NSNotification *)notifi{
    if (self.delMale) {
        self.delMale(@"");
    }
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
