//
//  NLMaleIndividuaViewController.m
//  NBlue
//
//  Created by LYD on 16/1/6.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLMaleIndividuaViewController.h"
#import "NLMaleIndivuaCell.h"
#import "NLPickView.h"
#import "NLMaleNBLuePlanViewController.h"
@interface NLMaleIndividuaViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,assign)BOOL isCallRemind; 
@property(nonatomic,assign)BOOL isSendentary;
@end

@implementation NLMaleIndividuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _isCallRemind = NO;
    _isSendentary = NO;
    
    self.titles.text = NSLocalizedString(@"NLProfileView_Set", nil);
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
    
    
//    NLPickView *pickerView = [[NLPickView alloc] initWithMultiplePickerDateArray:[self datePickerArray] num:2 type:PickerType_RemindSection];
//    pickerView.frame = CGRectMake(0, 100, SCREENWIDTH, 300);
//    [self.view addSubview:pickerView];
    
    
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle navBarAndStatusBarSize], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle navBarAndStatusBarSize]) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _mainTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_mainTableView];
}
#pragma mark 系统Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            if (_isCallRemind==NO) {
                return 1;
            }else{
                return 3;
            }
            break;
        }
        case 1:
        {
            if (_isSendentary==NO) {
                return 1;
            }else{
                return 3;
            }
            break;
        }
        case 2:
        {
            return 1;
            break;
        }
        case 3:
        {
            return 1;
            break;
        }
        default:
            break;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ApplicationStyle control_height:88];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [ApplicationStyle control_height:22];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"LYD";
    NLMaleIndivuaCell *cell = [tableView  dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[NLMaleIndivuaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    cell.titleLab.textAlignment = NSTextAlignmentLeft;
    cell.titleLab.textColor = [@"1b1b1b" hexStringToColor];
    cell.arrowImg.hidden = NO;
    
    
    if (indexPath.section == 0) {
       cell.arrowImg.hidden = YES;
    }else{
        cell.switchs.hidden = YES;
    }
    
//    if (indexPath.section == 2 || indexPath.section == 3) {
//        cell.switchs.hidden = YES;
//    }else{
//        cell.arrowImg.hidden = YES;
//    }
    
    switch (indexPath.section) {
        case 0:
        {
            [cell.switchs addTarget:self action:@selector(switchCallDown:) forControlEvents:UIControlEventValueChanged];
            cell.titleLab.text = NSLocalizedString(@"NLSetProfile_CallRemid", nil);
            break;
        }
        case 1:
        {
            cell.titleLab.text = NSLocalizedString(@"NLMaleProfile_NBluePlan", nil);
            break;
        }
        case 2:
        {
            cell.titleLab.text = NSLocalizedString(@"NLSetProfile_GOScore", nil);
            break;
        }
        case 3:
        {
            cell.titleLab.textAlignment = NSTextAlignmentCenter;
            cell.titleLab.textColor = [UIColor redColor];
            cell.arrowImg.hidden = YES;
            cell.titleLab.text = NSLocalizedString(@"NLSetProfile_SecurityEiet", nil);
            break;
        }
        default:
            break;
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark 自己的Delegate
-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 1:{
            NLMaleNBLuePlanViewController *vc = [[NLMaleNBLuePlanViewController alloc] init];
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:{
            [ApplicationStyle jumpAppStoreScore];
            break;
        }
        case 3:{
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"温馨提醒" message:@"你确定要退出登录么！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"确定", nil];
            [al alertSuccessHandler:^(NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    [kAPPDELEGATE._loacluserinfo SetUser_ID:@""];
                    [kAPPDELEGATE._loacluserinfo SetUserAccessToken:@""];
                    [kAPPDELEGATE._loacluserinfo goControllew:@"0"];
                    [kAPPDELEGATE tabBarViewControllerType:Controller_Loing];
                    [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"退出成功"];
                }
            }];
            break;
        }
        default:
            break;
    }
}
#pragma mark 自己的按钮事件

//来电提醒
-(void)switchCallDown:(UISwitch *)sw{
    
}
//久坐提醒
-(void)switchSedentaryDown:(UISwitch *)sw{
    if (sw.on == NO) {
        _isSendentary = NO;
    }else{
        _isSendentary = YES;
    }
    [_mainTableView reloadData];
}



- (NSMutableArray *)datePickerArray{
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i=0; i<24; i++) {
        if (i<10) {
            [array addObject:[NSString stringWithFormat:@"0%ld:00",(long)i]];
        }else{
            [array addObject:[NSString stringWithFormat:@"%ld:00",(long)i]];
        }
    }
    return array;
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
