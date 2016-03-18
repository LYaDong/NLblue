//
//  NLBluetoothAgreementNew.m
//  NBlue
//
//  Created by 刘亚栋 on 16/2/27.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLBluetoothAgreementNew.h"
#import "NLBluetoothDataAnalytical.h"
#import "NLBluetoothCommand.h"
#import "NLSQLData.h"
static NLBluetoothAgreementNew *bluetoothagreement = nil;
static NSString *TranslationF6 = @"0AF6";
static NSString *TransLationF1 = @"0AF1";

@interface NLBluetoothAgreementNew ()<CBCentralManagerDelegate,CBPeripheralDelegate>
@property(nonatomic,strong)CBCentralManager *manger;//中心蓝牙
@property(nonatomic,strong)CBPeripheral *periperal;//外围蓝牙
@property(nonatomic,strong)NSMutableArray *equipmentArr;
//=========================处理数据的数组
@property(nonatomic,strong)NSMutableArray *sportDataArray;
@property(nonatomic,strong)NSMutableArray *sleepDataArray;
@property(nonatomic,strong)NSMutableArray *bluetoothArray;//设备数组
//=========================处理数据的数组
@property(nonatomic,strong)NSString *searchBluetoothStartJudge;
@property(nonatomic,assign)BOOL isbluetooth;
@end

@implementation NLBluetoothAgreementNew

+(NLBluetoothAgreementNew *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bluetoothagreement = [[NLBluetoothAgreementNew alloc] init];
    });
    return bluetoothagreement;
}

#pragma mark  通道指令指令

#pragma mark 0AF6通道
-(void)writeCharacteristicF6:(CBPeripheral *)peripheral data:(NSData *)data{
    CBUUID *charUUID = [CBUUID UUIDWithString:TranslationF6];
    for ( CBService *service in peripheral.services ) {
        for ( CBCharacteristic *characteristic in service.characteristics ) {
            if ([characteristic.UUID isEqual:charUUID]) {
                [peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
            }
        }
    }
}

#pragma mark 0AF1通道
-(void)writeCharacteristicF1:(CBPeripheral *)peripheral data:(NSData *)data{
    CBUUID *charUUID = [CBUUID UUIDWithString:TransLationF1];
    for ( CBService *service in peripheral.services ) {
        for ( CBCharacteristic *characteristic in service.characteristics ) {
            if ([characteristic.UUID isEqual:charUUID]) {
                [peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
            }
        }
    }
}



-(void)bluetoothInstantiation{
//    _isbluetooth = NO;
    _searchBluetoothStartJudge = NLSearchBluetoothStopNotification;//是否开始搜索蓝牙//默认停止
    _equipmentArr = [NSMutableArray array];
    //设置中心蓝牙和代理
    if (!_isbluetooth) {
        _manger = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        _manger.delegate = self;
//        [_manger scanForPeripheralsWithServices:nil options:nil];
        _periperal.delegate = self;//设置外围蓝牙代理
    }
    
    
    NSNotificationCenter *notifi= [NSNotificationCenter defaultCenter];
    [notifi addObserver:self selector:@selector(bluetoothSuccess:) name:NLConnectBloothSuccessNotification object:nil];
    [notifi addObserver:self selector:@selector(startBluetooth) name:NLSearchBluetoothNotification object:nil];
}
-(void)bluetoothSuccess:(NSNotification *)notifi{
    
    
    static int i = 0;
    i++;
    
    CBPeripheral *periperal = notifi.object;
    _periperal = periperal;
    [_manger connectPeripheral:_periperal options:nil];
    [kAPPDELEGATE._loacluserinfo setBluetoothName:periperal.name];
    [_manger stopScan];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)startBluetooth{
//    _searchBluetoothStartJudge = NLSearchBluetoothStartNotification;//开始
    [_manger scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@(YES)}];
}
-(void)dataArrayInstantiation{
    _sportDataArray = [NSMutableArray array];
    _sleepDataArray = [NSMutableArray array];
    _bluetoothArray = [NSMutableArray array];
}
-(void)searchBluetooth{
    [_manger scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@(YES)}];
}
-(void)cancleBluetooth{
    [_manger cancelPeripheralConnection:_periperal];
}


#pragma mark 蓝牙代理


