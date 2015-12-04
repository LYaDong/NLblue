//
//  NLBluetoothDataAnalytical.h
//  NBlue
//
//  Created by LYD on 15/11/23.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLBluetoothDataAnalytical : NSObject
/**
 *10进制转16进制
 */
+(NSString *)tenTurnSixTeen:(NSInteger)index;
/**
 *蓝牙命令获得数据解析判断
 */
+(void)bluetoothCommandReturnData:(NSString *)data;


@end
