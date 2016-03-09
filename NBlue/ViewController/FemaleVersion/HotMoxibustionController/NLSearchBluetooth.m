//
//  NLSearchBluetooth.m
//  NBlue
//
//  Created by LYD on 16/3/9.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLSearchBluetooth.h"
#import "NLBluetoothAgreementNew.h"
@interface NLSearchBluetooth ()
@property(nonatomic,strong)UIView *searchStartView;
@property(nonatomic,strong)UIView *searchStopView;
@property(nonatomic,strong)NLBluetoothAgreementNew *bluetooth;
@end

@implementation NLSearchBluetooth

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prefersStatusBarHidden];
    self.view.backgroundColor = [@"ff8f8f" hexStringToColor];
    
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
    [self searchstartUI];
//    [self searchStopUI];
    
}
-(void)searchstartUI{
    _searchStartView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    _searchStartView.backgroundColor = [@"ff8f8f" hexStringToColor];
    [self.view addSubview:_searchStartView];
    
    CGSize searchSize = [ApplicationStyle textSize:NSLocalizedString(@"NL_BlueSearch_TextTitle", nil) font:[UIFont systemFontOfSize:[ApplicationStyle control_weight:48]] size:SCREENWIDTH];
    UILabel *searchLab = [[UILabel alloc] initWithFrame:CGRectMake((SCREENWIDTH - searchSize.width)/2, [ApplicationStyle control_height:130], searchSize.width, searchSize.height)];
    searchLab.text = NSLocalizedString(@"NL_BlueSearch_TextTitle", nil);
    searchLab.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:48]];
    searchLab.textColor = [UIColor whiteColor];
    searchLab.numberOfLines = 0;
    searchLab.textAlignment = NSTextAlignmentCenter;
    [_searchStartView addSubview:searchLab];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:360])/2, [ApplicationStyle control_height:306], [ApplicationStyle control_weight:360], [ApplicationStyle control_height:360])];
    imageView.image = [UIImage imageNamed:@"NL_Horese_Race_L"];
    [_searchStartView addSubview:imageView];
    
    
    CGSize countSize = [ApplicationStyle textSize:NSLocalizedString(@"NL_BlueSearch_TextCount", nil) font:[ApplicationStyle textSuperSmallFont] size:SCREENWIDTH];
    UILabel *countText = [[UILabel alloc] initWithFrame:CGRectMake((SCREENWIDTH - countSize.width)/2, imageView.bottomOffset + [ApplicationStyle control_height:220], countSize.width, countSize.height)];
    countText.text = NSLocalizedString(@"NL_BlueSearch_TextCount", nil);
    countText.font = [ApplicationStyle textSuperSmallFont];
    countText.textColor = [UIColor whiteColor];
    countText.hidden = NO;
    [_searchStartView addSubview:countText];
    
    CGSize againSearchSize = [ApplicationStyle textSize:NSLocalizedString(@"NL_BlueSearch_TextCount", nil) font:[ApplicationStyle textSuperSmallFont] size:SCREENWIDTH];
    UIButton *againSearchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    againSearchBtn.frame = CGRectMake((SCREENWIDTH - againSearchSize.width)/2, imageView.bottomOffset + [ApplicationStyle control_height:220], againSearchSize.width, againSearchSize.height);
    [againSearchBtn setTitle:NSLocalizedString(@"NL_BlueSearch_AgainSearch", nil) forState:UIControlStateNormal];
    againSearchBtn.titleLabel.font = [ApplicationStyle textSuperSmallFont];
    [againSearchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    againSearchBtn.hidden = YES;
    [againSearchBtn addTarget:self action:@selector(againSearchDown) forControlEvents:UIControlEventTouchUpInside];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"NL_BlueSearch_AgainSearch", nil) attributes:@{NSFontAttributeName:[ApplicationStyle textSuperSmallFont],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    [againSearchBtn setAttributedTitle:title forState:UIControlStateNormal];
    [_searchStartView addSubview:againSearchBtn];

    UIButton *stopSearchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    stopSearchBtn.frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:220])/2, countText.bottomOffset + [ApplicationStyle control_height:68], [ApplicationStyle control_weight:220], [ApplicationStyle control_height:60]);
    [stopSearchBtn setTitle:NSLocalizedString(@"NL_BlueSearch_StopSearch", nil) forState:UIControlStateNormal];
    stopSearchBtn.titleLabel.font = [ApplicationStyle textThrityFont];
    [stopSearchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    stopSearchBtn.layer.cornerRadius = [ApplicationStyle control_weight:10];
    stopSearchBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    stopSearchBtn.layer.borderWidth = [ApplicationStyle control_weight:1];
    [stopSearchBtn addTarget:self action:@selector(stopSearchDown) forControlEvents:UIControlEventTouchUpInside];
    [_searchStartView addSubview:stopSearchBtn];
    
    __weak typeof (NLSearchBluetooth) *searchBluetooth = self;//防止循环引用，页面释放时释放他
    _bluetooth = [NLBluetoothAgreementNew shareInstance];
    _bluetooth.bluetoothSuccess = ^(NSString *success){
        countText.hidden = YES;
        againSearchBtn.hidden = NO;
        CGSize searchSuccessSize = [ApplicationStyle textSize:NSLocalizedString(@"NL_BlueSearch_Success", nil) font:[UIFont systemFontOfSize:[ApplicationStyle control_weight:48]] size:SCREENWIDTH];
        searchLab.frame = CGRectMake((SCREENWIDTH - searchSuccessSize.width)/2, [ApplicationStyle control_height:130], searchSuccessSize.width, searchSuccessSize.height);
        searchLab.text = NSLocalizedString(@"NL_BlueSearch_Success", nil);
        imageView.image = [UIImage imageNamed:@"NL_Horese_Race_L_Z"];
        [stopSearchBtn setTitle:NSLocalizedString(@"GeneralText_OK", nil) forState:UIControlStateNormal];
        [stopSearchBtn addTarget:searchBluetooth action:@selector(stopSearchOK) forControlEvents:UIControlEventTouchUpInside];
    };
    
    
}
-(void)againSearchDown{
    [_bluetooth cancleBluetooth];
    [[NSNotificationCenter defaultCenter] postNotificationName:NLSearchBluetoothNotification object:nil];
    [self searchstartUI];
    [kAPPDELEGATE._loacluserinfo bluetoothUUID:nil];
}
-(void)stopSearchOK{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)stopSearchDown{
    [self.navigationController popViewControllerAnimated:YES];
}
//-(void)searchStopUI{
//    _searchStopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
//    _searchStopView.backgroundColor = [@"ff8f8f" hexStringToColor];
//    [self.view addSubview:_searchStopView];
//    
//    NSString *textStr = @"我要绑定手环在震动\n您是否要绑定这只手环";
//    
//    CGSize searchSize = [ApplicationStyle textSize:textStr font:[UIFont systemFontOfSize:[ApplicationStyle control_weight:48]] size:SCREENWIDTH];
//    UILabel *searchLab = [[UILabel alloc] initWithFrame:CGRectMake((SCREENWIDTH - searchSize.width)/2, [ApplicationStyle control_height:130], searchSize.width, searchSize.height)];
//    searchLab.text = textStr;
//    searchLab.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:48]];
//    searchLab.textColor = [UIColor whiteColor];
//    [_searchStopView addSubview:searchLab];
//    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:360])/2, [ApplicationStyle control_height:306], [ApplicationStyle control_weight:360], [ApplicationStyle control_height:360])];
//    imageView.image = [UIImage imageNamed:@"NL_Horese_Race_L_Z"];
//    [_searchStopView addSubview:imageView];
//    
//    
//    CGSize countSize = [ApplicationStyle textSize:NSLocalizedString(@"NL_BlueSearch_TextCount", nil) font:[ApplicationStyle textSuperSmallFont] size:SCREENWIDTH];
//    UILabel *countText = [[UILabel alloc] initWithFrame:CGRectMake((SCREENWIDTH - countSize.width)/2, imageView.bottomOffset + [ApplicationStyle control_height:220], countSize.width, countSize.height)];
//    countText.text = NSLocalizedString(@"NL_BlueSearch_TextCount", nil);
//    countText.font = [ApplicationStyle textSuperSmallFont];
//    countText.textColor = [UIColor whiteColor];
//    [_searchStopView addSubview:countText];
//    
//    UIButton *stopSearchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    stopSearchBtn.frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:220])/2, countText.bottomOffset + [ApplicationStyle control_height:68], [ApplicationStyle control_weight:220], [ApplicationStyle control_height:60]);
//    [stopSearchBtn setTitle:NSLocalizedString(@"NL_BlueSearch_StopSearch", nil) forState:UIControlStateNormal];
//    stopSearchBtn.titleLabel.font = [ApplicationStyle textThrityFont];
//    [stopSearchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    stopSearchBtn.layer.cornerRadius = [ApplicationStyle control_weight:10];
//    stopSearchBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//    stopSearchBtn.layer.borderWidth = [ApplicationStyle control_weight:1];
//    [stopSearchBtn addTarget:self action:@selector(stopSearchDown) forControlEvents:UIControlEventTouchUpInside];
//    [_searchStopView addSubview:stopSearchBtn];
//}
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
