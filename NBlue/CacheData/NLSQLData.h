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
+(NSString *)sportDayTaskData:(NSString *)timeDay;


+(void)establishSportDataTable;
+(void)insterSportData:(NSArray *)dataArr
              isUpdata:(NSInteger)updata;
/**
 *根据时间获取数据
 */
+(NSMutableArray *)sportDataObtainTimeStr:(NSString *)timeStr;
/**
 *更新数据
 */
+(void)upDataSport:(NSArray *)arr isUpdata:(NSInteger)updata;
/**
 *删除运动表
 */
+(void)delSportDataTable;
/**
 *获取大表数据
 */
+(NSMutableArray *)obtainSportDataBig;
/**
 *创建日历表
 */
+(void)canlenderUncomfortable;
/**
 *给日历表先创建字段，后面获得数据之后更新
 */
+(void)insterCanlenderData;
/**
 *更新日历爱爱数据
 */
+(void)upDataCanlenderLoveLove:(NSDictionary *)dic;
/**
 *更新日历生活习惯数据
 */
+(void)upDataCanlenderhabitsAndCustoms:(NSDictionary *)dic;
/**
 *更新日历不舒服数据
 */
+(void)upDataCanlenderuncomfortable:(NSDictionary *)dic;
/**
 * @param 获取日历数据
 */
+(NSMutableDictionary *)canlenderDayData:(NSString *)dayTime;
/**
 * 创建睡眠表
 */
+ (void)sleepDataTable;
/**
 * 添加睡眠数据
 */
+ (void)insterSleepData:(NSArray *)dataArr isUpdata:(NSInteger)updata;
/**
 * 获取睡眠数据
 */
+ (NSMutableArray *)sleepDataObtain;

@end
