//
//  NLGenderSelectionViewController.m
//  NBlue
//
//  Created by LYD on 15/12/29.
//  Copyright © 2015年 LYD. All rights reserved.
//
static const NSUInteger GENDERTAG = 1000;
static const NSUInteger NEXTTAG = 2000;
#import "NLGenderSelectionViewController.h"
#import "NLBodyParamentViewController.h"
@interface NLGenderSelectionViewController ()
@property(nonatomic,assign)NSInteger nextInt;
@end

@implementation NLGenderSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [@"d3d3d3" hexStringToColor];
    _nextInt = 0;
    [self prefersStatusBarHidden];
    [self bulidUI];

}
- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark 基础UI
-(void)bulidUI{
    
    UILabel *genderLab = [[UILabel alloc] initWithFrame:CGRectMake(0, [ApplicationStyle control_height:96], SCREENWIDTH, [ApplicationStyle control_height:46])];
    genderLab.text = NSLocalizedString(@"NL_Currency_YouGender", nil);
    genderLab.textColor = [@"4b4b4b" hexStringToColor];
    genderLab.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:48]];
    genderLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:genderLab];
    
    
    
    NSArray *arrGender = @[@"NL_Gender_Cen_Male_X",@"NL_Gender_Cen_Female_X"];
    for (NSInteger i=0; i<arrGender.count; i++) {
        UIButton *genderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        genderBtn.frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:260])/2, genderLab.bottomOffset + [ApplicationStyle control_height:76] + i * [ApplicationStyle control_height:350], [ApplicationStyle control_weight:260], [ApplicationStyle control_weight:260]);
        [genderBtn setImage:[UIImage imageNamed:arrGender[i]] forState:UIControlStateNormal];
//        genderBtn.layer.cornerRadius = [ApplicationStyle control_weight:250]/2;
        genderBtn.tag = GENDERTAG + i;
        [genderBtn addTarget:self action:@selector(genderDown:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:genderBtn];
    }
    
    UIButton *genderBtn = (UIButton *)[self.view viewWithTag:GENDERTAG + 1];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:500])/2, genderBtn.bottomOffset + [ApplicationStyle control_height:136], [ApplicationStyle control_weight:500], [ApplicationStyle control_height:80]);
    [nextBtn setTitle:NSLocalizedString(@"NL_Currency_Next", nil) forState:UIControlStateNormal];
    [nextBtn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
    
    nextBtn.backgroundColor = [@"979797" hexStringToColor];
    nextBtn.layer.cornerRadius = [ApplicationStyle control_weight:45];
    nextBtn.tag = NEXTTAG;
    [self.view addSubview:nextBtn];
    
    
}
- (void)alenderView{
    
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@""
                                                 message:@"性别确定后将无法修改"
                                                delegate:self
                                       cancelButtonTitle:nil
                                       otherButtonTitles:@"在想想",@"我确定", nil];
    [al alertSuccessHandler:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            NLBodyParamentViewController *vc = [[NLBodyParamentViewController  alloc] init];
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
}

#pragma mark 系统Delegate
#pragma mark 自己的Delegate

#pragma mark 自己的按钮事件
-(void)genderDown:(UIButton *)btn{
    
    UIButton *body = (UIButton *)[self.view viewWithTag:GENDERTAG];
    UIButton *female = (UIButton *)[self.view viewWithTag:GENDERTAG + 1];
    
    UIButton *nextBtn = (UIButton *)[self.view viewWithTag:NEXTTAG];
    if (btn.tag == GENDERTAG) {
        [kAPPDELEGATE._loacluserinfo userGender:@"1"];
        [body setImage:[UIImage imageNamed:@"NL_Gender_Cen_Male_X"] forState:UIControlStateNormal];
        [female setImage:[UIImage imageNamed:@"NL_Gender_Cen_Female"] forState:UIControlStateNormal];
        nextBtn.backgroundColor = [@"70b2e2" hexStringToColor];
        self.view.backgroundColor = [@"b7ebff" hexStringToColor];

        _nextInt = 1;
    }else{
        [kAPPDELEGATE._loacluserinfo userGender:@"0"];
        [body setImage:[UIImage imageNamed:@"NL_Gender_Cen_Male"] forState:UIControlStateNormal];
        [female setImage:[UIImage imageNamed:@"NL_Gender_Cen_Female_X"] forState:UIControlStateNormal];
        nextBtn.backgroundColor = [@"ff5b89" hexStringToColor];
        self.view.backgroundColor = [@"ffe3e3" hexStringToColor];
        _nextInt = 1;
    }
    
    [nextBtn addTarget:self action:@selector(nextBtnDown) forControlEvents:UIControlEventTouchUpInside];
}

-(void)nextBtnDown{
    if (!_nextInt == 0) {
        NLBodyParamentViewController *vc = [[NLBodyParamentViewController  alloc] init];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
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
