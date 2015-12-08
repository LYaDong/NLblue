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
/**
 *用户token
 */
-(void)SetUserAccessToken:(NSString*)accessToken;
/**
 *获得用户token
 */
-(NSString *)GetAccessToken;
/**
 *用户ID
 */
-(void)SetUser_ID:(NSString *)user_id;
/**
 *获得用户ID
 */
-(NSString *)GetUser_ID;
/**
 *判断用户进入哪个页面
 */
-(void)goControllew:(NSString *)controllews;
/**
 *获得用户进入的页面
 */
-(NSString *)getControllew;
@end
