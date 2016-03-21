//
//  NLMyMaleViewController.m
//  NBlue
//
//  Created by LYD on 16/1/12.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLMyMaleViewController.h"
#import "NLQRCodeViewController.h"
#import "NLMyMaleSetViewController.h"
@interface NLMyMaleViewController ()
@property(nonatomic,strong)UIView *sweepView;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)NSString *setMaleID;

@end

@implementation NLMyMaleViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.view.backgroundColor = [ApplicationStyle subjectBackViewColor];
    self.titles.text = NSLocalizedString(@"NLProfileView_MyMale", nil);
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
    [[NLDatahub sharedInstance] maleJudgeIsHave];
//    [self scanCodeUI];
}
-(void)scanCodeUI{
    _sweepView = [[UIView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle navBarAndStatusBarSize], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle navBarAndStatusBarSize])];
    [self.view addSubview:_sweepView];
    
    UIImageView *expressionImg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:500])/2,[ApplicationStyle statusBarSize]+[ApplicationStyle control_height:100], [ApplicationStyle control_weight:500],[ApplicationStyle control_weight:500])];
    expressionImg.image = [UIImage imageNamed:@"NL_Pro_Male_Expression"];
    [_sweepView addSubview:expressionImg];
    
    CGSize textCountSize = [ApplicationStyle textSize:NSLocalizedString(@"NLProfileView_MaleTextCount", nil) font:[ApplicationStyle textThrityFont] size:SCREENWIDTH];
    
    UILabel *textCount = [[UILabel alloc] initWithFrame:CGRectMake(0, expressionImg.bottomOffset+[ApplicationStyle control_height:108], SCREENWIDTH, textCountSize.height)];
    textCount.text = NSLocalizedString(@"NLProfileView_MaleTextCount", nil);
    textCount.numberOfLines  = 0;
    textCount.font = [ApplicationStyle textThrityFont];
    textCount.textAlignment = NSTextAlignmentCenter;
    textCount.textColor = [@"535353" hexStringToColor];
    [_sweepView addSubview:textCount];
    
    UIButton *sweepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sweepBtn.frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:300])/2, textCount.bottomOffset + [ApplicationStyle control_height:48], [ApplicationStyle control_weight:300], [ApplicationStyle control_height:80]);
    [sweepBtn setImage:[UIImage imageNamed:@"NL_Pro_Male_SYS"] forState:UIControlStateNormal];
    [sweepBtn setImage:[UIImage imageNamed:@"NL_Pro_Male_SYS_X"] forState:UIControlStateHighlighted];
    sweepBtn.layer.cornerRadius = [ApplicationStyle control_weight:10];
    [sweepBtn addTarget:self action:@selector(sweepBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [_sweepView addSubview:sweepBtn];
    
    CGSize textSize = [ApplicationStyle textSize:NSLocalizedString(@"NLProfileView_MaleText", nil) font:[UIFont systemFontOfSize:[ApplicationStyle control_weight:24]] size:SCREENWIDTH];
    
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - [ApplicationStyle navBarAndStatusBarSize] - textSize.height - [ApplicationStyle control_height:40], SCREENWIDTH, textSize.height)];
    text.text = NSLocalizedString(@"NLProfileView_MaleText", nil);
    text.textColor = [@"570707" hexStringToColor];
    text.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:24]];
    text.numberOfLines = 0;
    text.textAlignment = NSTextAlignmentCenter;
    [_sweepView addSubview:text];
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

-(void)addNotification{
    NSNotificationCenter *notifi= [NSNotificationCenter defaultCenter];
    [notifi addObserver:self selector:@selector(success:) name:NLFolkSuccessNotification object:nil];
    [notifi addObserver:self selector:@selector(ficaled) name:NLFolkFicaledNotification object:nil];
    [notifi addObserver:self selector:@selector(bindingSuccess) name:NLMaleBindingSuccessNotification object:nil];
    [notifi addObserver:self selector:@selector(bindingFicaled) name:NLMaleBindingFicaledNotification object:nil];
}
-(void)success:(NSNotification *)notifi{
    if (notifi.object == nil) {
        [self scanCodeUI];
    }else{
        NSLog(@"%@",notifi.object);
        
        _setMaleID = [notifi.object[0] objectForKey:@"id"];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle statusBarSize]- [ApplicationStyle navigationBarSize])];
        _imageView.image = [UIImage imageNamed:@"NL_M_Male_B"];
        [self.view addSubview:_imageView];
        
        UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        setBtn.frame = CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:73 + 30], [ApplicationStyle statusBarSize] + ([ApplicationStyle navBarAndStatusBarSize] - [ApplicationStyle control_height:44])/2, [ApplicationStyle control_weight:73], [ApplicationStyle control_height:44]);
        [setBtn setTitle:NSLocalizedString(@"NLProfileView_Set", nil) forState:UIControlStateNormal];
        [setBtn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
        [setBtn addTarget:self action:@selector(dinding) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:setBtn];
    }
}
-(void)ficaled{
    
}
//绑定成功
-(void)bindingSuccess{
    _sweepView.hidden = YES;
}
-(void)bindingFicaled{
    
}

-(void)dinding{
    NLMyMaleSetViewController *vc = [[NLMyMaleSetViewController alloc] init];
    vc.maleID = _setMaleID;
    vc.delMale = ^(NSString *delMale){
        [self bulidUI];
    };
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
    
//    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"NLMyMaleSetViewController" bundle:nil];
//    NLMyMaleSetViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"NLMyMaleSet"];
//    [vc setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:vc animated:YES];
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
