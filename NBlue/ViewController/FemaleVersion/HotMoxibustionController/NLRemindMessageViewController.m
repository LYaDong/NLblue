//
//  NLRemindMessageViewController.m
//  NBlue
//
//  Created by LYD on 16/3/14.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLRemindMessageViewController.h"
#import "NLShareView.h"
#import "NLShareToolClass.h"
@interface NLRemindMessageViewController ()<NLShareViewDelegate>

@end

@implementation NLRemindMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navBarBack.hidden = YES;
    self.returnBtn.hidden = YES;
    self.titles.text = NSLocalizedString(@"", nil);
    [self preferredContentSize];
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
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    backImage.image = self.backImage;
    [backImage addSubview:[ApplicationStyle woolGlassEatablishImage:backImage]];
    [self.view addSubview:backImage];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:500])/2, [ApplicationStyle control_height:100], [ApplicationStyle control_weight:500], [ApplicationStyle control_weight:500])];
    imageView.image = [UIImage imageNamed:@"NL_Callmale_Female"];
    [self.view addSubview:imageView];
    
    CGSize textSize = [ApplicationStyle textSize:NSLocalizedString(@"NL_NL_CallmaleText", nil) font:[ApplicationStyle textThrityFont] size:SCREENWIDTH - [ApplicationStyle control_weight:88 * 2]];
    
    UILabel *labText = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:88], imageView.bottomOffset + [ApplicationStyle control_height:84], textSize.width, textSize.height)];
    labText.text = NSLocalizedString(@"NL_NL_CallmaleText", nil);
    labText.font = [ApplicationStyle textThrityFont];
    labText.textColor = [@"222222" hexStringToColor];
    labText.numberOfLines = 0;
    labText.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labText];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:40], labText.bottomOffset+[ApplicationStyle control_height:48], SCREENWIDTH - [ApplicationStyle control_weight:40 * 2], [ApplicationStyle control_height:1])];
    line.backgroundColor = [@"b5b5b5" hexStringToColor];
    [self.view addSubview:line];
    
    
    NSArray *shareText = @[NSLocalizedString(@"NLProfileView_MyMale", nil),
                           NSLocalizedString(@"NL_Share_WechatFriend", nil),
                           NSLocalizedString(@"NL_Share_WechatCircle", nil),
                           NSLocalizedString(@"NL_Share_QQ", nil),
                           NSLocalizedString(@"NL_Share_WeiBo", nil),];
    NSArray *shareImage = @[@"NLMale_HeadImage",
                            @"NL_Share_WeChartFriend",
                            @"NL_Share_WeChartCircle",
                            @"NL_Share_QQ",
                            @"NL_Share_WB"];
    
    CGRect frame = CGRectMake(0, line.bottomOffset + [ApplicationStyle control_height:48], SCREENWIDTH, [ApplicationStyle control_height:300]);
    NLShareView *shareView = [[NLShareView alloc] initWithFrame:frame imageArray:shareImage textArray:shareText];
    shareView.delegate = self;
    shareView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:shareView];
    
    
}
#pragma mark 系统Delegate
#pragma mark 自己的Delegate
-(void)cancleBtn{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)shareBtnDownIndex:(NSInteger)index{
    switch (index - 1000) {
        case 0: {
            [[NLDatahub sharedInstance] remindMessage:@"逗比海天逗比海天逗比海天逗比海天逗比海天逗比海天" type:@"1"];
            break;
        }
        case 1: {
            [[NLShareToolClass sharedInstance] WechatTimelineText:@"测试" title:@"Warman" url:@"www.baidu.com" viewController:self];
            break;
        }
        case 2: {
            [[NLShareToolClass sharedInstance] WechatTimelineText:@"测试" title:@"Warman" url:@"www.baidu.com" viewController:self];
            break;
        }
        case 3: {
            [[NLShareToolClass sharedInstance] qqShareText:@"测试" title:@"Warman" url:@"www.baidu.com" viewController:self];
            break;
        }
        case 4: {
            [[NLShareToolClass sharedInstance] qqShareText:@"测试" title:@"Warman" url:@"www.baidu.com" viewController:self];
            break;
        }
        default:
            break;
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
