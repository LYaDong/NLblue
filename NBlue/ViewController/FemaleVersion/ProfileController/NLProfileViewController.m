//
//  ProfileViewController.m
//  NBlue
//
//  Created by LYD on 15/11/23.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLProfileViewController.h"
#import "NLProTableCell.h"
#import "NLIndividuaFormatViewController.h"
#import "NLMyEquipmentController.h"
#import "NLFeedBackViewController.h"
#import "NLAboutNLViewController.h"
#import "NLSetProfoleViewController.h"
#import "NLShareController.h"
#import "NLMyMaleViewController.h"
#import "NLGiffiredSignViewController.h"
#import "UIImageView+WebCache.h"
#import "NLMyMessageViewController.h"
#import "NLShareView.h"
#import <UMSocialWechatHandler.h>
#import <UMSocialDataService.h>
#import <UMSocialSnsPlatformManager.h>
#import <UMSocialAccountManager.h>
#import <WXApi.h>
#import <WeiboSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <UMSocialQQHandler.h>

@interface NLProfileViewController ()<UITableViewDataSource,UITableViewDelegate,NLShareViewDelegate>
@property(nonatomic,strong)UIButton *userHeadImage;
@property(nonatomic,strong)UILabel *userNameLab;
@property(nonatomic,strong)UIImageView *userImage;;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NLShareView *shareView;
@property(nonatomic,strong)UIView *blackBackView;
@end

@implementation NLProfileViewController
//-(void)rightBtnDown{
//    //暂时隐藏
//    NLGiffiredSignViewController *vc = [[NLGiffiredSignViewController alloc] init];
//    [vc setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:vc animated:YES];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.rightBtn.hidden = YES;
    [self.rightBtn setTitle:NSLocalizedString(@"TabBar_Male_SignIn", nil) forState:UIControlStateNormal];
    
//    self.titles.text = NSLocalizedString(@"TabBar_Profile", nil);
    
    
    
    self.navBarBack.hidden = YES;
    self.returnBtn.hidden = YES;
    [self notification];
    [self backViewUI];
    [self liftBtnUI];//后期打开
    [self bulidUI];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)notification{
    NSNotificationCenter *userHeadImageNotifi= [NSNotificationCenter defaultCenter];
    [userHeadImageNotifi addObserver:self selector:@selector(userHeadImageNotifiDown) name:RefreshUserHeadImageSuccessNotification object:nil];
}

#pragma mark 基础UI
-(void)backViewUI{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    imageView.image = [UIImage imageNamed:@"RootContorllewImage"];
    [self.view addSubview:imageView];
}

-(void)liftBtnUI{
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.frame = CGRectMake([ApplicationStyle control_weight:36], [ApplicationStyle statusBarSize] + ([ApplicationStyle navigationBarSize] - [ApplicationStyle control_height:48])/2, [ApplicationStyle control_weight:48], [ApplicationStyle control_height:48]);
    [messageBtn setImage:[UIImage imageNamed:@"NL_Pro_Message"] forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(messageBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:messageBtn];
    
    
    UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, [ApplicationStyle statusBarSize] + ([ApplicationStyle navigationBarSize] - [ApplicationStyle control_height:40])/2, SCREENWIDTH, [ApplicationStyle control_height:40])];
    labTitle.text = NSLocalizedString(@"TabBar_Profile", nil);
    labTitle.textAlignment = NSTextAlignmentCenter;
    labTitle.textColor = [UIColor whiteColor];
    labTitle.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:36]];
    [self.view addSubview:labTitle];
    
    UIButton *signBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signBtn.frame = CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:90 + 30],[ApplicationStyle statusBarSize] + ([ApplicationStyle navigationBarSize] - [ApplicationStyle control_height:48])/2, [ApplicationStyle control_weight:90], [ApplicationStyle control_height:48]);
    [signBtn setTitle:NSLocalizedString(@"TabBar_Male_SignIn", nil) forState:UIControlStateNormal];
    [signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    signBtn.layer.cornerRadius = [ApplicationStyle control_weight:6];
    signBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    signBtn.layer.borderWidth = [ApplicationStyle control_weight:1];
    [signBtn addTarget:self action:@selector(signBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signBtn];
    
}
-(void)bulidUI{
    
//    http://warman-user-header.pinaivip.com/ae6050ec-63fa-40eb-b326-e43aa280ab2c.png
//    http://warman-user-header.pinaivip.com/ae6050ec-63fa-40eb-b326-e43aa280ab2c.png
    
    NSDictionary *dicImage = [PlistData getIndividuaData];
    _userHeadImage = [UIButton buttonWithType:UIButtonTypeCustom];
    _userHeadImage.frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:128])/2, [ApplicationStyle control_height:30] + [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize], [ApplicationStyle control_weight:128], [ApplicationStyle control_weight:128]);
