//
//  NLGenderSelectionViewController.m
//  NBlue
//
//  Created by LYD on 15/12/29.
//  Copyright © 2015年 LYD. All rights reserved.
//
static const NSUInteger GENDERTAG = 1000;
#import "NLGenderSelectionViewController.h"
#import "NLBodyParamentViewController.h"
@interface NLGenderSelectionViewController ()
@end

@implementation NLGenderSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
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
    NSArray *arrGender = @[NSLocalizedString(@"NLGenderSelection_Male", nil),NSLocalizedString(@"NLGenderSelection_Female", nil)];
    
    for (NSInteger i=0; i<arrGender.count; i++) {
        UIButton *genderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        genderBtn.frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:250])/2, (SCREENHEIGHT - [ApplicationStyle control_height:250 * 2] - [ApplicationStyle control_height:30])/2 + i * [ApplicationStyle control_height:280], [ApplicationStyle control_weight:250], [ApplicationStyle control_weight:250]);
        [genderBtn setTitle:arrGender[i] forState:UIControlStateNormal];
        genderBtn.backgroundColor = [UIColor lightGrayColor];
        genderBtn.layer.cornerRadius = [ApplicationStyle control_weight:250]/2;
        genderBtn.tag = GENDERTAG + i;
        [genderBtn addTarget:self action:@selector(genderDown:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:genderBtn];
    }
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
    if (btn.tag == GENDERTAG) {
        [self alenderView];
        [kAPPDELEGATE._loacluserinfo userGender:@"1"];
    }else{
        [self alenderView];
        [kAPPDELEGATE._loacluserinfo userGender:@"0"];
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
