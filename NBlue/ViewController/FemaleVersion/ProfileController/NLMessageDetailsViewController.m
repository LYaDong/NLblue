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
    {
        self.navBarBack.hidden = YES;
        self.navBarPushBack.hidden = NO;
        self.controllerBack.hidden = YES;
    }
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ApplicationStyle subjectBackViewColor];
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
    headTitle.text = self.titleLab;
    headTitle.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:36]];
    headTitle.textColor = [@"313131" hexStringToColor];
    [self.view addSubview:headTitle];
    
    UILabel *headTime = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:222+24], [ApplicationStyle navBarAndStatusBarSize] + [ApplicationStyle control_height:40], [ApplicationStyle control_weight:222], [ApplicationStyle control_height:30])];
    headTime.text = self.timeLab;
    headTime.font = [UIFont  systemFontOfSize:[ApplicationStyle control_weight:28]];
    headTime.textColor = [@"959595" hexStringToColor];
    [self.view addSubview:headTime];
    
    
    CGSize countTextSize = [ApplicationStyle textSize:self.countLab font:[UIFont systemFontOfSize:[ApplicationStyle control_weight:36]] size:SCREENWIDTH - [ApplicationStyle control_weight:24 * 2]];
    
    
    UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:30], headTitle.bottomOffset + [ApplicationStyle control_height:24], countTextSize.width, countTextSize.height)];
    countLab.text = self.countLab;
    countLab.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:36]];
    countLab.numberOfLines = 0;
    countLab.textColor = [@"313131" hexStringToColor];
    [self.view addSubview:countLab];
    
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:30], countLab.bottomOffset + [ApplicationStyle control_height:30], SCREENWIDTH - [ApplicationStyle control_weight:30 * 2], [ApplicationStyle control_height:1])];
    line.backgroundColor = [@"b4f0ff" hexStringToColor];
    [self.view addSubview:line];
    
    
    CGSize promptTextSize = [ApplicationStyle textSize:self.promptLab font:[ApplicationStyle textThrityFont] size:SCREENWIDTH - [ApplicationStyle control_weight:24 * 2]];
    
    UILabel *prompt = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:30], line.bottomOffset+[ApplicationStyle control_height:20], promptTextSize.width, promptTextSize.height)];
    prompt.text = self.promptLab;
    prompt.textColor = [@"959595" hexStringToColor];
    prompt.font = [ApplicationStyle textThrityFont];
    prompt.numberOfLines = 0;
    [self.view addSubview:prompt];
    
    
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
