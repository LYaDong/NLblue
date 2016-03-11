//
//  NLBodyParamentViewController.m
//  NBlue
//
//  Created by LYD on 15/12/29.
//  Copyright © 2015年 LYD. All rights reserved.
//
static const NSInteger TEXTFILEDTAG = 1000;
static const NSInteger BTNPICKERTAG = 2000;
#import "NLBodyParamentViewController.h"
#import "LYDSegmentControl.h"
#import "LYDSetSegmentControl.h"
#import "NLPeriodViewController.h"
#import "NLPickView.h"
@interface NLBodyParamentViewController ()<LYDSetSegmentDelegate,NLPickViewDelegate>
@property(nonatomic,strong)NLPickView *pickerView;
@property(nonatomic,strong)UIButton *blackView;
@property(nonatomic,strong)NSMutableDictionary *userDic;
@end

@implementation NLBodyParamentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userDic = [NSMutableDictionary dictionary];
    self.view.backgroundColor = [self colors];
    
    [self prefersStatusBarHidden];
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
    
    
    
    NSArray *titleArr = @[NSLocalizedString(@"NLIndividuaFormat_UserAge", nil),
                          NSLocalizedString(@"NLIndividuaFormat_UserHeight", nil),
                          NSLocalizedString(@"NLIndividuaFormat_UserWidth", nil),];
    
    
    for (NSInteger i=0; i<titleArr.count; i++) {
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:97], [ApplicationStyle control_height:420] + i * [ApplicationStyle control_height:100], [ApplicationStyle control_weight:80], [ApplicationStyle control_height:40])];
        titleLab.text = titleArr[i];
        titleLab.font = [ApplicationStyle textThrityFont];
        titleLab.textColor = [self titleColor];
        titleLab.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:titleLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:70], [ApplicationStyle control_height:480 + i* 100], SCREENWIDTH - [ApplicationStyle control_weight:70 * 2], [ApplicationStyle control_height:1])];
        line.backgroundColor = [self titleColor];
        [self.view addSubview:line];
    }
    
    
    for (NSInteger i=0; i<titleArr.count; i++) {
        UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:175], [ApplicationStyle control_height:403] + i*[ApplicationStyle control_height:100], SCREENWIDTH - [ApplicationStyle control_weight:170 + 120], [ApplicationStyle control_height:80])];
        textFiled.textAlignment = NSTextAlignmentRight;
        textFiled.textColor = [@"f3366b" hexStringToColor];
        textFiled.tag = TEXTFILEDTAG + i;
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
        
        UITextField *textAge = (UITextField *)[self.view viewWithTag:TEXTFILEDTAG + PickerType_Age];
        UITextField *textHeight = (UITextField *)[self.view viewWithTag:TEXTFILEDTAG + PickerType_Height];
        UITextField *textWidth = (UITextField *)[self.view viewWithTag:TEXTFILEDTAG + PickerType_Width];
        
        if (textAge.text.length == 0) {
            [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"年龄不能为空哦~"];
            return;
        }
        
        if (textHeight.text.length == 0) {
            [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"身高不能为空哦~"];
            return;
        }
        
        if (textWidth.text.length == 0){
            [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"体重不能为空哦~"];
            return;
        }
        
        
        
        if ([[kAPPDELEGATE._loacluserinfo getUserGender]isEqualToString:@"1"]) {
            
            [_userDic setValue:@"1" forKey:@"gender"];//传性别，0 是女1 是男
            
            
            [[NLDatahub sharedInstance] upDataUserInformationConsumerid:[kAPPDELEGATE._loacluserinfo GetUser_ID] authtoken:[kAPPDELEGATE._loacluserinfo GetAccessToken] userCountData:_userDic];
            
        }else{
            NLPeriodViewController *vc = [[NLPeriodViewController alloc] init];
            [vc setHidesBottomBarWhenPushed:YES];
            vc.user_Dic = _userDic;
            [self.navigationController pushViewController:vc animated:YES];
        }
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
                case PickerType_Age:
                {
                    UITextField *text = (UITextField *)[self.view viewWithTag:TEXTFILEDTAG + PickerType_Age];
                    text.text = [NSString stringWithFormat:@"%@岁",count];
                    [_userDic setValue:count  forKey:@"age"];
                    break;
                }
                case PickerType_Height:
                {
                    UITextField *text = (UITextField *)[self.view viewWithTag:TEXTFILEDTAG + PickerType_Height];
                    text.text = [NSString stringWithFormat:@"%@cm",count];;
                    [_userDic setValue:count  forKey:@"height"];
                    break;
                }
                case PickerType_Width:
                {
                    UITextField *text = (UITextField *)[self.view viewWithTag:TEXTFILEDTAG + PickerType_Width];
                    text.text = [NSString stringWithFormat:@"%@kg",count];;
                    [_userDic setValue:count  forKey:@"width"];
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
- (void)datePicker:(NSDate *)date cancel:(NSInteger)cancelType useDatePicker:(NSInteger)useDatePicker{
}
#pragma mark 自己的按钮事件
-(void)btnPickerDown:(UIButton *)btn{
    
    _blackView.hidden = NO;
    
    
    switch (btn.tag - BTNPICKERTAG) {
        case 0:
        {
            [self pickerView:PickerType_Age];
            break;
        }
        case 1:
        {
            [self pickerView:PickerType_Height];
            break;
        }
        case 2:
        {
            [self pickerView:PickerType_Width];
            break;
        }
        default:
            break;
    }
}
-(void)blackViewDown{
    
}


#pragma mark pickerView出现
-(void)pickerView:(NSInteger)index{
    _pickerView = [[NLPickView alloc] initWithPickTye:index];
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
}
-(void)upDataUserInformationSuccess{
    [kAPPDELEGATE._loacluserinfo isLoginUser:@"1"];
    [kAPPDELEGATE._loacluserinfo goControllew:@"1"];
    [kAPPDELEGATE tabBarViewControllerType:Controller_MaleMain];
    [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"登录成功"];
    [PlistData individuaData:_userDic];

}
-(void)upDataUserInformationFicaled{
    
}
-(void)delNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    for (NSInteger i=0; i<3; i++) {
//        UITextField *texs = (UITextField *)[self.view viewWithTag:TEXTFILEDTAG + i];
//        [texs resignFirstResponder];
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
