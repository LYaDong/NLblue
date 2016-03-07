//
//  NLAboutNLViewController.m
//  NBlue
//
//  Created by LYD on 15/11/27.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLAboutNLViewController.h"
#import "NLIndividuaFormaCell.h"
#import "NLWarmanAgreement.h"
@interface NLAboutNLViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIImageView *copyrightNLImage;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation NLAboutNLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ApplicationStyle subjectBackViewColor];
    self.titles.text = NSLocalizedString(@"NLProfileView_AboutNL", nil);
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
    
    _copyrightNLImage = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:274])/2,([ApplicationStyle control_height:350] - [ApplicationStyle control_height:228])/2+ [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize], [ApplicationStyle control_weight:274], [ApplicationStyle control_height:228])];
    _copyrightNLImage.image = [UIImage imageNamed:@"Copyright_NL"];
    [self.view addSubview:_copyrightNLImage];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle control_height:350] + [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle control_height:350] - [ApplicationStyle statusBarSize] - [ApplicationStyle statusBarSize]) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}
#pragma mark 系统Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ApplicationStyle control_height:88];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"LYD";
    NLIndividuaFormaCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[NLIndividuaFormaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle control_height:88 - 1], SCREENWIDTH, [ApplicationStyle control_height:1])];
        line.backgroundColor = [@"dedede" hexStringToColor];
        [cell addSubview:line];
    }
    
    cell.cellHeadTitleLab.text = NSLocalizedString(@"NLAboutNL_UserAgreement", nil);
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NLWarmanAgreement *vc = [[NLWarmanAgreement alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
    
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
