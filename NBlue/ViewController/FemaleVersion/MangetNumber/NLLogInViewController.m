//
//  LogInViewController.m
//  NBlue
//
//  Created by LYD on 15/12/7.
//  Copyright © 2015年 LYD. All rights reserved.
//


static const NSInteger MANGERTAG = 2000;
static const NSInteger TEXT_TAG = 3000;
static const NSInteger THIRDBTNTAG = 4000;

#import "NLLogInViewController.h"
#import "NLRegisteredViewController.h"
#import "NLForgetPasswordViewController.h"
#import "UMSocial.h"
#import "NLGenderSelectionViewController.h"
#import <WXApi.h>
#import <WeiboSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <UMSocialQQHandler.h>
@interface NLLogInViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)NSMutableDictionary *userInformation;
@end

@implementation NLLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBarBack.hidden = YES;
    self.returnBtn.hidden = YES;
    _userInformation = [NSMutableDictionary dictionary];
    
    
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

    UIImageView *imageBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    imageBack.image = [UIImage imageNamed:@"RootContorllewImage"];
    [self.view addSubview:imageBack];
    
    
    
    
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:360])/2, [ApplicationStyle control_height:210], [ApplicationStyle control_weight:360], [ApplicationStyle control_height:84])];
    logoImage.image = [UIImage imageNamed:@"NL_logo"];
    [self.view addSubview:logoImage];
    
    
    
    
    
    
    NSArray *arr = @[NSLocalizedString(@"NLLogIn_TextNumber", nil),NSLocalizedString(@"NLLogIn_TextPassword", nil)];
    
    
    for (NSInteger i = 0; i<arr.count; i++) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:480])/2, [ApplicationStyle control_height:422] + i * [ApplicationStyle control_height:90], [ApplicationStyle control_weight:480], [ApplicationStyle control_height:70])];
        backView.layer.cornerRadius = [ApplicationStyle control_weight:35];
        backView.backgroundColor = [@"fdbfcd" hexStringToColor];
        [self.view addSubview:backView];
    }
    
    for (NSInteger i=0; i<arr.count; i++) {
        UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:480])/2 + [ApplicationStyle control_weight:80], [ApplicationStyle control_height:422] + i * [ApplicationStyle control_height:90], [ApplicationStyle control_weight:480] - [ApplicationStyle control_weight:80], [ApplicationStyle control_height:70])];
        text.placeholder = arr[i];
        text.delegate = self;
        text.borderStyle = UITextBorderStyleNone;
        text.tag = TEXT_TAG + i;
        [self.view addSubview:text];
        if (i==0) {
            text.keyboardType = UIKeyboardTypeNumberPad;
        }
        
        if (i==1) {
            text.secureTextEntry=YES;
        }
    }
    
    UITextField *textFiled = (UITextField *)[self.view viewWithTag:TEXT_TAG];
    
    NSArray *logImage = @[@"NLLoing_US",@"NLLoing_PW"];
    for (NSInteger i=0; i<logImage.count; i++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(textFiled.leftSidePosition - [ApplicationStyle control_weight:42], [ApplicationStyle control_height:440] + i * [ApplicationStyle control_height:90], [ApplicationStyle control_weight:32], [ApplicationStyle control_height:32])];
        image.image = [UIImage imageNamed:logImage[i]];
        [self.view addSubview:image];
    }
    
    UIButton *logIn = [UIButton gradiengBtnFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:480])/2,[ApplicationStyle control_height:422] + [ApplicationStyle control_height:200], [ApplicationStyle control_weight:480], [ApplicationStyle control_height:70])];
    [logIn setTitle:NSLocalizedString(@"NLLogIn_TextLonInBtn", nil) forState:UIControlStateNormal];
    logIn.layer.cornerRadius = [ApplicationStyle control_weight:35];
    logIn.layer.masksToBounds = YES;
    [logIn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
    [logIn addTarget:self action:@selector(logInDown) forControlEvents:UIControlEventTouchUpInside];
    logIn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:logIn];
    
    
    NSArray *arrLab = @[@"忘记密码",@"注册"];
    
    for (NSInteger i=0; i<arrLab.count; i++) {
        UIButton *mangerNumber = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        mangerNumber.frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:480])/2 + i * ([ApplicationStyle control_weight:480]/2 + [ApplicationStyle control_height:130]) , logIn.bottomOffset + [ApplicationStyle control_height:20], [ApplicationStyle control_height:130], [ApplicationStyle control_height:30]);
        [mangerNumber setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
        [mangerNumber setTitle:arrLab[i] forState:UIControlStateNormal];
        [mangerNumber addTarget:self action:@selector(mangetNumber:) forControlEvents:UIControlEventTouchUpInside];
        mangerNumber.tag = MANGERTAG + i;
        [self.view addSubview:mangerNumber];
    }
    
    CGSize thirpParty = [ApplicationStyle textSize:NSLocalizedString(@"NLLogIn_LogInUser_ThirdLog", nil) font:[ApplicationStyle textSuperSmallFont] size:[ApplicationStyle screenWidth]];
    
    UILabel *labThirp  = nil;
    for (NSInteger i =0 ; i<2 ; i++) {
        labThirp = [[UILabel alloc] initWithFrame:CGRectMake(([ApplicationStyle screenWidth] - thirpParty.width)/2, logIn.bottomOffset + [ApplicationStyle control_height:229], thirpParty.width, [ApplicationStyle control_height:30])];
        labThirp.text = NSLocalizedString(@"NLLogIn_LogInUser_ThirdLog",nil);
        labThirp.font = [ApplicationStyle textSuperSmallFont];
        labThirp.textColor = [ApplicationStyle subjectWithColor];
        [self.view  addSubview:labThirp];
        
        UIView *viewLines = [[UIView alloc] initWithFrame:CGRectMake(labThirp.leftSidePosition - [ApplicationStyle control_weight:178] - [ApplicationStyle control_weight:15] + i*(thirpParty.width + [ApplicationStyle control_weight:178] + [ApplicationStyle control_weight:15]*2), logIn.bottomOffset + [ApplicationStyle control_height:239], [ApplicationStyle control_weight:178], [ApplicationStyle control_height:2])];
        viewLines.backgroundColor = [ApplicationStyle    subjectWithColor];
        [self.view  addSubview:viewLines];
    }
    
    
    NSArray *arrLogInImage = @[@"NLLoing_Thrid_QQ",@"NLLoing_Thrid_WX",@"NLLoing_Thrid_WB"];
    
    
    for (NSInteger i =0 ; i<arrLogInImage.count; i++) {
        UIButton *thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat weight = (SCREENWIDTH - [ApplicationStyle control_weight:68 * 2]);

        thirdBtn.frame = CGRectMake([ApplicationStyle control_weight:68] + i * ([ApplicationStyle control_weight:80] + (weight - [ApplicationStyle control_weight:80 * 3])/3 + (weight - [ApplicationStyle control_weight:80 * 3])/3/2),
                                    labThirp.bottomOffset + [ApplicationStyle control_height:60], [ApplicationStyle control_weight:80],
                                    [ApplicationStyle control_weight:80]);
//        thirdBtn.backgroundColor = [UIColor redColor];
        thirdBtn.tag = THIRDBTNTAG + i;
        [thirdBtn setImage:[UIImage imageNamed:arrLogInImage[i]] forState:UIControlStateNormal];
        [thirdBtn addTarget:self action:@selector(thirdBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:thirdBtn];
    }
    
    
    
}
#pragma mark 系统Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}
#pragma mark 自己的Delegate
#pragma mark 自己的按钮事件
-(void)logInDown{
    UITextField *textPhone = (UITextField *)[self.view viewWithTag:TEXT_TAG];
    UITextField *textPassWord = (UITextField *)[self.view viewWithTag:TEXT_TAG + 1];
    
    [textPhone resignFirstResponder];
    [textPassWord resignFirstResponder];
    
    if (textPhone.text.length == 0) {
       [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"请输入手机号"];
        return;
    }
    if (![ApplicationStyle PhoteFormat:textPhone.text]) {
        [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"手机格式不对"];
        return;
    }
    if (textPassWord.text.length == 0) {
        [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"请输入密码"];
        return;
    }
    [[NLDatahub sharedInstance] userSignInPhone:[NSString stringWithFormat:@"%@",textPhone.text]
                                        password:[NSString stringWithFormat:@"%@",textPassWord.text]];
    
}
-(void)mangetNumber:(UIButton *)btn{
    switch (btn.tag) {
        case MANGERTAG:
        {
            NLForgetPasswordViewController *vc = [[NLForgetPasswordViewController alloc] init];
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case MANGERTAG + 1:
        {
            NLRegisteredViewController *vc =[[NLRegisteredViewController alloc] init];
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}

-(void)thirdBtnDown:(UIButton *)btn{
    
    
//    [kAPPDELEGATE AutoDisplayAlertView:@"温馨提示" :@"暂未开放使用"];
    
    
    
    
    
    switch (btn.tag - THIRDBTNTAG) {
        case 0:
        {

            if ([TencentOAuth iphoneQQInstalled]) {
                //  qq
                UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
                
                snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                    
                    //          获取微博用户名、uid、token等
                    
                    if (response.responseCode == UMSResponseCodeSuccess) {
                        
                        UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
                        
                        
                        NSDictionary *dic =@{@"openId":snsAccount.usid,@"type":Third_QQ,@"platform":@"ios"};
                        [_userInformation setValue:snsAccount.userName forKey:@"name"];
                        [[NLDatahub sharedInstance] thirdLogin:dic];
                        
                        
                        //                    NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                        
                    }});
            }else{
                [kAPPDELEGATE AutoDisplayAlertView:@"提示：" :@"你还没有安装QQ哦~"];
            }

           
            
            break;
        }
        case 1:
        {
            
            if ([WXApi isWXAppInstalled]) {
                //    WeChat
                UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
                
                snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                    
                    if (response.responseCode == UMSResponseCodeSuccess) {
                        
                        UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
                        NSDictionary *dic =@{@"openId":snsAccount.usid,@"type":Third_WeCha,@"platform":@"ios"};
                        [_userInformation setValue:snsAccount.userName forKey:@"name"];
                        [[NLDatahub sharedInstance] thirdLogin:dic];
                        
                        //                    NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                        
                    }
                    
                });
            }else{
                [kAPPDELEGATE AutoDisplayAlertView:@"提示：" :@"你还没有安装微信哦~"];
            }
            
            
            
            break;
        }
        case 2:
        {
            
            [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"暂不支持微博登录哦~"];
            return;
            
            if ([WeiboSDK isWeiboAppInstalled]) {
                //微博
                
                UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
                
                snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                    
                    //          获取微博用户名、uid、token等
                    
                    if (response.responseCode == UMSResponseCodeSuccess) {
                        
                        UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                        [_userInformation setValue:snsAccount.userName forKey:@"name"];
                        NSDictionary *dic =@{@"openId":snsAccount.usid,@"type":Third_Weibo,@"platform":@"ios"};
                        [[NLDatahub sharedInstance] thirdLogin:dic];
                        //                    NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                        
                    }
                });
            }else{
                [kAPPDELEGATE AutoDisplayAlertView:@"提示：" :@"你还没有安装微博哦~"];
            }
            
            
            
            break;
        }
        default:
            break;
    }
  
}