-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:{
            [kAPPDELEGATE._loacluserinfo setBluetoothName:nil];//设备的名字
            if ([[kAPPDELEGATE._loacluserinfo getBlueToothUUID] length]>0) {
                [_manger scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@(YES)}];
            }
            NSLog(@"蓝牙已经打开，请扫描外设,请打开外围设备");
            break;
        }
        case CBCentralManagerStatePoweredOff: {
            _isbluetooth = !_isbluetooth;
            [kAPPDELEGATE._loacluserinfo setBluetoothName:nil];//设备的名字
            NSLog(@"蓝牙已关闭，请开启外设");
            break;
        }
        case CBCentralManagerStateResetting:{
            NSLog(@"重置中心设备");
            break;
        }
        case CBCentralManagerStateUnauthorized: {
            NSLog(@"授权中心设备");
            break;
        }
        case CBCentralManagerStateUnknown:  {
            NSLog(@"中心设备状态未知");
            break;
        }
        case CBCentralManagerStateUnsupported: {
            NSLog(@"不支持中心设备");
            break;
        }
        default:
            break;
    }
}


#pragma mark 扫描周边设备
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
//    NSLog(@"附近设备有:%@  UUID ==%@ ",peripheral.name,peripheral.identifier);
//    NSLog(@"name = %@ rssi %@",peripheral.name,peripheral.RSSI);
    
//    if ([_searchBluetoothStartJudge isEqualToString:NLSearchBluetoothStartNotification]) {
        if ([peripheral.name isEqualToString:@"WARMAN"]) {
            //        NSLog(@"name = %@ 信号强度 = %@   UUID = %@",peripheral.name,RSSI,peripheral.identifier);
            
            if (![_equipmentArr containsObject:peripheral]) {
                [_equipmentArr addObject:peripheral];
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setValue:RSSI forKey:@"RSSI"];
                [dic setValue:peripheral forKey:@"peripheral"];
                [_bluetoothArray addObject:dic];
                if (self.bluetoothDataArr) {
                    self.bluetoothDataArr(_bluetoothArray);
                }
            }
            if ([[kAPPDELEGATE._loacluserinfo getBlueToothUUID] length]>0) {
                NSLog(@"%@",[kAPPDELEGATE._loacluserinfo getBlueToothUUID]);
                CBUUID *blue_UUID = [CBUUID UUIDWithCFUUID:(__bridge CFUUIDRef _Nonnull)(peripheral.identifier)];
                NSString *blue_uuidstr = [NSString stringWithFormat:@"%@",blue_UUID];
                if ([blue_uuidstr isEqualToString:[kAPPDELEGATE._loacluserinfo getBlueToothUUID]]) {
                    _periperal = peripheral;
                    [_manger connectPeripheral:_periperal options:nil];
                    [kAPPDELEGATE._loacluserinfo setBluetoothName:peripheral.name];//设备的名字
                    [_manger stopScan];
                }
            }else{
                _periperal = peripheral;
                [_manger connectPeripheral:_periperal options:nil];
                [kAPPDELEGATE._loacluserinfo setBluetoothName:peripheral.name];//设备的名字
                [_manger stopScan];
//                CBUUID *uuid = [CBUUID UUIDWithCFUUID:(__bridge CFUUIDRef _Nonnull)(peripheral.identifier)];
//                [kAPPDELEGATE._loacluserinfo bluetoothUUID:[NSString stringWithFormat:@"%@",uuid]];
            }
        }
//    }
    
    
    
    
    
    
    

//
//    peripheral.delegate = self;
//    
//    
////    NSLog(@"%@",[CBUUID UUIDWithString:[kAPPDELEGATE._loacluserinfo getBlueToothUUID]]);
//    
//    
//
//    
////    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:[kAPPDELEGATE._loacluserinfo getBlueToothUUID]];
////    NSMutableArray *arr = [NSMutableArray arrayWithArray: [_manger retrievePeripheralsWithIdentifiers:@[uuid]]];
////
//    
//    
//    
//    
//    if ([[kAPPDELEGATE._loacluserinfo getBlueToothUUID] length]>0) {
//        CBUUID *blue_UUID = [CBUUID UUIDWithCFUUID:(__bridge CFUUIDRef _Nonnull)(peripheral.identifier)];
//        NSString *blue_uuidstr = [NSString stringWithFormat:@"%@",blue_UUID];
//        if ([blue_uuidstr isEqualToString:[kAPPDELEGATE._loacluserinfo getBlueToothUUID]]) {
//            _periperal = peripheral;
//            [_manger connectPeripheral:_periperal options:nil];
//            [kAPPDELEGATE._loacluserinfo setBluetoothName:peripheral.name];//设备的名字
//            [_manger stopScan];
//        }
//    }
}


