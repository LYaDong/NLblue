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
 * 插入临时数据
 */
+(void)insterCanlenderDysmenorrheaDateData:(NSDictionary *)dic;
/**
 * 更新日历信息
 */
+(void)upDateCanlendarData:(NSArray *)arr;
/**
 * 更新日历爱爱数据
 */
+(void)upDataCanlenderLoveLove:(NSDictionary *)dic;
/**
 * 更新日历生活习惯数据
 */
+(void)upDataCanlenderhabitsAndCustoms:(NSDictionary *)dic;
/**
 * 更新日历不舒服数据
 */
+(void)upDataCanlenderuncomfortable:(NSDictionary *)dic;
/**
 * 更新日历痛经程度
 */
+(void)upDataCanlenderDysmenorrheaLevel:(NSDictionary *)dic;
/**
 * 获取日历数据
 */
+(NSMutableDictionary *)canlenderDayData:(NSString *)dayTime;
/**
 * 根据月份获得有没有大姨妈
 */
+(NSMutableDictionary *)canlenderDysmenorrheaDateData:(NSString *)dayTime;
/**
 * 创建睡眠表
 */
+ (void)sleepDataTable;
/**
 * 添加睡眠数据
 */
+ (void)insterSleepData:(NSArray *)dataArr isUpdata:(NSInteger)updata;
/**
 * 更新数据
 */
+(void)upDataSleep:(NSArray *)arr isUpdata:(NSInteger)updata;
/**
 * 获取睡眠数据
 */
+ (NSMutableArray *)sleepDataObtain;
/**
 * 根据时间获取当天睡眠数据
 */
+(NSMutableArray *)sleepDataObtainTime:(NSString *)time;
/**
 * 填写我的消息
 */
+(void)myMessage:(NSMutableArray *)array;
/**
 * 获得我的消息
 */
+(NSMutableArray *)getMyMessageData;
/**
 * 删除我的消息
 */
+(void)deleMyMessage;

@end
