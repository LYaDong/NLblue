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
#import "NLBluetoothAgreementNew.h"
@interface NLMyEquipmentController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIImageView *batteryBack;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableDictionary *cellLabdic;
@property(nonatomic,strong)NSMutableDictionary *cellCountLabDic;
@property(nonatomic,strong)NSMutableArray *peripheralArray;
@property(nonatomic,weak) TYWaveProgressView *waveViewA;
@property(nonatomic,weak) TYWaveProgressView *waveViewB;
@property(nonatomic,strong)NLBluetoothAgreementNew *bluetooth;
@property(nonatomic,strong)UIView *noBluetoothView;
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

-(void)unitBBatteryLevel{
    Byte byte[20] = {0x90,0x04};
    NSData *data = [NSData dataWithBytes:byte length:20];
    if (_peripheralArray.count>0) {
        //       [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    
    [self batteryLevelUI];
    _peripheralArray = [NSMutableArray array];
    
    
    self.view.backgroundColor = [ApplicationStyle subjectBackViewColor];
    
//    NLBluetoothAgreement *blues = [NLBluetoothAgreement shareInstance];
//    _peripheralArray  = blues.arrPeripheral;
//    blues.returnBatteryLevel = ^(NSString *batteryLevel){
//        
//        NSLog(@"%@",batteryLevel);
//        
//        if ([[batteryLevel substringWithRange:NSMakeRange(0, 4)] isEqualToString:EquiomentCommand_0201]) {
//            long level = [NLBluetoothDataAnalytical sixTenHexTeen:[batteryLevel substringWithRange:NSMakeRange(14, 2)]];
//            CGFloat floatLevel = level*0.01;
//            _waveViewA.numberLabel.text = [NSString stringWithFormat:@"%ld%@",level,@"%"];
//            _waveViewA.percent = floatLevel;
//            [_waveViewA startWave];
//
//            [self unitBBatteryLevel];
//        }else{
//            long level = [NLBluetoothDataAnalytical sixTenHexTeen:[batteryLevel substringWithRange:NSMakeRange(4, 2)]];
//            CGFloat floatLevel = level*0.01;
//            _waveViewB.numberLabel.text = [NSString stringWithFormat:@"%ld%@",level,@"%"];
//            _waveViewB.percent = floatLevel;
//            [_waveViewB startWave];
//        }
//        
//        
//        
//        
//    };
//    
//    [self queryBatteryLevel];
    
    
    
    
    
    
    
    

    
    
    self.titles.text = NSLocalizedString(@"NLMyEquipment_MyEquipment", nil);
    [self noBluetoothUI];
    [self bluetoothUI];
    [self bulidUI];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark 基础UI
-(void)noBluetoothUI{
    
    _noBluetoothView = [[UIView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle navBarAndStatusBarSize], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle navBarAndStatusBarSize])];
    _noBluetoothView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_noBluetoothView];
}

-(void)bluetoothUI{
    
    __weak typeof (NLMyEquipmentController) *equioment = self;//防止循环引用，页面释放时释放他
    _bluetooth = [NLBluetoothAgreementNew shareInstance];
    [_bluetooth queryAunitLevel];
    _bluetooth.batteryLevelA = ^(NSString *batteryLevel,NLBluetoothAgreementNew *blue){
        long level = [NLBluetoothDataAnalytical sixTenHexTeen:[batteryLevel substringWithRange:NSMakeRange(14, 2)]];
        CGFloat floatLevel = level*0.01;
        equioment.waveViewA.numberLabel.text = [NSString stringWithFormat:@"%ld%@",level,@"%"];
        equioment.waveViewA.percent = floatLevel;
        [equioment.waveViewA startWave];
        [blue queryBunitLevel];
    };
    
    _bluetooth.batteryLevelB = ^(NSString *batteryLelveB){
        long level = [NLBluetoothDataAnalytical sixTenHexTeen:[batteryLelveB substringWithRange:NSMakeRange(4, 2)]];
        CGFloat floatLevel = level*0.01;
        equioment.waveViewB.numberLabel.text = [NSString stringWithFormat:@"%ld%@",level,@"%"];
        equioment.waveViewB.percent = floatLevel;
        [equioment.waveViewB startWave];

    };
}
//电池UI
-(void)batteryLevelUI{
    TYWaveProgressView *waveProgressA = [[TYWaveProgressView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:70], [ApplicationStyle navBarAndStatusBarSize] + [ApplicationStyle control_height:60], [ApplicationStyle control_weight:220], [ApplicationStyle control_weight:220])];
    waveProgressA.backgroundImageView.image = [UIImage imageNamed:@"NL_BatteryLevel"];
    waveProgressA.numberLabel.text = @"100%";
    waveProgressA.numberLabel.font = [UIFont boldSystemFontOfSize:[ApplicationStyle control_weight:50]];
    waveProgressA.numberLabel.textColor = [UIColor whiteColor];
    waveProgressA.explainLabel.text = @"电量";
    waveProgressA.explainLabel.font = [UIFont systemFontOfSize:20];
    waveProgressA.explainLabel.textColor = [UIColor whiteColor];
    waveProgressA.percent = 100;
    [self.view addSubview:waveProgressA];
    _waveViewA = waveProgressA;
    [waveProgressA startWave];
    
    
    
    
    TYWaveProgressView *waveProgressB = [[TYWaveProgressView alloc] initWithFrame:CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:290], [ApplicationStyle navBarAndStatusBarSize] + [ApplicationStyle control_height:60], [ApplicationStyle control_weight:220], [ApplicationStyle control_weight:220])];
    waveProgressB.backgroundImageView.image = [UIImage imageNamed:@"NL_BatteryLevel"];
    waveProgressB.numberLabel.text = @"100%";
    waveProgressB.numberLabel.font = [UIFont boldSystemFontOfSize:[ApplicationStyle control_weight:50]];
    waveProgressB.numberLabel.textColor = [UIColor whiteColor];
    waveProgressB.explainLabel.text = @"电量";
    waveProgressB.explainLabel.font = [UIFont systemFontOfSize:20];
    waveProgressB.explainLabel.textColor = [UIColor whiteColor];
    waveProgressB.percent = 100;
    [self.view addSubview:waveProgressB];
    _waveViewB = waveProgressB;
    [waveProgressB startWave];
    
    
    
    
}

-(void)bulidUI{
    
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
    if (section == 0) {
        return 0;
    }else{
      return [ApplicationStyle control_height:30];
    }
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
                if ([kAPPDELEGATE._loacluserinfo getBluetoothName] == nil) {
                    [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"你还没有连接设备"];
                    return;
                }
                [_bluetooth connectReseart];
                [kAPPDELEGATE._loacluserinfo bluetoothSetTime:@"1"];
//                NLConnectBloothViewController *vc = [[NLConnectBloothViewController alloc] init];
//                [vc setHidesBottomBarWhenPushed:YES];
//                [self.navigationController pushViewController:vc animated:YES];
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