//
//  NLBluetoothAgreement.m
//  NBlue
//
//  Created by LYD on 15/11/18.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLBluetoothAgreement.h"


static NLBluetoothAgreement *bluetoothagreement = nil;

@interface NLBluetoothAgreement()<CBCentralManagerDelegate,CBPeripheralDelegate>
{
    
}

@property(nonatomic,strong)CBCentralManager *manger;//中心蓝牙
@property(nonatomic,strong)CBPeripheral *periperal;//外围蓝牙
@property(nonatomic,strong)CBService *cbServices;//服务
@property(nonatomic,strong)CBCharacteristic *cbCharacteristcs;//服务特征
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *dataServices;
@property(nonatomic,strong)NSMutableArray *dataCharcteristics;
@property(nonatomic,strong)NSString *connectionSuccess;
@property(nonatomic,strong)NSMutableArray *equipmentArr;
@property(nonatomic,strong)NSMutableArray *equipDataArray;

@end

@implementation NLBluetoothAgreement

static NSString *TranslationF6 = @"0AF6";
static NSString *TransLationF1 = @"0AF1";

+(NLBluetoothAgreement *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bluetoothagreement = [[NLBluetoothAgreement alloc] init];
    });
    
    return bluetoothagreement;
}

#pragma mark 实例化蓝牙

-(void)bluetoothAllocInit{
    
    _equipmentArr = [NSMutableArray array];
    _equipDataArray = [NSMutableArray array];
    self.arrPeripheral = [NSMutableArray array];//传设备名字
    
    _manger = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    _manger.delegate = self;
    [_manger scanForPeripheralsWithServices:nil options:nil];
    
    _periperal.delegate = self;
    
    _dataArr = [NSMutableArray arrayWithCapacity:0];
    _dataCharcteristics = [NSMutableArray arrayWithCapacity:0];
    _dataServices = [NSMutableArray  arrayWithCapacity:0];
    
    
//    NSNotificationCenter *notifi= [NSNotificationCenter defaultCenter];
//    [notifi addObserver:self selector:@selector(logInSuccess:) name:NLConnectBloothSuccessNotification object:nil];
    
}


//连接设备
-(void)logInSuccess:(NSNotification *)notifi{
    CBPeripheral *periperal = notifi.object;
    _periperal = periperal;
    
    [_manger connectPeripheral:_periperal options:nil];
    [_dataArr removeAllObjects];
    [_dataArr addObject:periperal];
    [kAPPDELEGATE._loacluserinfo setBluetoothName:periperal.name];
    if(self.perheral){//返回当前的外围设备
        self.perheral(_dataArr); 
    }
    [_manger stopScan];
}
#pragma mark 检测设备

-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
        {
            [_manger scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@(YES)}];
//            NSLog(@"蓝牙已经打开，请扫描外设");
//            if(self.getConnectData){
//                self.getConnectData(@"蓝牙已经打开，请扫描外设,请打开外围设备");
//            }
            NSLog(@"蓝牙已经打开，请扫描外设,请打开外围设备");
            break;
        }
        case CBCentralManagerStatePoweredOff:
        {
            _connectionSuccess = EquiomentConnectionFiale;
            [self disconnect];
            NSLog(@"蓝牙已关闭，请开启外设");
            break;
        }
        case CBCentralManagerStateResetting:
        {
            NSLog(@"重置中心设别");
            break;
        }
        case CBCentralManagerStateUnauthorized:
        {
            NSLog(@"授权中心设备");
            break;
        }
        case CBCentralManagerStateUnknown:
        {
            NSLog(@"中心设备状态未知");
            break;
        }
        case CBCentralManagerStateUnsupported:
        {
            NSLog(@"不支持中心设备");
            break;
        }
        default:
            break;
    }
}

#pragma mark 扫描周边设备
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    NSLog(@"附近设备有:%@  UUID ==%@ ",peripheral.name,peripheral.identifier);
    if (![_equipmentArr containsObject:peripheral]) {
        [_equipmentArr addObject:peripheral];
        if (self.getEquiment) {
            self.getEquiment(_equipmentArr);
        }
    }

    peripheral.delegate = self;
    if ([[kAPPDELEGATE._loacluserinfo getBlueToothUUID] length]>0) {
        CBUUID *blue_UUID = [CBUUID UUIDWithCFUUID:(__bridge CFUUIDRef _Nonnull)(peripheral.identifier)];
        NSString *blue_uuidstr = [NSString stringWithFormat:@"%@",blue_UUID];
        
        if ([blue_uuidstr isEqualToString:[kAPPDELEGATE._loacluserinfo getBlueToothUUID]]) {
            _periperal = peripheral;
            [_manger connectPeripheral:_periperal options:nil];
            [self.arrPeripheral removeAllObjects];
            [self.arrPeripheral addObject:peripheral];
            [_dataArr removeAllObjects];
            [_dataArr addObject:peripheral];
            [kAPPDELEGATE._loacluserinfo setBluetoothName:peripheral.name];
            if(self.perheral){//返回当前的外围设备
                self.perheral(_dataArr);
            }
            [_manger stopScan];
        }
    }
}

