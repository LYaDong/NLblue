//
//  NLWarmanAgreement.m
//  NBlue
//
//  Created by LYD on 16/3/7.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLWarmanAgreement.h"
#import "NLShareView.h"
@interface NLWarmanAgreement ()<UIWebViewDelegate>

@end

@implementation NLWarmanAgreement

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titles.text = NSLocalizedString(@"NLAboutNL_UserAgreement", nil);
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
    
    NLShareView *share = [[NLShareView alloc] initWithFrame:CGRectMake(0, 200, SCREENWIDTH, [ApplicationStyle control_height:300])];
    [self.view addSubview:share];
    
    
//    [[SMProgressHUD shareInstancetype] showLoading];
//    NSURL *url = [NSURL URLWithString:@"http://www.nuanlan.love/copyright/useragreement.html"];
//    UIWebView *weiView = [[UIWebView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle navBarAndStatusBarSize], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle navBarAndStatusBarSize])];
//    weiView.scalesPageToFit = YES;
//    weiView.delegate = self;
//    [weiView loadRequest:[NSURLRequest requestWithURL:url]];
//    [self.view addSubview:weiView];
}
#pragma mark 系统Delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    [[SMProgressHUD shareInstancetype] dismiss];
}
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