#pragma mark 中央设备的代理事件

#pragma mark 已经连接到设备
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    peripheral.delegate=self;
    [peripheral discoverServices:nil];
    _isbluetooth = !_isbluetooth;
    NSLog(@"连接成功");
    CBUUID *uuid = [CBUUID UUIDWithCFUUID:(__bridge CFUUIDRef _Nonnull)(peripheral.identifier)];
    [kAPPDELEGATE._loacluserinfo bluetoothUUID:[NSString stringWithFormat:@"%@",uuid]];
    if (self.bluetoothSuccess) {
        self.bluetoothSuccess(EquiomentConnectionSuccess);
    }
}
#pragma mark 连接失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"连接失败： %@",error);
    _isbluetooth = !_isbluetooth;
}
#pragma mark 断开连接
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    [kAPPDELEGATE._loacluserinfo setBluetoothName:nil];//设备的名字
    NSLog(@"蓝牙断开连接：%@",error);
}

#pragma mark 周围设备的代理事件

#pragma mark 已搜索到周边设备
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    //对接对应的服务
    for (CBService *s in peripheral.services) {
        [peripheral discoverCharacteristics:nil forService:s];
    }
}
#pragma mark 搜索到周围设备的特点
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    for (CBCharacteristic *c in service.characteristics) {
        CBUUID *charUUIDF1 = [CBUUID UUIDWithString:TransLationF1];
        CBUUID *charUUIDF6 = [CBUUID UUIDWithString:TranslationF6];
        if ([charUUIDF1 isEqual:c.UUID] || [charUUIDF6 isEqual:c.UUID]) {
        }else{
            //给所有外设发送通知其代理，获取新的值
            [peripheral setNotifyValue:YES forCharacteristic:c];
        }
    }
    [self connect];//连接成功处理事情
}


#pragma mark 搜索到char
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    
    if (error) {
        NSLog(@"错误：==  %@",error);
        return;
    }
    unsigned char data[characteristic.value.length];
    //    [characteristic.value getBytes:&data];
    //    getBytes:length  新方法 试试
    [characteristic.value getBytes:&data length:characteristic.value.length];
    NSString *value = [self hexStringForData:characteristic.value];
    [self handleGetData:value];
    
}
//#pragma mark  中心读取外围设备
//-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
//    
//    // 通知开始
//    if (characteristic.isNotifying) {
////        [peripheral readValueForCharacteristic:characteristic];
//    } else { // 通知结束
//        // so disconnect from the peripheral
//        NSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
//
//    }
//}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error {
}

#pragma mark --算法
- (NSString*)hexStringForData:(NSData*)data
{//将NSData转为字符串
    if (data == nil) {
        return nil;
    }
    NSMutableString* hexString = [NSMutableString string];
    Byte *testByte = (Byte *)[data bytes];
    for(int i=0;i<[data length];i++){
        [hexString appendFormat:@"%02x",testByte[i]];
    }
    return hexString;
}

#pragma mark 处理事件

-(void)handleGetData:(NSString *)dataStr{
    NSLog(@"蓝牙传输数据:   %@",dataStr);
    if ([dataStr isEqualToString:EquiomentCommandEndSportBlue]) {
        //结束完运动数据之后开始数据睡眠
        [self sleepDataQuery];
    }
    [self hanldReturnSportData:dataStr];
    [self hanldReturnSleepData:dataStr];
    [self hanldReturnHeating:dataStr];
    [self hanldReturnQueryTempe:dataStr];
    [self hanldReturnBatteryA:dataStr];
    [self hanldReturnBatteryB:dataStr];
    [self hanldReturnMac:dataStr];
}
//81:be:16:d0:df:fc

