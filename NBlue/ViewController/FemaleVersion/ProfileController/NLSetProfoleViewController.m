//
//  NLSetProfoleViewController.m
//  NBlue
//
//  Created by LYD on 15/12/25.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLSetProfoleViewController.h"
#import "NLSetProfileCell.h"
@interface NLSetProfoleViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,assign)NSInteger isLogIn;
@end

@implementation NLSetProfoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    {
        self.navBarBack.hidden = YES;
        self.navBarPushBack.hidden = NO;
        self.controllerBack.hidden = YES;
    }
    
    self.view.backgroundColor = [ApplicationStyle subjectBackViewColor];
    self.titles.text = NSLocalizedString(@"NLSetProfile_Set", nil);
    
    
    
    
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

    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle navigationBarSize] - [ApplicationStyle statusBarSize]) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _mainTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_mainTableView];
}
#pragma mark 系统Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ApplicationStyle control_height:128];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"LYD";
    NLSetProfileCell *cell = [tableView  dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[NLSetProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        

        
    }
    NSArray *cellLab = @[NSLocalizedString(@"NLSetProfile_CallRemid", nil),
                         NSLocalizedString(@"NLSetProfile_GOScore", nil),
                         NSLocalizedString(@"NLSetProfile_SecurityEiet", nil)];
    cell.cellTitleLab.text = cellLab[indexPath.row];
    
    if (indexPath.row==2) {
        cell.cellTitleLab.textAlignment = NSTextAlignmentCenter;
        cell.cellImage.hidden = YES;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            break;
        }
        case 1:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_Story_URL]];
            break;
        }
        case 2:
        {
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"温馨提醒" message:@"你确定要退出登录么！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"确定", nil];
            al.delegate = self;
            [al show];
            
            break;
        }
        default:
            break;
    }
    
}
#pragma mark 自己的Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [kAPPDELEGATE._loacluserinfo SetUser_ID:@""];
        [kAPPDELEGATE._loacluserinfo SetUserAccessToken:@""];
        [kAPPDELEGATE._loacluserinfo goControllew:@"0"];
        [kAPPDELEGATE tabBarViewControllerType:Controller_Loing];
        [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"退出成功"];
    }
}
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
