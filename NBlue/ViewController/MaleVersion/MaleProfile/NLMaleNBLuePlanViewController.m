//
//  NLMaleNBLuePlanViewController.m
//  NBlue
//
//  Created by LYD on 16/1/6.
//  Copyright © 2016年 LYD. All rights reserved.
//
static const SWITCHTAG = 1000;
#import "NLMaleNBLuePlanViewController.h"
#import "NLMaleNBluePlanCell.h"
@interface NLMaleNBLuePlanViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *mainTableView;
@end

@implementation NLMaleNBLuePlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titles.text = NSLocalizedString(@"NLMaleNBLuePlan_NBluePlan", nil);
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
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize], SCREENWIDTH, [ApplicationStyle control_height:486]) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.scrollEnabled = NO;
    [self.view addSubview:_mainTableView];
    
}
#pragma mark 系统Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [ApplicationStyle control_height:22];
    }else{
        return [ApplicationStyle control_height:115];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ApplicationStyle control_height:88];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        
        NSString *str = @"开通暖蓝计划后，当你女朋友【可能】需要关怀时，我们将提醒你送去相应的关怀，需为爱变得更贴心。";
        
        UIView *viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:115])];
        CGSize textSize = [ApplicationStyle textSize:str font:[ApplicationStyle textSuperSmallFont] size:SCREENWIDTH - [ApplicationStyle control_weight:38 * 2]];
        UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:38], (viewBack.bottomOffset - textSize.height)/2, SCREENWIDTH - [ApplicationStyle control_weight:38 * 2], textSize.height)];
        labTitle.text = str;
        labTitle.font = [ApplicationStyle textSuperSmallFont];
        labTitle.textColor = [@"7d7d7d" hexStringToColor];
        labTitle.numberOfLines = 0;
        [viewBack addSubview:labTitle];
        return viewBack;
    }
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"LYD";
    NLMaleNBluePlanCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[NLMaleNBluePlanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    if (indexPath.section == 0) {
        cell.titleLab.text = NSLocalizedString(@"NLMaleNBLuePlan_NBluePlan", nil);
        
        [cell.switchOff addTarget:self action:@selector(switchDown:) forControlEvents:UIControlEventValueChanged];
    }else{
        NSArray *arrText = @[NSLocalizedString(@"NLMaleNBLuePlan_MessagePush", nil),
                             NSLocalizedString(@"NLMaleNBLuePlan_Shock", nil),
                             NSLocalizedString(@"NLMaleNBLuePlan_PushTime", nil)];
        cell.titleLab.text = arrText[indexPath.row];
        cell.switchOff.tag = indexPath.row + SWITCHTAG;
        [cell.switchOff addTarget:self action:@selector(switchOffDown:) forControlEvents:UIControlEventValueChanged];
        if (indexPath.row == 2) {
            cell.switchOff.hidden = YES;
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark 自己的Delegate
#pragma mark 自己的按钮事件
-(void)switchOffDown:(UISwitch *)switchs{
    NSLog(@"%ld",(long)switchs.tag);
}

-(void)switchDown:(UISwitch *)sw{
    NSLog(@"123");
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
