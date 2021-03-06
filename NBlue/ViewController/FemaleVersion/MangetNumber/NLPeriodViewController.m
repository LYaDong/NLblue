//
//  NLPeriodViewController.m
//  NBlue
//
//  Created by LYD on 15/12/29.
//  Copyright © 2015年 LYD. All rights reserved.
//
static const NSInteger TEXTFILEDTAG = 1000;
static const NSInteger BTNPICKERTAG = 2000;
#import "NLPeriodViewController.h"
#import "LYDSegmentControl.h"
#import "LYDSetSegmentControl.h"
#import "NLPickView.h"
@interface NLPeriodViewController ()<LYDSetSegmentDelegate,NLPickViewDelegate>
@property(nonatomic,strong)NLPickView *pickerView;
@property(nonatomic,strong)UIButton *blackView;
@property(nonatomic,strong)NSMutableDictionary *userdic;
@end

@implementation NLPeriodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userdic = [NSMutableDictionary dictionary];
    
     
    _userdic = self.user_Dic;
    
    
    
    self.view.backgroundColor = [self colors];
    [self preferredContentSize];
    [self bulidUI];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
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
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:360])/2, [ApplicationStyle control_height:210], [ApplicationStyle control_weight:360], [ApplicationStyle control_height:84])];
    logoImage.image = [UIImage imageNamed:@"NL_logo"];
    [self.view addSubview:logoImage];
    
    
    
    NSArray *titleArr = @[NSLocalizedString(@"NLIndividuaFormat_UserPeriod", nil),
                          NSLocalizedString(@"NLIndividuaFormat_UserCycle", nil),
                          NSLocalizedString(@"NLIndividuaFormat_UpDayDate", nil),];
    NSArray *textFieldRemark = @[NSLocalizedString(@"NLIndividuaFormat_UserPeriod_FiledText", nil),
                                 NSLocalizedString(@"NLIndividuaFormat_UserCycle_FiledText", nil),
                                 NSLocalizedString(@"NLIndividuaFormat_UpDayDate_FiledText", nil),];
    
    
    
    for (NSInteger i=0; i<titleArr.count; i++) {
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:97], [ApplicationStyle control_height:420] + i * [ApplicationStyle control_height:100], [ApplicationStyle control_weight:300], [ApplicationStyle control_height:40])];
        titleLab.text = titleArr[i];
        titleLab.font = [ApplicationStyle textThrityFont];
        titleLab.textColor = [self titleColor];
        titleLab.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:titleLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:70], [ApplicationStyle control_height:480 + i* 100], SCREENWIDTH - [ApplicationStyle control_weight:70 * 2], [ApplicationStyle control_height:1])];
        line.backgroundColor = [self titleColor];
        [self.view addSubview:line];
    }
    
    
    for (NSInteger i=0; i<titleArr.count; i++) {
        UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:170], [ApplicationStyle control_height:403] + i*[ApplicationStyle control_height:100], SCREENWIDTH - [ApplicationStyle control_weight:170 + 120], [ApplicationStyle control_height:80])];
        textFiled.tag = TEXTFILEDTAG + i;
        textFiled.placeholder = textFieldRemark[i];
        [textFiled setValue:[@"ff5b89" hexStringToColor] forKeyPath:@"_placeholderLabel.textColor"];
        textFiled.textColor = [@"f3366b" hexStringToColor];
        textFiled.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:textFiled];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(textFiled.rightSideOffset + [ApplicationStyle control_weight:20], [ApplicationStyle control_height:430]+ i * [ApplicationStyle control_height:100], [ApplicationStyle control_weight:16], [ApplicationStyle control_height:24])];
        image.image = [self uiImages];
        [self.view addSubview:image];
    }
    
    for (NSInteger i=0; i<titleArr.count; i++) {
        UIButton *btnPicker = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnPicker.frame = CGRectMake([ApplicationStyle control_weight:170], [ApplicationStyle control_height:400] + i*[ApplicationStyle control_height:100], SCREENWIDTH - [ApplicationStyle control_weight:170 + 100], [ApplicationStyle control_height:80]);
        btnPicker.tag = BTNPICKERTAG + i;
        [btnPicker addTarget:self action:@selector(btnPickerDown:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnPicker];
    }
    
    
    NSArray * items = @[NSLocalizedString(@"NLSelection_LastStep", nil),
                        NSLocalizedString(@"NLGenderSelection_Next", nil)];
    
    LYDSetSegmentControl *segement = [LYDSetSegmentControl shareInstance];
    segement.titleArray = items;
    segement.cornerRedius = 20;
    segement.borderWidth = 1;
    segement.selectedSegmentIndex = 0;
    segement.borderColors = [self titleColor];
    segement.clipsBounds = YES;
    segement.backGroupColor = [self titleColor];
    segement.titleColor = [UIColor  whiteColor];
    segement.titleFont = [ApplicationStyle textSuperSmallFont];
    segement.lineColor = [UIColor whiteColor];
    segement.lineHide = NO;
    
    
    CGRect frame = CGRectMake([ApplicationStyle control_weight:70], SCREENHEIGHT - [ApplicationStyle control_height:180] - [ApplicationStyle control_height:80], SCREENWIDTH - [ApplicationStyle control_weight:140], [ApplicationStyle control_height:80]);
    
    LYDSegmentControl *sele = [[LYDSegmentControl alloc] initWithSetSegment:segement frame:frame];
    sele.delegate = self;
    sele.backgroundColor = [self titleColor];
    [self.view addSubview:sele];
    
    _blackView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    _blackView.backgroundColor = [UIColor blackColor];
    _blackView.alpha = 0.5;
    _blackView.hidden = YES;
    [_blackView addTarget:self action:@selector(blackViewDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_blackView];
    
}
#pragma mark 系统Delegate
#pragma mark 自己的Delegate
-(void)segmentedIndex:(NSInteger)index{
    if (index == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UITextField *textPeriod = (UITextField *)[self.view viewWithTag:TEXTFILEDTAG + UseDatePicker_Period];
        UITextField *textCycle = (UITextField *)[self.view viewWithTag:TEXTFILEDTAG + UseDatePicker_Cycle];
        UITextField *textUpNext = (UITextField *)[self.view viewWithTag:TEXTFILEDTAG + UseDatePicker_UpNext];
        
        if (textPeriod.text.length == 0) {
            [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"经期不能为空哦~"];
            return;
        }
        
        if (textCycle.text.length == 0) {
            [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"周期不能为空哦~"];
            return;
        }
        
        if (textUpNext.text.length == 0){
            [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"上次的日期不能为空哦~"];
            return;
        }
        
        [_userdic setValue:@"0" forKey:@"gender"];//传性别，0 是女1 是男
        
        
        [[NLDatahub sharedInstance] upDataUserInformationConsumerid:[kAPPDELEGATE._loacluserinfo GetUser_ID] authtoken:[kAPPDELEGATE._loacluserinfo GetAccessToken] userCountData:_userdic];
    }
}
-(void)pickerCount:(NSString *)count seleType:(NSInteger)type pickerType:(NSInteger)pickType{
    
    [self pickerViewFramkeHide];
    switch (type) {
        case SeleType_Cancel:
        {
            _blackView.hidden = YES;
            break;
        }
        case SeleType_OK:
        {
            _blackView.hidden = YES;
            switch (pickType) {
                case PickerType_Cycle:
                {
                    UITextField *text = (UITextField *)[self.view viewWithTag:TEXTFILEDTAG + UseDatePicker_Period];
                    text.text = [NSString stringWithFormat:@"%@天",count];;;
                    [_userdic setValue:count forKey:@"cycleTime"];
                    break;
                }
                case PickerType_Period:
                {
                    UITextField *text = (UITextField *)[self.view viewWithTag:TEXTFILEDTAG + UseDatePicker_Cycle];
                    text.text = [NSString stringWithFormat:@"%@天",count];;;
                    [_userdic setValue:count   forKey:@"periodTime"];
                    break;
                }
                default:
                    break;
            }
            
            break;
        }
        default:
            break;
    }
    
}
-(void)datePicker:(NSDate *)date cancel:(NSInteger)cancelType useDatePicker:(NSInteger)useDatePicker{
    [self pickerViewFramkeHide];
    switch (cancelType) {
        case SeleType_Cancel:
        {
            _blackView.hidden = YES;
            break;
        }
        case SeleType_OK:
        {
            _blackView.hidden = YES;
            switch (useDatePicker) {
                case UseDatePicker_UpNext:
                {
                    UITextField *text = (UITextField *)[self.view viewWithTag:TEXTFILEDTAG + UseDatePicker_UpNext];
                    text.text = [NSString stringWithFormat:@"%@天",[ApplicationStyle datePickerTransformationCorss:date]];
                    [kAPPDELEGATE._loacluserinfo lastTimeGoPeriodDate:[ApplicationStyle datePickerTransformationCorss:date]];
                    [_userdic setValue:[ApplicationStyle datePickerTransformationCorss:date] forKey:@"lastTime"];
                    break;
                }
                default:
                    break;
            }
            
            break;
        }
        default:
            break;
    }
}
#pragma mark 自己的按钮事件

-(void)btnPickerDown:(UIButton *)btn{
    _blackView.hidden = NO;
    switch (btn.tag - BTNPICKERTAG) {
        case 0:
        {
            [self pickerView:PickerType_Period];
            break;
        }
        case 1:
        {
            [self pickerView:PickerType_Cycle];
            break;
        }
        case 2:
        {
            [self datePickView:UseDatePicker_UpNext];
            break;
        }
        default:
            break;
    }
}

-(void)blackViewDown{
    
}

-(void)pickerView:(NSInteger)index{
    _pickerView = [[NLPickView alloc] initWithPickTye:index];
    _pickerView.frame = CGRectMake(0, SCREENHEIGHT + [ApplicationStyle control_height:560], SCREENWIDTH, [ApplicationStyle control_height:560]);
    _pickerView.delegate = self;
    [UIView animateWithDuration:0.5 animations:^{
        _pickerView.frame = CGRectMake(0, SCREENHEIGHT-[ApplicationStyle control_height:560], SCREENWIDTH, [ApplicationStyle control_height:560]);
    }];
    [self.view addSubview:_pickerView];
}

-(void)datePickView:(NSInteger)index{
    _pickerView = [[NLPickView alloc] initWithDateStyleType:DatePickerType_YearMothDay useDatePicker:index];
    _pickerView.frame = CGRectMake(0, SCREENHEIGHT + [ApplicationStyle control_height:560], SCREENWIDTH, [ApplicationStyle control_height:560]);
    _pickerView.delegate = self;
    [UIView animateWithDuration:0.5 animations:^{
        _pickerView.frame = CGRectMake(0, SCREENHEIGHT-[ApplicationStyle control_height:560], SCREENWIDTH, [ApplicationStyle control_height:560]);
    }];
    [self.view addSubview:_pickerView];
}

- (void)pickerViewFramkeHide{
    [UIView animateWithDuration:0.5 animations:^{
        _pickerView.frame = CGRectMake(0, SCREENHEIGHT + [ApplicationStyle control_height:560], SCREENWIDTH, [ApplicationStyle control_height:560]);
    }];
}


-(UIColor *)colors{
    UIColor *color = nil;
    if ([[kAPPDELEGATE._loacluserinfo getUserGender]isEqualToString:@"0"]) {
        color = [@"ffe3e3" hexStringToColor];
    }else{
        color = [@"b7ebff" hexStringToColor];
    }
    return color;
}

-(UIColor *)titleColor{
    UIColor *color = nil;
    if ([[kAPPDELEGATE._loacluserinfo getUserGender]isEqualToString:@"0"]) {
        color = [@"f3366b" hexStringToColor];
    }else{
        color = [@"1f9af4" hexStringToColor];
    }
    return color;
}

-(UIImage *)uiImages{
    UIImage *img = nil;
    if ([[kAPPDELEGATE._loacluserinfo getUserGender]isEqualToString:@"0"]) {
        img = [UIImage imageNamed:@"NL_Arrow_female"];
    }else{
        img = [UIImage imageNamed:@"NL_Arrow_Male"];
    }
    return img;
}
-(void)addNotification{
    NSNotificationCenter *notifi= [NSNotificationCenter defaultCenter];
    [notifi addObserver:self selector:@selector(upDataUserInformationSuccess) name:NLUpDateUserInformationSuccessNotification object:nil];
    [notifi addObserver:self selector:@selector(upDataUserInformationFicaled) name:NLUpDateUserInformationFicaledNotification object:nil];
    [notifi addObserver:self selector:@selector(upCycleOrPeriodSuccess) name:NLUpCycleOrPeriodSuccessNotification object:nil];
    [notifi addObserver:self selector:@selector(upCycleOrPeriodFicaled) name:NLUpCycleOrPeriodFicaledNotification object:nil];
}
-(void)upDataUserInformationSuccess{
    [[NLDatahub sharedInstance] upDataCycleOrPeriod:_userdic];
}
-(void)upDataUserInformationFicaled{
    
}
-(void)upCycleOrPeriodSuccess{
    [kAPPDELEGATE._loacluserinfo isLoginUser:@"1"];
    [kAPPDELEGATE._loacluserinfo goControllew:@"1"];
    [kAPPDELEGATE tabBarViewControllerType:Controller_WoManMain];
    [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"登录成功"];
    
    [PlistData individuaData:_userdic];
}
-(void)upCycleOrPeriodFicaled{
    
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