//    _userHeadImage.layer.cornerRadius = [ApplicationStyle control_weight:128]/2;
//    _userHeadImage.layer.borderWidth = [ApplicationStyle control_weight:4];
//    _userHeadImage.layer.borderColor = [UIColor whiteColor].CGColor;
//    _userHeadImage.alpha = 0.15;
    [_userHeadImage addTarget:self action:@selector(userHeadImageDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_userHeadImage];
    
    _userImage = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:128])/2, [ApplicationStyle control_height:30] + [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize], [ApplicationStyle control_weight:128], [ApplicationStyle control_weight:128])];
    [_userImage sd_setImageWithURL:[NSURL URLWithString:[dicImage objectForKey:@"imageUrl"]] placeholderImage:[UIImage imageNamed:@"User_Head"]];
    _userImage.layer.cornerRadius = [ApplicationStyle control_weight:128]/2;
    _userImage.layer.borderWidth = [ApplicationStyle control_weight:3];
    _userImage.layer.borderColor = [UIColor whiteColor].CGColor;
    _userImage.clipsToBounds = YES;
    [self.view addSubview:_userImage];
    
    CGSize ss = [ApplicationStyle textSize:[dicImage objectForKey:@"userName"] font:[ApplicationStyle textThrityFont] size:SCREENWIDTH];
    
    _userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _userHeadImage.bottomOffset + [ApplicationStyle control_height:26], SCREENWIDTH, ss.height)];
    _userNameLab.font = [ApplicationStyle textThrityFont];
    _userNameLab.text = [dicImage objectForKey:@"userName"];
    _userNameLab.textAlignment = NSTextAlignmentCenter;
    _userNameLab.textColor = [UIColor whiteColor];
    [self.view addSubview:_userNameLab];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle control_height:410], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle control_height:410] - [ApplicationStyle tabBarSize]) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    _blackBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    _blackBackView.backgroundColor = [UIColor blackColor];
    _blackBackView.alpha = 0.3;
    _blackBackView.hidden = YES;
    [self.view addSubview:_blackBackView];
    
    
    NSArray *shareText = @[NSLocalizedString(@"NL_Share_WechatFriend", nil),
                           NSLocalizedString(@"NL_Share_WechatCircle", nil),
                           NSLocalizedString(@"NL_Share_QQ", nil),
                           NSLocalizedString(@"NL_Share_WeiBo", nil),];
    NSArray *shareImage = @[@"NL_Share_WeChartFriend",
                            @"NL_Share_WeChartCircle",
                            @"NL_Share_QQ",
                            @"NL_Share_WB"];

    CGRect frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, [ApplicationStyle control_height:300]);
    
    _shareView = [[NLShareView alloc] initWithFrame:frame imageArray:shareImage textArray:shareText];
    _shareView.delegate = self;
    _shareView.backgroundColor = [UIColor whiteColor];
    [[[UIApplication sharedApplication] keyWindow] addSubview:_shareView];
    
    
}

