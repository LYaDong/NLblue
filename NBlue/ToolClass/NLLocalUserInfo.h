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
 *0：登录页面 1：主页面 女  2 ： 男主页面
 */
-(void)goControllew:(NSString *)controllews;
/**
 *获得用户进入的页面
 *0：登录页面 1：主页面
 */
-(NSString *)getControllew;
/**
 *判断是否登录
 *0：未登录 1：已经登录
 */
-(void)isLoginUser:(NSString *)isLogin;
/**
 *获得是否登录
 *0：未登录 1：已经登录
 */
-(NSString *)GetIsLogin;
/**
 *  输入用户性别
 *  0：女性    1：男性
 */
-(void)userGender:(NSString *)gender;
/**
 *  获得用户性别
 *  0：女性    1：男性
 */
-(NSString *)getUserGender;
/**
 *上次来经期的时间
 * @param date 字符串时间
 */
-(void)lastTimeGoPeriodDate:(NSString *)date;
/**
 *  获得上次来的时间
 * 
 */
-(NSString *)getLastTimeGoPeriodDate;
@end
