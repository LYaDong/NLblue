//
//  NLBluetoothAgreementNew.h
//  NBlue
//
//  Created by 刘亚栋 on 16/2/27.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
typedef void (^BluetoothDataArr)(NSMutableArray *array);
typedef void (^BatteryLevelB)(NSString *battery);
typedef void (^BluetoothSuccess) (NSString *bluetoothSuccess);
@interface NLBluetoothAgreementNew : NSObject
//-------------------------------------------------------------------------------------
typedef void (^HanldHeating) (NLBluetoothAgreementNew *heating);
typedef void (^BatteryLevelA)(NSString *battery,NLBluetoothAgreementNew *bluetooth);
typedef void (^QueryTemperure)(NSString *temperture);


@property(nonatomic,strong)HanldHeating heating;
@property(nonatomic,strong)QueryTemperure queryTempertureStr;
@property(nonatomic,strong)BatteryLevelA batteryLevelA;
@property(nonatomic,strong)BatteryLevelB batteryLevelB;
@property(nonatomic,strong)BluetoothDataArr bluetoothDataArr;//返回搜索到的设备
@property(nonatomic,strong)BluetoothSuccess bluetoothSuccess;


+(NLBluetoothAgreementNew *)shareInstance;
-(void)bluetoothInstantiation;
-(void)dataArrayInstantiation;
/**
 * 搜索蓝牙
 */
-(void)searchBluetooth;
/**
 * 断开蓝牙
 */
-(void)cancleBluetooth;
/**
 * 开始获得运动数据
 */
-(void)sportDataQuery;
/**
 * 开始获得睡眠数据
 */
-(void)sleepDataQuery;
/**
 * 查询A单元电量
 */
-(void)queryAunitLevel;
/**
 * 查询B单元电量
 */
-(void)queryBunitLevel;
/**
 *开始加热指令
 */
-(void)setTemperatureStart;
/**
 *结束加热指令
 */
-(void)setTemperatureEnd;
/**
 *设置温度和时间
 */
- (void)setTemperatureAndTime:(NSInteger)temperature time:(NSInteger)temperatureTime;
/**
 * 重启设备
 */
-(void)connectReseart;
@end