#pragma mark 通知

-(void)addNotification{
    NSNotificationCenter *notifi= [NSNotificationCenter defaultCenter];
    [notifi addObserver:self selector:@selector(logInSuccess:) name:NLLogInSuccessNotification object:nil];
    [notifi addObserver:self selector:@selector(logInFicaled) name:NLLogInFailedNotiFicaledtion object:nil];
    [notifi addObserver:self selector:@selector(getCycleOrPeriod:) name:NLGetCycleOrPeriodSuccessNotification object:nil];
    [notifi addObserver:self selector:@selector(thirdLoginSuccess:) name:NLThirdLoginSuccessNotification object:nil];
    [notifi addObserver:self selector:@selector(thirdLoginFalieds) name:NLThirdLoginFicaledNotification object:nil];
    
}
-(void)logInSuccess:(NSNotification *)notifi{
    NSDictionary *dic = notifi.object;
     
    [kAPPDELEGATE._loacluserinfo SetUser_ID:[dic objectForKey:@"consumerId"]];
    [kAPPDELEGATE._loacluserinfo SetUserAccessToken:[dic objectForKey:@"authToken"]];

    [_userInformation setValue:[[dic objectForKey:@"consumer"] objectForKey:@"header"]==nil?@"":[[dic objectForKey:@"consumer"] objectForKey:@"header"] forKey:@"imageUrl"];
    [_userInformation setValue:[[dic objectForKey:@"consumer"] objectForKey:@"name"]==nil?@"":[[dic objectForKey:@"consumer"] objectForKey:@"name"] forKey:@"userName"];
    [_userInformation setValue:[[dic objectForKey:@"consumer"] objectForKey:@"age"]==nil?@"":[[dic objectForKey:@"consumer"] objectForKey:@"age"] forKey:@"age"];
    [_userInformation setValue:[[dic objectForKey:@"consumer"] objectForKey:@"height"]==nil?@"":[[dic objectForKey:@"consumer"] objectForKey:@"height"] forKey:@"height"];
    [_userInformation setValue:[[dic objectForKey:@"consumer"] objectForKey:@"weight"]==nil?@"":[[dic objectForKey:@"consumer"] objectForKey:@"weight"] forKey:@"width"];
    [_userInformation setValue:[[dic objectForKey:@"consumer"] objectForKey:@"gender"]==nil?@"":[[dic objectForKey:@"consumer"] objectForKey:@"gender"] forKey:@"gender"];
    [kAPPDELEGATE._loacluserinfo userLogInTime:[[dic objectForKey:@"consumer"] objectForKey:@"created"]];
    
    if ([[[dic objectForKey:@"consumer"] objectForKey:@"gender"] isEqual:[NSNull null]]|| [[dic objectForKey:@"consumer"] objectForKey:@"gender"]==nil) {
        NLGenderSelectionViewController *vc = [[NLGenderSelectionViewController alloc] init];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        
        //暂时隐藏
//        [kAPPDELEGATE._loacluserinfo userLogInTime:[ApplicationStyle datePickerTransformationCorss:[NSDate dateWithTimeIntervalSince1970:[[[dic objectForKey:@"consumer"] objectForKey:@"created"] integerValue]/1000]]];
        [kAPPDELEGATE._loacluserinfo userGender:[[dic objectForKey:@"consumer"] objectForKey:@"gender"]];
        [[NLDatahub sharedInstance] getUserCycleOrperiod];
    }

//    NLGenderSelectionViewController *vc = [[NLGenderSelectionViewController alloc] init];
//    [vc setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:vc animated:YES];
}