#pragma mark 中央设备的代理事件

#pragma mark 已经连接到设备
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    peripheral.delegate=self;
    [peripheral discoverServices:nil];
    NSLog(@"连接成功");
    _connectionSuccess = EquiomentConnectionSuccess;
}
#pragma mark 连接失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"连接失败： %@",error);
}
#pragma mark 断开连接
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    
    NSLog(@"蓝牙断开连接：%@",error);
    
//    [_manger connectPeripheral:_periperal options:nil];
    
    _periperal = nil;
    _connectionSuccess = EquiomentConnectionFiale;
    [self disconnect];
}

#pragma mark 周围设备的代理事件

#pragma mark 已搜索到周边设备
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    int i =0 ;
    for (CBService *s in peripheral.services) {
        [self.dataServices addObject:s];
    }
    
    //对接对应的服务
    for (CBService *s in peripheral.services) {
        i++;
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
                [_dataCharcteristics addObject:c];
                //给所有外设发送通知其代理，获取新的值
                [peripheral setNotifyValue:YES forCharacteristic:c];
        }
    }
    if ([_connectionSuccess isEqualToString:EquiomentConnectionSuccess]) {
        if (self.getConnectionSuccess) {
            self.getConnectionSuccess(EquiomentConnectionSuccess);
        }
    }    
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
    [self explainOrder:value];

}
#pragma mark  中心读取外围设备
-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    // 通知开始
    if (characteristic.isNotifying) {
//        [peripheral readValueForCharacteristic:characteristic];
    } else { // 通知结束
        // so disconnect from the peripheral
        NSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
        //   [cbCM cancelPeripheralConnection:peripheral];
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error {
    if (error == nil) {
        
    }
}

//设置通知
-(void)notifyCharacteristic:(CBPeripheral *)peripheral
             characteristic:(CBCharacteristic *)characteristic{
    //设置通知，数据通知会进入：didUpdateValueForCharacteristic方法
    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    
}

//取消通知
-(void)cancelNotifyCharacteristic:(CBPeripheral *)peripheral
                   characteristic:(CBCharacteristic *)characteristic{
    
    [peripheral setNotifyValue:NO forCharacteristic:characteristic];
}

#pragma mark 暂且用不到
/*
#pragma  mark 把字符串转为Data

- (NSMutableData *)stringFromHex:(NSString *)str
{//将字符串转为NSData
    NSMutableData *stringData = [[NSMutableData alloc] init];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [str length] / 2; i++) {
        byte_chars[0] = [str characterAtIndex:i*2];
        byte_chars[1] = [str characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 18);
        [stringData appendBytes:&whole_byte length:1];
    }
    return stringData;
}
*/
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





#pragma mark --translate zhilin
-(void)explainOrder:(NSString *)buff
{
    
    NSLog(@"%@",buff);
    
    
    if (buff.length <4) {
        return;
    }
    
    
    NSLog(@"%@",buff);
    
    
    if ([[buff substringWithRange:NSMakeRange(0, 4)] isEqualToString:EquiomentCommand_0201] || [[buff substringWithRange:NSMakeRange(0, 4)] isEqualToString:EquiomentCommand_9004]) {
        if (self.returnBatteryLevel) {
            self.returnBatteryLevel(buff);
        }
        return;
    }
    
    if(self.getConnectData){
        self.getConnectData(buff);
    }

    if ([_connectionSuccess isEqualToString:EquiomentConnectionSuccess]) {
        if (self.getConnectionSuccess) {
            self.getConnectionSuccess(EquiomentConnectionSuccess);
        }
    }
}

-(void)disconnect{
    if ([_connectionSuccess isEqualToString:EquiomentConnectionFiale]) {
        if (self.getConnectionSuccess) {
            self.getConnectionSuccess(EquiomentConnectionFiale);
        }
    }
}
-(void)getExplainOrderShowLaber:(NSString *)ss{
    
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


#pragma mark 命令或者返回数据接收








@end
