//
//  NLSQLData.h
//  NBlue
//
//  Created by LYD on 15/11/27.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLSQLData : NSObject
/**
 *设备的信息
 */
+(void)bluetoothEquipmentInformation:(NSDictionary *)dic;
/**
 *获得设备的信息
 */
+(NSMutableDictionary *)getBluetoothEquipmentInformation;
/**
 *删除表
 */
+(void)deleEquiomentINformation;
/**
 *存运动数据
 */
+(void)sportRecordCreateData:(NSArray *)arr isDeposit:(NSInteger)isDeposit;
/**
 *蓝牙获取运动
 */
+(void)sportBlueData:(NSDictionary *)sportData;
+(void)delDateSportData:(NSString *)date;
+(NSMutableArray *)sportRecordGetData;
@end