-(void)connect{
    if (![[kAPPDELEGATE._loacluserinfo getBlueToothTime] isEqualToString:@"1"]) {
        [kAPPDELEGATE._loacluserinfo bluetoothSetTime:@"1"];
        [self setEquipmentTime];//第一次连接设备的时候设置设备时间
    }
    
//    [self setANCSNotification];
//    [self setSubclassSwitch];
//    [self setSuperclassSwitch];
    //==================分割线================
    [self connectShock];
    [[SMProgressHUD shareInstancetype] showLoadingWithTip:EquiomentRefresh];
    [self sportDataQuery];
    [self setTatget];
    [self queryTemperatureEquiment];
    
    
    [self queryAunitLevel];//获得设备信息
    [self getBluetoothMac];//获得设备MAC地址

    
}
-(void)setANCSNotification{
    NSData *data = [NLBluetoothCommand setANCSNotification];
    [self writeCharacteristicF6:_periperal data:data];
}
-(void)setEquipmentTime{
    NSData *data = [NLBluetoothCommand setEquipmentTime];
    [self writeCharacteristicF6:_periperal data:data];
}
//设置子开关
-(void)setSubclassSwitch{
    NSData *data = [NLBluetoothCommand setSubclassSwitch];
    [self writeCharacteristicF6:_periperal data:data];
}
//设置总开关
-(void)setSuperclassSwitch{
    NSData *data = [NLBluetoothCommand setSuperclassSwitch];
    [self writeCharacteristicF6:_periperal data:data];
}
//开始活动运动数据
-(void)sportDataQuery{
    NSData *dataStart = [NLBluetoothCommand startSynchronizationSportData];
    [self writeCharacteristicF1:_periperal data:dataStart];
    NSData *dataSport = [NLBluetoothCommand sportDataQuery];
    [self writeCharacteristicF1:_periperal data:dataSport];
}
//开始活动睡眠数据
-(void)sleepDataQuery{
    NSData *dataStart = [NLBluetoothCommand startSynchronizationSportData];
    [self writeCharacteristicF1:_periperal data:dataStart];
    NSData *dataSleep = [NLBluetoothCommand sleepDataQuery];
    [self writeCharacteristicF1:_periperal data:dataSleep];
}
//设置温度时间
- (void)setTemperatureAndTime:(NSInteger)temperature time:(NSInteger)temperatureTime{
    NSData *data = [NLBluetoothCommand setTemperatureAndTime:temperature time:temperatureTime];
    [self writeCharacteristicF6:_periperal data:data];
}
//开始加热指令
-(void)setTemperatureStart{
    NSData *data = [NLBluetoothCommand setTemperatureStart];
    [self writeCharacteristicF6:_periperal data:data];
}
//结束加热指令
-(void)setTemperatureEnd{
    NSData *data = [NLBluetoothCommand setTemperatureEnd];
    [self writeCharacteristicF6:_periperal data:data];
}
//查询温度
-(void)queryTemperatureEquiment{
    NSData *data = [NLBluetoothCommand queryTemperatureEquipment];
    [self writeCharacteristicF6:_periperal data:data];
}
//查询A单元电量
-(void)queryAunitLevel{
    NSData *data = [NLBluetoothCommand queryAUnitLevel];
    [self writeCharacteristicF6:_periperal data:data];
}
//查询B单元电量
-(void)queryBunitLevel{
    NSData *data = [NLBluetoothCommand queryBUnitLevel];
    [self writeCharacteristicF6:_periperal data:data];
}
//连接震动
-(void)connectShock{
    NSData *data = [NLBluetoothCommand connectShonk];
    [self writeCharacteristicF6:_periperal data:data];
}
//重启设备
-(void)connectReseart{
    NSData *data = [NLBluetoothCommand connectRestart];
    [self writeCharacteristicF6:_periperal data:data];
}
//目标设置
-(void)setTatget{
    NSData *data = [NLBluetoothCommand setSportTarget];
    [self writeCharacteristicF6:_periperal data:data];
}
-(void)getBluetoothMac{
    NSData *data = [NLBluetoothCommand setBluetoothMAC];
    [self writeCharacteristicF6:_periperal data:data];
}

