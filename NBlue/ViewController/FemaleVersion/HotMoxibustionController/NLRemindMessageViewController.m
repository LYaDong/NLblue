//
//  NLRemindMessageViewController.m
//  NBlue
//
//  Created by LYD on 16/3/14.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLRemindMessageViewController.h"

@interface NLRemindMessageViewController ()

@end

@implementation NLRemindMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titles.text = NSLocalizedString(@"", nil);
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
    [[NLDatahub sharedInstance] remindMessage:@"逗比海天逗比海天逗比海天逗比海天逗比海天逗比海天" type:@"1"];
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
