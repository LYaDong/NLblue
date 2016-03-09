//
//  NLConnectBloothViewController.m
//  NBlue
//
//  Created by LYD on 15/12/31.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLConnectBloothViewController.h"
#import "NLConnectBloothCell.h"
#import "NLBluetoothAgreement.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "NLBluetoothAgreementNew.h"
#import "NLSearchBluetooth.h"
@interface NLConnectBloothViewController ()
@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation NLConnectBloothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArr = [NSMutableArray array];
    [self buildUI];
    [self bloothView];
    
    

    
    
    
}
-(void)btnDOwn{
    [_dataArr removeAllObjects];
    [_mainTableView reloadData];
}
-(void)buildUI{
    
    UIView *upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:700])];
    upView.backgroundColor = [@"a3a4a7" hexStringToColor];
    [self.view addSubview:upView];
    
    UIImageView *upImage = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:360])/2, [ApplicationStyle control_height:200], [ApplicationStyle control_weight:360], [ApplicationStyle control_height:360])];
    upImage.image = [UIImage imageNamed:@"NL_Horese_Race_L"];
    [upView addSubview:upImage];
    
    
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0, upView.bottomOffset, SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle control_height:700])];
    downView.backgroundColor = [self downBackColor];
    [self.view addSubview:downView];
    
    
    NSString *bindingStr = @"绑定步骤\n\n1、打开手机蓝牙。\n2、敲击硬件屏幕以唤醒。\n3、点击'开始配对设备'。\n4、让设备靠近手机靠近，等待2秒。";
    
    CGSize bindingStepSize = [ApplicationStyle textSize:bindingStr font:[ApplicationStyle textSuperSmallFont] size:SCREENWIDTH - [ApplicationStyle control_weight:176]];
    
    UILabel *bindingStep = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:176], [ApplicationStyle control_height:42], SCREENWIDTH, bindingStepSize.height + [ApplicationStyle control_height:20])];
    bindingStep.text = bindingStr;
    bindingStep.font = [ApplicationStyle textSuperSmallFont];
    bindingStep.textColor = [UIColor whiteColor];
    bindingStep.numberOfLines = 0;
    [downView addSubview:bindingStep];
    [self heartReatLab:bindingStep rang:NSMakeRange(0, 4)];
    
    NSArray *arrTexe = @[NSLocalizedString(@"NL_BlueSearch_Return", nil),NSLocalizedString(@"NL_BlueSearch_Next", nil)];
    
    
    for (NSInteger i=0; i<2; i++) {
        UIButton *downBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        downBtn.frame = CGRectMake((SCREENWIDTH/2 - [ApplicationStyle control_weight:220])/2 + i * SCREENWIDTH/2, [ApplicationStyle control_height:282], [ApplicationStyle control_weight:220], [ApplicationStyle control_height:60]);
        [downBtn setTitle:arrTexe[i] forState:UIControlStateNormal];
        [downBtn setTitleColor:[@"ffffff" hexStringToColor] forState:UIControlStateNormal];
        downBtn.layer.cornerRadius = [ApplicationStyle control_weight:10];
        downBtn.layer.borderWidth = [ApplicationStyle control_weight:1];
        downBtn.layer.borderColor = [@"ffffff" hexStringToColor].CGColor;
        downBtn.tag = 1000 + i;
        [downBtn addTarget:self action:@selector(downBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        [downView addSubview:downBtn];
    }
//    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize], SCREENWIDTH, SCREENHEIGHT - ([ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize])) style: UITableViewStylePlain];
//    _mainTableView.delegate = self;
//    _mainTableView.dataSource = self;
//    [self.view addSubview:_mainTableView];
}

-(void)bloothView{
    
    NLBluetoothAgreementNew *bluetooth = [NLBluetoothAgreementNew shareInstance];
    [bluetooth bluetoothInstantiation];
    [bluetooth dataArrayInstantiation];
//    bluetooth.bluetoothDataArr = ^(NSMutableArray *array){
//        NSLog(@"%@",array);
//        
//        
//        [_dataArr removeAllObjects];
//        [_dataArr addObjectsFromArray:array];
//        [_mainTableView reloadData];
//
//    };
    
    
//    NLBluetoothAgreement *blue = [NLBluetoothAgreement shareInstance];
//    [blue bluetoothAllocInit];
//    blue.getEquiment = ^(NSArray *perpheral){
//        [_dataArr removeAllObjects];
//        [_dataArr addObjectsFromArray:perpheral];
//        [_mainTableView reloadData];
//    };
}

//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return _dataArr.count;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 50;
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *str = @"LYD";
//    NLConnectBloothCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
//    if (!cell) {
//        cell = [[NLConnectBloothCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
//    }
//    CBPeripheral *peripheral = [_dataArr[indexPath.row] objectForKey:@"peripheral"];
//    CBUUID *uuid = [CBUUID UUIDWithCFUUID:(__bridge CFUUIDRef _Nonnull)(peripheral.identifier)];
//    
//    cell.bloothName.text = peripheral.name;
//    cell.bloothUUID.text = [NSString stringWithFormat:@"%@",uuid];
//    return cell;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    CBPeripheral *peripheral = [_dataArr[indexPath.row] objectForKey:@"peripheral"];
//    CBUUID *uuid = [CBUUID UUIDWithCFUUID:(__bridge CFUUIDRef _Nonnull)(peripheral.identifier)];
//    [kAPPDELEGATE._loacluserinfo bluetoothUUID:[NSString stringWithFormat:@"%@",uuid]];
//    [[NSNotificationCenter defaultCenter] postNotificationName:NLConnectBloothSuccessNotification object:peripheral userInfo:nil];
//    
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)downBtnDown:(UIButton *)btn{
    switch (btn.tag - 1000) {
        case 0: {
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
        case 1: {
            [[NSNotificationCenter defaultCenter] postNotificationName:NLSearchBluetoothNotification object:nil];
            NLSearchBluetooth *searchVC = [[NLSearchBluetooth alloc] init];
            [searchVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:searchVC animated:YES];
            break;
        }
        default:
            break;
    }
}


- (UIColor *)downBackColor{
    UIColor *color = [@"ff8f8f" hexStringToColor];
    return color;
}
- (void)heartReatLab:(UILabel *)lab rang:(NSRange)rang{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:lab.text];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:[ApplicationStyle control_weight:30]] range:rang];
    lab.attributedText = str;
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
