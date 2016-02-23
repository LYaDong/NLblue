//
//  NLMessageDetailsViewController.m
//  NBlue
//
//  Created by LYD on 16/2/23.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLMessageDetailsViewController.h"

@interface NLMessageDetailsViewController ()

@end

@implementation NLMessageDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titles.text = NSLocalizedString(@"NLProfileView_MyMessage", nil);
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
    UILabel *headTitle = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:30], [ApplicationStyle navBarAndStatusBarSize] + [ApplicationStyle control_height:40], SCREENWIDTH - [ApplicationStyle control_weight:30], [ApplicationStyle control_height:40])];
    headTitle.text = @"暖蓝小助手";
    headTitle.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:36]];
    headTitle.textColor = [@"313131" hexStringToColor];
    [self.view addSubview:headTitle];
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
