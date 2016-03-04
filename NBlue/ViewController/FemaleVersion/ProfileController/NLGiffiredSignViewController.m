//
//  NLGiffiredSignViewController.m
//  NBlue
//
//  Created by LYD on 16/1/12.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLGiffiredSignViewController.h"
#import "NLAboutImageBtn.h"
@interface NLGiffiredSignViewController ()
@property(nonatomic,strong) UILabel *integral;
@end

@implementation NLGiffiredSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    {
//        self.controllerBack.hidden = YES;
//        self.navBarBack.hidden = YES;
//    }


    
    
//    self.titles.textColor = [@"666666" hexStringToColor];
    self.titles.text = NSLocalizedString(@"TabBar_Male_SignIn", nil);
    
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
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle navBarAndStatusBarSize], SCREENWIDTH, SCREENHEIGHT-[ApplicationStyle navBarAndStatusBarSize])];
    imageView.image = [UIImage imageNamed:@"NL_Sign_Back"];
    [self.view addSubview:imageView];
    
    CGRect frame = CGRectMake([ApplicationStyle control_weight:44], [ApplicationStyle navBarAndStatusBarSize] + [ApplicationStyle control_height:26],[ApplicationStyle control_weight:36] , [ApplicationStyle control_height:30]);
    
    UIImageView *glodImg = [[UIImageView alloc] initWithFrame:frame];
    glodImg.image = [UIImage imageNamed:@"NL_Sign_JB"];
    [self.view addSubview:glodImg];
    
    _integral = [[UILabel alloc] initWithFrame:CGRectMake(glodImg.rightSideOffset + [ApplicationStyle control_weight:10], [ApplicationStyle navBarAndStatusBarSize] + [ApplicationStyle control_height:26], SCREENWIDTH - glodImg.rightSideOffset + [ApplicationStyle control_weight:10], [ApplicationStyle control_height:30])];
    _integral.text = @"积分：30000";
    _integral.textColor = [@"666666" hexStringToColor];
    _integral.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:26]];
    [self.view addSubview:_integral];
    
    UIImageView *singIntegral = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:370])/2, [ApplicationStyle navBarAndStatusBarSize] + [ApplicationStyle control_height:26], [ApplicationStyle control_weight:370], [ApplicationStyle control_height:370])];
    singIntegral.image = [UIImage imageNamed:@"NL_Sign_Y_H"];
    [self.view addSubview:singIntegral];
    
    NSString *str = @"男友尚未签到，胆大妄为，给\n他个机会让他补过吧。";
    
    CGSize labMaleTextSize = [ApplicationStyle textSize:str font:[ApplicationStyle textTwentySixFont] size:SCREENWIDTH];
    
    UILabel *labMaleText = [[UILabel alloc] initWithFrame:CGRectMake(0, singIntegral.bottomOffset + [ApplicationStyle control_height:24], SCREENWIDTH, labMaleTextSize.height)];
    labMaleText.textColor = [@"666666" hexStringToColor];
    labMaleText.textAlignment = NSTextAlignmentCenter;
    labMaleText.font = [ApplicationStyle textTwentySixFont];
    labMaleText.numberOfLines = 0;
    labMaleText.text = str;
    [self.view addSubview:labMaleText];
    
    UIButton *singBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    singBtn.frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:300])/2, labMaleText.bottomOffset+[ApplicationStyle control_height:32], [ApplicationStyle control_weight:300], [ApplicationStyle control_height:80]);
    [singBtn setImage:[UIImage imageNamed:@"NL_Sign_TX"] forState:UIControlStateNormal];
    [singBtn setImage:[UIImage imageNamed:@"NL_Sign_TX_X"] forState:UIControlStateHighlighted];
    [self.view addSubview:singBtn];
    
    
    NSString *desribeStr = @"积分规则说明\n\n1、每次签到可获得积分\n绑定了男朋友的女用户在男朋友签到后可以获得额外的积分\n2、男生的积分可以转让给女生\n3、女生可以在拿积分兑换奖励";
    
    CGSize integralDesribeSize = [ApplicationStyle textSize:desribeStr font:[ApplicationStyle textSuperSmallFont] size:SCREENWIDTH - [ApplicationStyle control_weight:44 * 2]];
    
    UILabel *integralDesribeLab = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:44], SCREENHEIGHT - [ApplicationStyle control_height:60] - integralDesribeSize.height, SCREENWIDTH - [ApplicationStyle control_weight:44 * 2], integralDesribeSize.height)];
    integralDesribeLab.text = desribeStr;
    integralDesribeLab.numberOfLines = 0;
    integralDesribeLab.textColor = [@"666666" hexStringToColor];
    integralDesribeLab.font = [ApplicationStyle textSuperSmallFont];
    [self.view addSubview:integralDesribeLab];
    
}
#pragma mark 系统Delegate
#pragma mark 自己的Delegate
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
