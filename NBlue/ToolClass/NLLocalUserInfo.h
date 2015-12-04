//
//  NLLocalUserInfo.h
//  NBlue
//
//  Created by LYD on 15/11/27.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLLocalUserInfo : NSObject
/**
 *存设备名字
 */
- (void)setBluetoothName:(NSString *)bluetoothName;
/**
 *获取设备名字
 */
-(NSString *)getBluetoothName;
@end
