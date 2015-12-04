//
//  SubRootViewController.m
//  NBlue
//
//  Created by LYD on 15/11/23.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLSubRootViewController.h"
#import "NLAboutImageBtn.h"
@interface NLSubRootViewController ()

@end

@implementation NLSubRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initBulidUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark 基础UI
-(void)initBulidUI{

    
    
    [self navCorllew];
    self.controllerBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    self.controllerBack.image = [UIImage imageNamed:@"RootContorllewImage"];
    [self.view addSubview:self.controllerBack];
    
    self.navBarBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize])];
    self.navBarBack.backgroundColor = [ApplicationStyle subjectNavBarBackColor];
    self.navBarBack.alpha = 0.5;
    [self.view addSubview:self.navBarBack];
    
    UIView *nabStroke = [UIView statusBackView:CGRectMake(0, [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize] - [ApplicationStyle control_height:5], SCREENWIDTH, [ApplicationStyle control_height:5])];
    nabStroke.alpha = 0.15 + 0.25;
    [self.navBarBack addSubview:nabStroke];
    
    self.navBarPushBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle navigationBarSize] + [ApplicationStyle navigationBarSize])];
    self.navBarPushBack.hidden = YES;
    self.navBarPushBack.backgroundColor = [ApplicationStyle subJectNavBarColor];
    [self.view addSubview:self.navBarPushBack];
    
    
    self.titles = [[UILabel alloc] initWithFrame:CGRectMake(0, [ApplicationStyle statusBarSize], SCREENWIDTH, [ApplicationStyle navigationBarSize])];
    self.titles.textAlignment = NSTextAlignmentCenter;
    self.titles.textColor = [UIColor whiteColor];
    self.titles.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:36]];
    [self.view addSubview:self.titles];
    
    self.returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.returnBtn.frame = CGRectMake(0, [ApplicationStyle statusBarSize] + ([ApplicationStyle navigationBarSize] - [ApplicationStyle control_height:63])/2, [ApplicationStyle control_weight:36] + [ApplicationStyle control_weight:34], [ApplicationStyle control_height:63]);
    [self.returnBtn setImage:[UIImage imageNamed:@"Return_Image"] forState:UIControlStateNormal];
    [self.returnBtn addTarget:self action:@selector(returnBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.returnBtn];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(SCREENWIDTH - ([ApplicationStyle control_weight:36] + [ApplicationStyle control_weight:34]) - [ApplicationStyle control_weight:34],[ApplicationStyle statusBarSize] + ([ApplicationStyle navigationBarSize] - [ApplicationStyle control_height:63])/2, [ApplicationStyle control_weight:36] + [ApplicationStyle control_weight:34], [ApplicationStyle control_height:63]);
    [self.rightBtn addTarget:self action:@selector(rightBtnDown) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn.hidden = YES;
    [self.view addSubview:self.rightBtn];
    
}

-(void)navCorllew{
    self.navigationController.navigationBar.hidden = YES;
}
-(void)returnBtnDown{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBtnDown{
    
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
