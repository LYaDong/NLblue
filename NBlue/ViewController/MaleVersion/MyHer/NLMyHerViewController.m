//
//  NLMyHerViewController.m
//  NBlue
//
//  Created by LYD on 16/1/6.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLMyHerViewController.h"
#import "NLMyHerPeriodCircle.h"
@interface NLMyHerViewController ()

@end

@implementation NLMyHerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
    
    self.returnBtn.hidden = YES;
    self.titles.text = NSLocalizedString(@"NLMyHer_titls", nil);
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
//    [self generateQRCode];
    [self periodCircleView];
}
-(void)generateQRCode{
    UIImage *qrcode = [ApplicationStyle createNonInterpolatedUIImageFormCIImage:
                       [ApplicationStyle createQRForString:
                        [kAPPDELEGATE._loacluserinfo GetUser_ID]] withSize:SCREENWIDTH];
    UIImageView *imagex = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    imagex.image =  qrcode;
    imagex.backgroundColor = [UIColor redColor];
    [self.view addSubview:imagex];
}
-(void)periodCircleView{
    NLMyHerPeriodCircle *viewDDD = [[NLMyHerPeriodCircle alloc] initWithFrame:CGRectMake(0, [ApplicationStyle navBarAndStatusBarSize], 300, 300)];
    [self.view addSubview:viewDDD];
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
