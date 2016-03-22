//
//  NLMaleProfileViewController.m
//  NBlue
//
//  Created by LYD on 16/1/6.
//  Copyright © 2016年 LYD. All rights reserved.
//
static NSInteger NAVBTNTAG = 1000;
#import "NLMaleProfileViewController.h"
#import "NLProTableCell.h"
#import "NLFeedBackViewController.h"
#import "NLAboutNLViewController.h"
#import "NLMyEquipmentController.h"
#import "NLShareController.h"
#import "NLMaleIndividuaViewController.h"
#import "NLMaleNBLuePlanViewController.h"
#import "NLMyMessageViewController.h"
#import <UIImageView+WebCache.h>
#import "NLIndividuaFormatViewController.h"
@interface NLMaleProfileViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)UIButton *userHeadBtn;
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *userNameLab;
@end

@implementation NLMaleProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.navBarMaleBack.hidden = YES;
    [self notification];
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
    
    UIImageView *imageBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    imageBack.image = [UIImage imageNamed:@"NLMaleProBack"];
    [self.view addSubview:imageBack];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, [ApplicationStyle statusBarSize], SCREENWIDTH, [ApplicationStyle navigationBarSize])];
    title.textColor = [ApplicationStyle subjectWithColor];
    title.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:36]];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = NSLocalizedString(@"TabBar_Profile", nil);
    [self.view addSubview:title];
    

    for (NSInteger i=0; i<2; i++) {
        UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        navBtn.frame = CGRectMake([ApplicationStyle control_weight:36] + i * (SCREENWIDTH - [ApplicationStyle control_weight:36*2 + 48]), [ApplicationStyle statusBarSize] + ([ApplicationStyle navigationBarSize]-[ApplicationStyle control_height:48])/2, [ApplicationStyle control_weight:48], [ApplicationStyle control_height:48]);
        if (i==0) {
            [navBtn setImage:[UIImage imageNamed:@"NL_Male_Pro_Message"] forState:UIControlStateNormal];
        }else{
            navBtn.frame = CGRectMake([ApplicationStyle control_weight:36] + i * (SCREENWIDTH - [ApplicationStyle control_weight:36*2 + 62]), [ApplicationStyle statusBarSize] + ([ApplicationStyle navigationBarSize]-[ApplicationStyle control_height:62])/2, [ApplicationStyle control_weight:62], [ApplicationStyle control_height:48]);
            [navBtn setTitle:NSLocalizedString(@"TabBar_Male_SignIn", nil) forState:UIControlStateNormal];
            [navBtn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
            navBtn.titleLabel.font = [ApplicationStyle textThrityFont];
        }
        navBtn.tag = NAVBTNTAG+i;
        [navBtn addTarget:self action:@selector(navBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:navBtn];
    }
    
    NSDictionary *dicImage = [PlistData getIndividuaData];
    _userHeadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _userHeadBtn.frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:128])/2, [ApplicationStyle control_height:30]+[ApplicationStyle navBarAndStatusBarSize], [ApplicationStyle control_weight:128], [ApplicationStyle control_weight:128]);
    [_userHeadBtn addTarget:self action:@selector(userHeadBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_userHeadBtn];
    
    _headImage = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:128])/2, [ApplicationStyle control_height:30]+[ApplicationStyle navBarAndStatusBarSize], [ApplicationStyle control_weight:128], [ApplicationStyle control_weight:128])];
    [_headImage sd_setImageWithURL:[NSURL URLWithString:[dicImage objectForKey:@"imageUrl"]] placeholderImage:[UIImage imageNamed:@"User_Head"]];
    _headImage.layer.cornerRadius = [ApplicationStyle control_weight:128]/2;
    _headImage.layer.borderWidth = [ApplicationStyle control_weight:3];
    _headImage.layer.borderColor = [UIColor whiteColor].CGColor;
    _headImage.clipsToBounds = YES;
    [self.view addSubview:_headImage];
    
    CGSize ss = [ApplicationStyle textSize:[dicImage objectForKey:@"userName"] font:[ApplicationStyle textThrityFont] size:SCREENWIDTH];
    _userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _headImage.bottomOffset + [ApplicationStyle control_height:26], SCREENWIDTH, ss.height)];
    _userNameLab.font = [ApplicationStyle textThrityFont];
    _userNameLab.text = [dicImage objectForKey:@"userName"];
    _userNameLab.textAlignment = NSTextAlignmentCenter;
    _userNameLab.textColor = [UIColor whiteColor];
    [self.view addSubview:_userNameLab];
    
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle control_height:410], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle tabBarSize] - [ApplicationStyle control_height:410]) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_mainTableView];
}
-(void)notification{
    NSNotificationCenter *userHeadImageNotifi= [NSNotificationCenter defaultCenter];
    [userHeadImageNotifi addObserver:self selector:@selector(userHeadImageNotifiDown) name:RefreshUserHeadImageMaleIndividSuccessNotification object:nil];
}
#pragma mark 系统Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ApplicationStyle control_height:88];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *nlProTableCell = @"NLProTableCell";
    NLProTableCell *cell = [tableView dequeueReusableCellWithIdentifier:nlProTableCell];
    if (!cell) {
        cell = [[NLProTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nlProTableCell];
    }
    
    
    NSArray *cellLabArray = @[NSLocalizedString(@"NLMaleProfile_Myequipment", nil),
                              NSLocalizedString(@"NLMaleProfile_Share", nil),
                              NSLocalizedString(@"NLMaleProfile_FeedBack", nil),
                              NSLocalizedString(@"NLMaleProfile_Set", nil),
                              NSLocalizedString(@"NLMaleProfile_AboutNBlue", nil)];
    
    NSArray *cellImageArray = @[@"NL_Male_M_Equ",@"NL_Male_Share",@"NL_Male_Feedback",@"NL_Male_Set",@"NL_Male_About_NL"];
    cell.cellImages.image = [UIImage imageNamed:cellImageArray[indexPath.row]];
    cell.cellLabs.text = cellLabArray[indexPath.row];
    cell.imageArrow.image = [UIImage imageNamed:@"NL_Male_lightArrow"];
    cell.line.backgroundColor = [@"d7d7d7" hexStringToColor];

    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *viewControllerArray = @[@"NLMyEquipmentController",
                                     @"NLShareController",
                                     @"NLFeedBackViewController",
                                     @"NLMaleIndividuaViewController",
                                     @"NLAboutNLViewController"];
    
    UIViewController *viewcontroller = [[NSClassFromString(viewControllerArray[indexPath.row]) alloc] init];
    [viewcontroller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewcontroller animated:YES];
    
}
#pragma mark 自己的Delegate
#pragma mark 自己的按钮事件
-(void)navBtnDown:(UIButton *)btn{
    switch (btn.tag - NAVBTNTAG) {
        case 0:
        {
            NLMyMessageViewController *vc = [[NLMyMessageViewController alloc] init];
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:
        {
            NSLog(@"签到");
            break;
        }
        default:
            break;
    }
}
-(void)userHeadBtnDown{
    NLIndividuaFormatViewController *vc = [[NLIndividuaFormatViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)userHeadImageNotifiDown{
    NSDictionary *dicImage = [PlistData getIndividuaData];
    [_headImage sd_setImageWithURL:[NSURL URLWithString:[dicImage objectForKey:@"imageUrl"]] placeholderImage:[UIImage imageNamed:@"User_Head"]];
    _userNameLab.text = [dicImage objectForKey:@"userName"];
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