-(void)userHeadImageNotifiDown{
    NSDictionary *dicImage = [PlistData getIndividuaData];
    [_userImage sd_setImageWithURL:[NSURL URLWithString:[dicImage objectForKey:@"imageUrl"]] placeholderImage:[UIImage imageNamed:@"User_Head"]];
    
//    _userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _userHeadImage.bottomOffset + [ApplicationStyle control_height:26], SCREENWIDTH, ss.height)];
    _userNameLab.text = [dicImage objectForKey:@"userName"];
}
#pragma mark 系统Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
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
    

    NSArray *cellLabArray = @[NSLocalizedString(@"NLProfileView_MyEquitment", nil),
                              NSLocalizedString(@"NLProfileView_MyMale", nil),
                              NSLocalizedString(@"NLProfileView_Share", nil),
                              NSLocalizedString(@"NLProfileView_FeedBack", nil),
                              NSLocalizedString(@"NLProfileView_Set", nil),
                              NSLocalizedString(@"NLProfileView_AboutNL", nil),];
    NSArray *cellImageArray = @[@"ProFile_M_E_T",@"ProFile_M_male",@"ProFile_S_H",@"ProFile_F_B",@"ProFile_SET",@"ProFile_A_NL"];
    cell.cellImages.image = [UIImage imageNamed:cellImageArray[indexPath.row]];
    cell.cellLabs.text = cellLabArray[indexPath.row];
    cell.imageArrow.image = [UIImage imageNamed:@"Profile_Arrow"];
    cell.line.backgroundColor = [ApplicationStyle subjectLineViewColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *viewConrollerArray = @[@"NLMyEquipmentController",
                                    @"NLMyMaleViewController",
                                    @"",
                                    @"NLFeedBackViewController",
                                    @"NLSetProfoleViewController",
                                    @"NLAboutNLViewController"];
    
    if (indexPath.row == 2) {
//        [kAPPDELEGATE AutoDisplayAlertView:@"温馨提示" :@"暂未开放，敬请期待哦~~😊"];//暂时隐藏
        _blackBackView.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            _shareView.frame = CGRectMake(0, SCREENHEIGHT - [ApplicationStyle control_height:300], SCREENWIDTH, [ApplicationStyle control_height:300]);
        }];
    }else{
        UIViewController *viewControllew = [[NSClassFromString(viewConrollerArray[indexPath.row])alloc] init];
        [viewControllew setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:viewControllew animated:YES];
    }
}
#pragma mark 自己的Delegate
-(void)shareBtnDownIndex:(NSInteger)index{
    switch (index - 1000) {
        case 0: {
            if ([WXApi isWXAppInstalled]) {
                [UMSocialData defaultData].extConfig.wechatSessionData.url = @"www.baidu.com";
                [UMSocialData defaultData].extConfig.wechatSessionData.title = @"暖蓝Warman";
                [self sharePlatformArray:@[UMShareToWechatSession] shareCount:@"测试" icon:[UIImage imageNamed:@"User_Head"]];
            }else{
                [kAPPDELEGATE AutoDisplayAlertView:@"提示：" :@"你还没有安装微信哦~"];
            }
            break;
        }
        case 1: {
            if ([WXApi isWXAppInstalled]) {
                [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"www.baidu.com";
                [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"暖蓝Warman";
                [self sharePlatformArray:@[UMShareToWechatTimeline] shareCount:@"测试" icon:[UIImage imageNamed:@"User_Head"]];
            }else{
                [kAPPDELEGATE AutoDisplayAlertView:@"提示：" :@"你还没有安装微信哦~"];
            }
            break;
        }
        case 2: {
            if ([TencentOAuth iphoneQQInstalled]) {
              [self sharePlatformArray:@[UMShareToQQ] shareCount:@"测试" icon:[UIImage imageNamed:@"User_Head"]];
            }else{
               [kAPPDELEGATE AutoDisplayAlertView:@"提示：" :@"你还没有安装QQ哦~"]; 
            }
            break;
        }
        case 3: {
            if ([WeiboSDK isWeiboAppInstalled]) {
                [self sharePlatformArray:@[UMShareToSina] shareCount:@"测试" icon:[UIImage imageNamed:@"User_Head"]];
            }else{
                [kAPPDELEGATE AutoDisplayAlertView:@"提示：" :@"你还没有安装微博哦~"];
            }
            
            break;
        }
        default:
            break;
    }
}
-(void)cancleBtn{
    [self shareViewHide];
}
#pragma mark 事件方法
-(void)userHeadImageDown{
    NLIndividuaFormatViewController *vc = [[NLIndividuaFormatViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)messageBtnDown{
    NLMyMessageViewController *message = [[NLMyMessageViewController alloc] init];
    [message setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:message animated:YES];
}
-(void)signBtnDown{
    NLGiffiredSignViewController *vc = [[NLGiffiredSignViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)sharePlatformArray:(NSArray *)platrormArray shareCount:(NSString *)shareCount icon:(UIImage *)icon{
    UMSocialUrlResource *urls = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:@"www.baidu.com"];
    [[UMSocialDataService defaultDataService] postSNSWithTypes:platrormArray content:shareCount image:icon location:nil urlResource:urls presentedController:self completion:^(UMSocialResponseEntity *response) {
        if (response.responseCode == UMSResponseCodeSuccess) {
            [self shareViewHide];
        }
    }];
}

-(void)shareViewHide{
    [UIView animateWithDuration:0.5 animations:^{
        _shareView.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, [ApplicationStyle control_height:300]);
    }];
    _blackBackView.hidden = YES;
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
