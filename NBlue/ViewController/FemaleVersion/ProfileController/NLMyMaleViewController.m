//
//  NLMyMaleViewController.m
//  NBlue
//
//  Created by LYD on 16/1/12.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLMyMaleViewController.h"
#import "NLQRCodeViewController.h"
@interface NLMyMaleViewController ()

@end

@implementation NLMyMaleViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    {
        self.navBarBack.hidden = YES;
        self.navBarPushBack.hidden = NO;
        self.controllerBack.hidden = YES;
    }
    
    self.view.backgroundColor = [ApplicationStyle subjectBackViewColor];
    self.titles.text = NSLocalizedString(@"NLProfileView_MyMale", nil);
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
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle statusBarSize]- [ApplicationStyle navigationBarSize])];
    imageView.image = [UIImage imageNamed:@"NL_M_Male_B"];
    [self.view addSubview:imageView];
    
    
    
    
//    UIImageView *expressionImg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:164])/2, [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize]+[ApplicationStyle control_height:238], [ApplicationStyle control_weight:164], [ApplicationStyle control_height:170])];
//    expressionImg.image = [UIImage imageNamed:@"NL_Pro_Male_Expression"];
//    [self.view addSubview:expressionImg];
//
//    CGSize textCountSize = [ApplicationStyle textSize:NSLocalizedString(@"NLProfileView_MaleTextCount", nil) font:[ApplicationStyle textThrityFont] size:SCREENWIDTH];
//    
//    UILabel *textCount = [[UILabel alloc] initWithFrame:CGRectMake(0, expressionImg.bottomOffset+[ApplicationStyle control_height:108], SCREENWIDTH, textCountSize.height)];
//    textCount.text = NSLocalizedString(@"NLProfileView_MaleTextCount", nil);
//    textCount.numberOfLines  = 0;
//    textCount.font = [ApplicationStyle textThrityFont];
//    textCount.textAlignment = NSTextAlignmentCenter;
//    textCount.textColor = [@"535353" hexStringToColor];
//    [self.view addSubview:textCount];
//    
//    UIButton *sweepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    sweepBtn.frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:300])/2, textCount.bottomOffset + [ApplicationStyle control_height:48], [ApplicationStyle control_weight:300], [ApplicationStyle control_height:80]);
//    [sweepBtn setImage:[UIImage imageNamed:@"NL_Pro_Male_SYS"] forState:UIControlStateNormal];
//    [sweepBtn setImage:[UIImage imageNamed:@"NL_Pro_Male_SYS_X"] forState:UIControlStateHighlighted];
//    sweepBtn.layer.cornerRadius = [ApplicationStyle control_weight:10];
//    [sweepBtn addTarget:self action:@selector(sweepBtnDown) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:sweepBtn];
//    
//    CGSize textSize = [ApplicationStyle textSize:NSLocalizedString(@"NLProfileView_MaleText", nil) font:[UIFont systemFontOfSize:[ApplicationStyle control_weight:24]] size:SCREENWIDTH];
//    
//    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - textSize.height - [ApplicationStyle control_height:40], SCREENWIDTH, textSize.height)];
//    text.text = NSLocalizedString(@"NLProfileView_MaleText", nil);
//    text.textColor = [@"570707" hexStringToColor];
//    text.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:24]];
//    text.numberOfLines = 0;
//    text.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:text];

    
}
#pragma mark 系统Delegate
#pragma mark 自己的Delegate
#pragma mark 自己的按钮事件
-(void)sweepBtnDown{
    NLQRCodeViewController *vc = [[NLQRCodeViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    vc.qrCount = ^(NSString *from_to_Assto0ken){
        [self nextQRCode:from_to_Assto0ken];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)nextQRCode:(NSString *)text{
    [[NLDatahub sharedInstance] qrCodeNextWorkFrom_to_id:text];
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
