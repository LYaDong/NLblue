//
//  NLRegisteredViewController.m
//  NBlue
//
//  Created by LYD on 15/12/7.
//  Copyright © 2015年 LYD. All rights reserved.
//
static const NSInteger TEXTFILED_TAG = 1000;
#import "NLRegisteredViewController.h"

@interface NLRegisteredViewController ()
@property(nonatomic,strong)UIButton *verificationBtn;
@property(nonatomic,strong)UIButton *completeBtn;
@property(nonatomic,strong)NSTimer *timeVer;
@property(nonatomic,assign)NSInteger timeNum;
@property(nonatomic,strong)UILabel *verTimeLab;
@end

@implementation NLRegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    {
        self.navBarBack.hidden = YES;
        self.navBarPushBack.hidden = NO;
        self.controllerBack.hidden = YES;
    }
    
    self.view.backgroundColor = [ApplicationStyle subjectBackViewColor];
    self.titles.text = NSLocalizedString(@"NLRegistered_registered", nil);
    [self bulidUI];
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
    NSArray *arrLab = @[NSLocalizedString(@"NLRegistered_PhoneNumber", nil),
                        NSLocalizedString(@"NLRegistered_Verification", nil),
                        NSLocalizedString(@"NLRegistered_PassWord", nil),];
    
    for (NSInteger i=0; i<arrLab.count; i++) {
        UIView *viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize] + i * [ApplicationStyle control_height:110], SCREENWIDTH, [ApplicationStyle control_height:90])];
        viewBack.backgroundColor = [ApplicationStyle subjectWithColor];
        [self.view addSubview:viewBack];

        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize] + i * [ApplicationStyle control_height:109], SCREENWIDTH, [ApplicationStyle control_height:1])];
        viewLine.backgroundColor = [@"dedede" hexStringToColor];
        [self.view addSubview:viewLine];
        
        UIView *viewLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize] + [ApplicationStyle control_height:89] + i * [ApplicationStyle control_height:110], SCREENWIDTH, [ApplicationStyle control_height:1])];
        viewLine1.backgroundColor = [@"dedede" hexStringToColor];
        [self.view addSubview:viewLine1];
        if (i==0) {
            viewLine.hidden = YES;
        }
    }
    
    for (NSInteger i=0; i<arrLab.count; i++) {
        UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:20], [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize] + i * [ApplicationStyle control_height:110], SCREENWIDTH - [ApplicationStyle control_weight:20 * 2], [ApplicationStyle control_height:90])];
        textFiled.placeholder = arrLab[i];
        textFiled.tag = TEXTFILED_TAG + i;
        textFiled.textColor = [ApplicationStyle subjectPinkColor];
        [self.view addSubview:textFiled];
        
        if (i==1) {
            textFiled.frame = CGRectMake([ApplicationStyle control_weight:20], [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize] + i * [ApplicationStyle control_height:110], SCREENWIDTH - [ApplicationStyle control_weight:200], [ApplicationStyle control_height:90]);
            UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:200], [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize] + i * [ApplicationStyle control_height:110], [ApplicationStyle control_weight:1], [ApplicationStyle control_height:90])];
            viewLine.backgroundColor = [@"dedede" hexStringToColor];

            [self.view addSubview:viewLine];
            
            _verTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:200], [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize] + i * [ApplicationStyle control_height:110], [ApplicationStyle control_weight:200], [ApplicationStyle control_height:90])];
            _verTimeLab.text = NSLocalizedString(@"NLRegistered_GetVerfication", nil);
            _verTimeLab.textColor = [ApplicationStyle subjectPinkColor];
            _verTimeLab.font = [ApplicationStyle textSuperSmallFont];
            _verTimeLab.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:_verTimeLab];
            
            _verificationBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _verificationBtn.frame = CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:200], [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize] + i * [ApplicationStyle control_height:110], [ApplicationStyle control_weight:200], [ApplicationStyle control_height:90]);
            [_verificationBtn addTarget:self action:@selector(verificactionBtnDown) forControlEvents:UIControlEventTouchUpInside];
            _verificationBtn.backgroundColor = [UIColor clearColor];
            [self.view addSubview:_verificationBtn];
        }
        
    }
    UITextField *textPassWord = (UITextField *)[self.view viewWithTag:TEXTFILED_TAG + 2];
    
    
    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseBtn.frame = CGRectMake([ApplicationStyle control_weight:20], textPassWord.bottomOffset + [ApplicationStyle control_height:20], [ApplicationStyle control_weight:28], [ApplicationStyle control_height:28]);
    chooseBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:chooseBtn];
    
    
    CGSize proticolSize = [ApplicationStyle textSize:NSLocalizedString(@"NLRegistered_Protocol", nil) font:[ApplicationStyle textSuperSmallFont] size:SCREENWIDTH];
    
    UIButton *protocol = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    protocol.frame = CGRectMake([ApplicationStyle control_weight:67], textPassWord.bottomOffset + [ApplicationStyle control_height:20], proticolSize.width, [ApplicationStyle control_height:30]);
    [protocol setTitle:NSLocalizedString(@"NLRegistered_Protocol", nil) forState:UIControlStateNormal];
    protocol.titleLabel.font = [ApplicationStyle textSuperSmallFont];
    [protocol setTitleColor:[ApplicationStyle subjectPinkColor] forState:UIControlStateNormal];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"NLRegistered_Protocol", nil) attributes:@{NSFontAttributeName:[ApplicationStyle textSuperSmallFont],NSForegroundColorAttributeName:[ApplicationStyle subjectPinkColor]}];
    NSRange titleRange = {2,[title length] - 2};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    
    [protocol setAttributedTitle:title forState:UIControlStateNormal];
    [self.view addSubview:protocol];
    

    _completeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _completeBtn.frame = CGRectMake([ApplicationStyle control_weight:40], protocol.bottomOffset + [ApplicationStyle control_height:30], SCREENWIDTH - [ApplicationStyle control_weight:40 * 2], [ApplicationStyle control_height:90]);
    _completeBtn.backgroundColor = [ApplicationStyle subjectPinkColor];
    [_completeBtn setTitle:NSLocalizedString(@"NLRegistered_completeBtn", nil) forState:UIControlStateNormal];
    [_completeBtn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
    _completeBtn.titleLabel.font = [ApplicationStyle textSuperSmallFont];
    [_completeBtn addTarget:self action:@selector(completeBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_completeBtn];
    
}

#pragma mark 系统Delegate
#pragma mark 自己的Delegate
#pragma mark 自己的按钮事件
-(void)verificactionBtnDown{
    if (_timeNum == 0) {
        UITextField *textPhone = (UITextField *)[self.view viewWithTag:TEXTFILED_TAG];
        if (textPhone.text.length == 0) {
            NSLog(@"请输入手机号");
            return;
        }
        if (![ApplicationStyle PhoteFormat:textPhone.text]) {
            NSLog(@"手机格式不对");
            return;
        }
        _verTimeLab.text = @"30";
        _timeVer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeVerDown) userInfo:nil repeats:YES];
        [[NLDatahub sharedInstance] getVerificationCodePhones:[NSNumber numberWithInteger:[[NSString stringWithFormat:@"%@",textPhone.text] integerValue]]];
    }
    
}
-(void)timeVerDown{
    _timeNum += 1;
    _verTimeLab.text = [NSString stringWithFormat:@"%ld",30 - (long)_timeNum];
    if (_timeNum == 30) {
        [_timeVer invalidate];
       _verTimeLab.text = NSLocalizedString(@"NLRegistered_GetVerfication", nil);
        _timeNum = 0;
    }
}
-(void)completeBtnDown{
    UITextField *textPhone = (UITextField *)[self.view viewWithTag:TEXTFILED_TAG];
    UITextField *textVerification = (UITextField *)[self.view viewWithTag:TEXTFILED_TAG + 1];
    UITextField *textPassWord = (UITextField *)[self.view viewWithTag:TEXTFILED_TAG + 2];
    if (textPhone.text.length == 0) {
        NSLog(@"请输入手机号");
        return;
    }
    if (![ApplicationStyle PhoteFormat:textPhone.text]) {
        NSLog(@"手机格式不对");
        return;
    }
    if (textVerification.text.length == 0) {
        NSLog(@"请输入验证码");
        return;
    }
    if (textPassWord.text.length == 0) {
        NSLog(@"请输入密码");
        return;
    }
    
    [[NLDatahub sharedInstance] registeredCodephone:[NSNumber numberWithInteger:[[NSString stringWithFormat:@"%@",textPhone.text] integerValue]]
                                       verification:[NSNumber numberWithInteger:[[NSString stringWithFormat:@"%@",textVerification.text] integerValue]]
                                           password:[NSNumber numberWithInteger:[[NSString stringWithFormat:@"%@",textPassWord.text] integerValue]]];
}

-(void)addNotification{
    NSNotificationCenter *notifi= [NSNotificationCenter defaultCenter];
    [notifi addObserver:self selector:@selector(logInSuccess:) name:NLRegisteredViewControllewSuccessNotification object:nil];
    [notifi addObserver:self selector:@selector(logInFicaled) name:NLRegisteredViewControllewFicaledNotification object:nil];
}
-(void)logInSuccess:(NSNotification *)notifi{
    NSDictionary *dic = notifi.object;
    [kAPPDELEGATE._loacluserinfo SetUser_ID:[dic objectForKey:@"consumerId"]];
    [kAPPDELEGATE._loacluserinfo SetUserAccessToken:[dic objectForKey:@"authToken"]];
    [kAPPDELEGATE._loacluserinfo goControllew:@"1"];
    [kAPPDELEGATE tabBarViewControllerType:Controller_Main];
    
}
-(void)logInFicaled{
    
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