-(void)logInFicaled{
    [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"账号或密码错误"];
}
-(void)getCycleOrPeriod:(NSNotification *)notifi{
    NSDictionary *dic = notifi.object;
    [_userInformation setValue:[dic objectForKey:@"cycle"] forKey:@"cycleTime"];
    [_userInformation setValue:[dic objectForKey:@"duration"] forKey:@"periodTime"];
    [PlistData individuaData:_userInformation];
    [kAPPDELEGATE._loacluserinfo lastTimeGoPeriodDate:[dic objectForKey:@"startDate"]];
    
//    [kAPPDELEGATE._loacluserinfo userGender:[[dic objectForKey:@"consumer"] objectForKey:@"gender"]];
    [kAPPDELEGATE._loacluserinfo goControllew:@"1"];//进入哪个试图
    if ([[_userInformation objectForKey:@"gender"] isEqualToString:@"0"]) {
        [kAPPDELEGATE tabBarViewControllerType:Controller_WoManMain];
    }else{
        [kAPPDELEGATE tabBarViewControllerType:Controller_MaleMain];
    }
    [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"登录成功"];
    

    


    

}

-(void)userInformationF{
    
}

//第三方登录成功
-(void)thirdLoginSuccess:(NSNotification *)notifi{
    NSDictionary *dic = notifi.object;

    [kAPPDELEGATE._loacluserinfo SetUser_ID:[dic objectForKey:@"consumerId"]];
    [kAPPDELEGATE._loacluserinfo SetUserAccessToken:[dic objectForKey:@"authToken"]];
    [_userInformation setValue:[[dic objectForKey:@"consumer"] objectForKey:@"header"] forKey:@"imageUrl"];
    [_userInformation setValue:[[dic objectForKey:@"consumer"] objectForKey:@"name"] forKey:@"userName"];
    [_userInformation setValue:[[dic objectForKey:@"consumer"] objectForKey:@"age"] forKey:@"age"];
    [_userInformation setValue:[[dic objectForKey:@"consumer"] objectForKey:@"height"] forKey:@"height"];
    [_userInformation setValue:[[dic objectForKey:@"consumer"] objectForKey:@"weight"] forKey:@"width"];
    [kAPPDELEGATE._loacluserinfo userLogInTime:[[dic objectForKey:@"consumer"] objectForKey:@"created"]];
    [PlistData individuaData:_userInformation];
    
    if ([[[dic objectForKey:@"consumer"] objectForKey:@"gender"] isEqual:[NSNull null]]|| [[dic objectForKey:@"consumer"] objectForKey:@"gender"]==nil) {
        NLGenderSelectionViewController *vc = [[NLGenderSelectionViewController alloc] init];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];

    }else{
        [_userInformation setValue:[[dic objectForKey:@"consumer"] objectForKey:@"gender"] forKey:@"gender"];
        [kAPPDELEGATE._loacluserinfo userGender:[[dic objectForKey:@"consumer"] objectForKey:@"gender"]];//测试中
        [[NLDatahub sharedInstance] getUserCycleOrperiod];
        
//        [kAPPDELEGATE._loacluserinfo goControllew:@"1"];
//        if ([[[dic objectForKey:@"consumer"] objectForKey:@"gender"] isEqualToString:@"0"]) {
//            [kAPPDELEGATE tabBarViewControllerType:Controller_WoManMain];
//        }else{
//            [kAPPDELEGATE tabBarViewControllerType:Controller_MaleMain];
//        }
//        [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"登录成功"];
    }
}
//第三放登录失败
-(void)thirdLoginFalieds{
    
}
-(void)delNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITextField *text = (UITextField *)[self.view viewWithTag:3000];
    [text endEditing:YES];
    UITextField *text1 = (UITextField *)[self.view viewWithTag:3001];
    [text1 endEditing:YES];
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
