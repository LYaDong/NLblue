//
//  PlistData.h
//  NBlue
//
//  Created by LYD on 15/11/26.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistData : NSObject
/**
 *个人信息数据存储
 */
+(void)individuaData:(NSDictionary *)dic;
/**
 *获取个人信息存储
 */
+(NSMutableDictionary *)getIndividuaData;
/**
 * 当前设备存储
 */
+(void)userBloothEquipment:(NSArray *)arr;
/**
 * 获取当期设备
 */
+(NSMutableArray *)getUserBloothEquipment;
@end
