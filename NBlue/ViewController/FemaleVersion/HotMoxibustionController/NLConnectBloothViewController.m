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
@interface NLConnectBloothViewController ()<UITableViewDataSource,UITableViewDelegate>
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
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(200, 20, 44, 44);
    [btn setTitle:@"刷新" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnDOwn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
}
-(void)btnDOwn{
    [_dataArr removeAllObjects];
    [_mainTableView reloadData];
}
-(void)buildUI{
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize], SCREENWIDTH, SCREENHEIGHT - ([ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize])) style: UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];
}

-(void)bloothView{
    
    NLBluetoothAgreement *blue = [NLBluetoothAgreement shareInstance];
    [blue bluetoothAllocInit];
    blue.getEquiment = ^(NSArray *perpheral){
        [_dataArr removeAllObjects];
        [_dataArr addObjectsFromArray:perpheral];
        [_mainTableView reloadData];
    };
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"LYD";
    NLConnectBloothCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[NLConnectBloothCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    CBPeripheral *peripheral = _dataArr[indexPath.row];
    CBUUID *uuid = [CBUUID UUIDWithCFUUID:(__bridge CFUUIDRef _Nonnull)(peripheral.identifier)];
    
    cell.bloothName.text = peripheral.name;
    cell.bloothUUID.text = [NSString stringWithFormat:@"%@",uuid];
    
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CBPeripheral *peripheral = _dataArr[indexPath.row];
    CBUUID *uuid = [CBUUID UUIDWithCFUUID:(__bridge CFUUIDRef _Nonnull)(peripheral.identifier)];
    [kAPPDELEGATE._loacluserinfo bluetoothUUID:[NSString stringWithFormat:@"%@",uuid]];
    [[NSNotificationCenter defaultCenter] postNotificationName:NLConnectBloothSuccessNotification object:peripheral userInfo:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
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
