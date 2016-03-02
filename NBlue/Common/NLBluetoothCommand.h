//
//  NLBluetoothCommand.h
//  NBlue
//
//  Created by 刘亚栋 on 16/2/27.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLBluetoothCommand : NSObject
/**
 *设置设备时间
 */
+(NSData *)setEquipmentTime;
/**
 *开始同步数据
 */
+ (NSData *)startSynchronizationSportData;
/**
 *获得运动数据
 */
+ (NSData *)sportDataQuery;
/**
 *获得睡眠数据
 */
+ (NSData *)sleepDataQuery;
/**
 *开始加热
 */
+ (NSData *)setTemperatureStart;
/**
 *结束加热
 */
+ (NSData *)setTemperatureEnd;
/**
 *查询温度
 */
+ (NSData *)queryTemperatureEquipment;
/**
 *设置温度时间
 */
+ (NSData *)setTemperatureAndTime:(NSInteger)temperature time:(NSInteger)temperatureTime;
/**
 *设置连接系统ANCS，只要连接蓝牙，就调用此方法
 */
+ (NSData *)setANCSNotification;
/**
 *连接子开关，带来电提醒
 */
+ (NSData *)setSubclassSwitch;
/**
 *连接总开关，只是连接
 */
+ (NSData *)setSuperclassSwitch;
/**
 *查询A单元电池电量
 */
+(NSData *)queryAUnitLevel;
/**
 *查询B单元电池电量
 */
+(NSData *)queryBUnitLevel;
/**
 * 连接设备震动
 */
+(NSData *)connectShonk;
/**
 * 重启设备
 */
+(NSData *)connectRestart;
@end
