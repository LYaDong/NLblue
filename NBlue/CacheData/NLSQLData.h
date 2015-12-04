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
@end
