//
//  NLMyEquipmentController.m
//  NBlue
//
//  Created by LYD on 15/11/25.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLMyEquipmentController.h"
#import "NLMyEquipmentCell.h"
#import "NLSQLData.h"
#import "NLBluetoothAgreement.h"
#import "NLConnectBloothViewController.h"
#import "TYWaveProgressView.h"
#import "NLBluetoothDataAnalytical.h"
@interface NLMyEquipmentController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIImageView *batteryBack;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableDictionary *cellLabdic;
@property(nonatomic,strong)NSMutableDictionary *cellCountLabDic;
@property(nonatomic,strong)NSMutableArray *peripheralArray;
@property(nonatomic,weak) TYWaveProgressView *waveView;
@end

@implementation NLMyEquipmentController

-(void)queryBatteryLevel{
    Byte byte[20] = {0x02,0x01};
    NSData *data = [NSData dataWithBytes:byte length:20];
    if (_peripheralArray.count>0) {
        //       [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    {
        self.navBarBack.hidden = YES;
        self.navBarPushBack.hidden = NO;
        self.controllerBack.hidden = YES;
    }
    
    
    [self batteryLevelUI];
    _peripheralArray = [NSMutableArray array];
    
    
    self.view.backgroundColor = [ApplicationStyle subjectBackViewColor];
    
    NLBluetoothAgreement *blues = [NLBluetoothAgreement shareInstance];
    _peripheralArray  = blues.arrPeripheral;
    blues.returnBatteryLevel = ^(NSString *batteryLevel){
        long level = [NLBluetoothDataAnalytical sixTenHexTeen:[batteryLevel substringWithRange:NSMakeRange(14, 2)]];
        
        CGFloat floatLevel = level*0.01;
        _waveView.numberLabel.text = [NSString stringWithFormat:@"%ld%@",level,@"%"];
        _waveView.percent = floatLevel;
        [_waveView startWave];
    };
    
    //    0201 dc07 0d 01 00 30 01 00
    
    
    
    
    [self queryBatteryLevel];
    
    
    
    
    
    _cellLabdic = [NSMutableDictionary dictionary];
    _cellCountLabDic = [NSMutableDictionary dictionary];
    {
        NSArray *equipmentLabArray = @[NSLocalizedString(@"NLMyEquipment_EquipmentName", nil),
                                       NSLocalizedString(@"NLMyEquipment_FirmwareEdition", nil),
                                       NSLocalizedString(@"NLMyEquipment_MACAddress", nil)];
        NSArray *firmentUP = @[NSLocalizedString(@"NLMyEquipment_FirmwareUP", nil)];
        NSArray *reilveArr = @[NSLocalizedString(@"NLMyEquipment_RelieveBinding", nil)];
        [_cellLabdic setValue:equipmentLabArray forKey:@"equipmentLabArray"];
        [_cellLabdic setValue:firmentUP forKey:@"firmentUP"];
        [_cellLabdic setValue:reilveArr forKey:@"reilveArr"];
    }
    {
        NSDictionary *dic = [NLSQLData getBluetoothEquipmentInformation];
        
        NSString *equiomentName = nil;
        if ([kAPPDELEGATE._loacluserinfo getBluetoothName] == nil) {
            equiomentName = @"您还没有链接任何设备";
        }else{
            equiomentName = [kAPPDELEGATE._loacluserinfo getBluetoothName];
        }
        
        
        NSString *edition = [NSString stringWithFormat:@"v%@.0",[dic objectForKey:@"Version"]];
        NSArray *equipmentLabArray = @[equiomentName,edition,@""];
        [_cellCountLabDic setValue:equipmentLabArray forKey:@"equipmentLabArray"];
        
    }
    
    self.titles.text = NSLocalizedString(@"NLMyEquipment_MyEquipment", nil);
    [self bulidUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark 基础UI
//电池UI
-(void)batteryLevelUI{
    TYWaveProgressView *waveProgress = [[TYWaveProgressView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:10], [ApplicationStyle navBarAndStatusBarSize] + [ApplicationStyle control_height:60], [ApplicationStyle control_weight:220], [ApplicationStyle control_weight:220])];
    //    waveProgress.waveViewMargin = UIEdgeInsetsMake(15, 15, 20, 20);
    waveProgress.numberLabel.text = @"100%";
    waveProgress.numberLabel.font = [UIFont boldSystemFontOfSize:[ApplicationStyle control_weight:50]];
    waveProgress.numberLabel.textColor = [UIColor whiteColor];
    waveProgress.explainLabel.text = @"电量";
    waveProgress.explainLabel.font = [UIFont systemFontOfSize:20];
    waveProgress.explainLabel.textColor = [UIColor whiteColor];
    waveProgress.percent = 100;
    [self.view addSubview:waveProgress];
    _waveView = waveProgress;
    [waveProgress startWave];
}

-(void)bulidUI{
    
    
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle navBarAndStatusBarSize] + [ApplicationStyle control_height:420], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle navBarAndStatusBarSize] - [ApplicationStyle control_height:420]) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.backgroundColor = [ApplicationStyle subjectBackViewColor];
    [self.view addSubview:_tableView];
}
#pragma mark 系统Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return [[_cellLabdic objectForKey:@"equipmentLabArray"] count];
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return [[_cellLabdic objectForKey:@"firmentUP"] count];
    }else{
        return [[_cellLabdic objectForKey:@"reilveArr"] count];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [ApplicationStyle control_height:30];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ApplicationStyle control_height:88];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯一确定cell
    NLMyEquipmentCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[NLMyEquipmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    UIView *viewLineOn = [[UIView alloc] init];
    viewLineOn.backgroundColor = [ApplicationStyle subjectLineViewColor];
    viewLineOn.tag = 100;
    [cell addSubview:viewLineOn];
    
    UIView *viewLineUnder = [[UIView alloc] init];
    viewLineUnder.backgroundColor = [ApplicationStyle subjectLineViewColor];
    viewLineUnder.tag = 200;
    [cell addSubview:viewLineUnder];
    
    if (indexPath.section == 0) {
        cell.liftTitleLab.text = [[_cellLabdic objectForKey:@"equipmentLabArray"] objectAtIndex:indexPath.row];
        cell.rightTitleLab.text = [[_cellCountLabDic objectForKey:@"equipmentLabArray"] objectAtIndex:indexPath.row];
        
        
    }else if (indexPath.section == 1){
        
        NSArray *arr = @[@"搜索蓝牙",@"重启设备"];
        cell.liftTitleLab.text = arr[indexPath.row];
    }else if (indexPath.section == 2){
        cell.liftTitleLab.text = [[_cellLabdic objectForKey:@"firmentUP"] objectAtIndex:indexPath.row];
        cell.imageArrow.hidden = NO;
    }else{
        cell.relivewBindingLab.text = [[_cellLabdic objectForKey:@"reilveArr"] objectAtIndex:indexPath.row];
    }
    
    viewLineOn.frame = CGRectMake(0, 0, SCREENWIDTH, 1);
    viewLineUnder.frame = CGRectMake(0, [ApplicationStyle control_height:88] - 1, SCREENWIDTH, 1);
    if (indexPath.section == 0) {
        if (indexPath.row!=[[_cellLabdic objectForKey:@"equipmentLabArray"] count] - 1) {
            viewLineUnder.hidden = YES;
        }
        
        if (indexPath.row != 0) {
            viewLineOn.frame = CGRectMake([ApplicationStyle control_weight:20], 0, SCREENWIDTH, 1);
        }
    }
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                NLConnectBloothViewController *vc = [[NLConnectBloothViewController alloc] init];
                [vc setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 1:
            {
                Byte byte[20] = {0xF0,0x01};
                NSData *data = [NSData dataWithBytes:byte length:20];
                if (_peripheralArray.count>0) {
                    [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
                }
                
                NLConnectBloothViewController *vc = [[NLConnectBloothViewController alloc] init];
                [vc setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            default:
                break;
        }
    }
    
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