#pragma mark 处理返回数据
#pragma mark 处理运动返回数据
-(void)hanldReturnSportData:(NSString *)dataStr{
    if (dataStr.length<=4) {
        return;
    }
    //当收到运动结束的时候刷新页面
    if ([dataStr isEqualToString:EquiomentCommandEndSleepBlue]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:RefrefhSleepDataNotification object:nil];
    }
    NSString *format = [dataStr substringWithRange:NSMakeRange(0, 4)];
    if ([format isEqualToString:EquiomentCommand_0803]) {
        [_sportDataArray addObject:dataStr];
        if (_sportDataArray.count==34) {
            [NLBluetoothDataAnalytical blueSportOrdinArrayData:_sportDataArray];
        }
    }
}

-(void)hanldReturnSleepData:(NSString *)dataStr{
    if (dataStr.length<=4) {
        return;
    }
    //当收到睡眠结束的时候刷新页面
    if ([dataStr isEqualToString:EquiomentCommandEndSportBlue]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:RefrefhStopDataNotification object:nil];
    }
    if ([dataStr isEqualToString:EquiomentCommandEndSleepBlue]){
        [[SMProgressHUD shareInstancetype] dismiss];
    }
    
    NSString *format = [dataStr substringWithRange:NSMakeRange(0, 4)];
    if ([format isEqualToString:EquiomentCommand_0804]) {
        [_sleepDataArray addObject:dataStr];
        //        NSLog(@"%@",[NLBluetoothDataAnalytical tenturnSinTenNew:[[sleepDatas substringWithRange:NSMakeRange(sleepDatas.length-2, 2)] integerValue]]);
        NSString *count = [NLBluetoothDataAnalytical tenturnSinTenNew:[[dataStr substringWithRange:NSMakeRange(dataStr.length-2, 2)] integerValue]];
        if (_sleepDataArray.count>=[count integerValue]) {
            [NLBluetoothDataAnalytical bluesleepOrdinArrayData:_sleepDataArray];
        }
    }
}
#pragma mark 处理加热返回
-(void)hanldReturnHeating:(NSString *)dataStr{
    if ([dataStr isEqualToString:EquiomentCommand_9001]) {
        if (self.heating) {
            self.heating(self);
        }
    }
}
//返回加热温度
-(void)hanldReturnQueryTempe:(NSString *)dataStr{
    if (dataStr.length<=4) {
        return;
    }
    NSString *to = [dataStr substringWithRange:NSMakeRange(0, 4)];
    if ([to isEqualToString:EquiomentCommand_9002]) {
        if (self.queryTempertureStr) {
            self.queryTempertureStr(dataStr);
        }
    }
}


#pragma mark 电池电量反会
//A单元电池电量返回
-(void)hanldReturnBatteryA:(NSString *)dataStr{
    if ([[dataStr substringWithRange:NSMakeRange(0, 4)] isEqualToString:EquiomentCommand_0201]) {
        //存储版本号
        NSString *edition = [dataStr substringWithRange:NSMakeRange(8, 2)];
        long editionNum = [NLBluetoothDataAnalytical sixTenHexTeen:edition];
        [kAPPDELEGATE._loacluserinfo setBluetoothEdition:[NSString stringWithFormat:@"%ld",editionNum]];
        if (self.batteryLevelA) {
            self.batteryLevelA(dataStr,self);
        }
    }
}
//B单元电池电量返回
-(void)hanldReturnBatteryB:(NSString *)dataStr{
    if ([[dataStr substringWithRange:NSMakeRange(0, 4)] isEqualToString:EquiomentCommand_9004]) {
        if (self.batteryLevelB) {
            self.batteryLevelB(dataStr);
        }
    }
}
//MAC地址处理返回
-(void)hanldReturnMac:(NSString *)dataStr{
    if ([[dataStr substringWithRange:NSMakeRange(0, 4)] isEqualToString:EquiomentCommand_0204]) {
        NSString *count = [dataStr substringWithRange:NSMakeRange(4, dataStr.length - 4)];
        [kAPPDELEGATE._loacluserinfo setBluetoothMAC:[ApplicationStyle stringMosiac:count mosiacSymbolStr:@":" index:2]];
    }
}
//#pragma mark 加热返回
//-(void)hanldReturnTemperature:(NSString *)dataStr{
//    NSLog(@"%@",dataStr);
//}
@end
