//
//  NLLocalUserInfo.m
//  NBlue
//
//  Created by LYD on 15/11/27.
//  Copyright © 2015年 LYD. All rights reserved.
//






#import "NLLocalUserInfo.h"

@implementation NLLocalUserInfo
-(void)setBluetoothName:(NSString *)bluetoothName{
    [[NSUserDefaults standardUserDefaults] setObject:bluetoothName forKey:@"NL_Project_bluetoothName"];
    [NSUserDefaults standardUserDefaults];
}
-(NSString *)getBluetoothName{
    NSString *infoType = [[NSUserDefaults standardUserDefaults] stringForKey:@"NL_Project_bluetoothName"];
    return infoType;
}

//用户accessToken
-(void)SetUserAccessToken:(NSString*)accessToken
{
    [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"NL_User_Project_accessToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)GetAccessToken
{
    NSString *infotype = [[NSUserDefaults standardUserDefaults] stringForKey:@"NL_User_Project_accessToken"];
    return infotype;
}
//用户ID
-(void)SetUser_ID:(NSString *)user_id{
    [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:@"NL_User_Project_userID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)GetUser_ID{

    NSString *infotype = [[NSUserDefaults standardUserDefaults] stringForKey:@"NL_User_Project_userID"];
    return infotype;
}

-(void)goControllew:(NSString *)controllews{
    [[NSUserDefaults standardUserDefaults] setObject:controllews forKey:@"NL_User_Project_Conllew"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)getControllew{
    NSString *infotype = [[NSUserDefaults standardUserDefaults] stringForKey:@"NL_User_Project_Conllew"];
    return infotype;
}

//是否登录过
-(void)isLoginUser:(NSString *)isLogin{
    [[NSUserDefaults standardUserDefaults] setObject:isLogin forKey:@"NL_User_Project_IsLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)GetIsLogin{
    NSString *infotype = [[NSUserDefaults standardUserDefaults] stringForKey:@"NL_User_Project_IsLogin"];
    return infotype;
}
//性别
-(void)userGender:(NSString *)gender{
    [[NSUserDefaults standardUserDefaults] setObject:gender forKey:@"NL_User_Project_Gender"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)getUserGender{
    NSString *infotype = [[NSUserDefaults standardUserDefaults] stringForKey:@"NL_User_Project_Gender"];
    return infotype;
}
//上次月经来的时间
-(void)lastTimeGoPeriodDate:(NSString *)date{
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"NL_User_LastTime_Period"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)getLastTimeGoPeriodDate{
    NSString *period = [[NSUserDefaults standardUserDefaults] stringForKey:@"NL_User_LastTime_Period"];
    return period;
}
-(void)bluetoothUUID:(NSString *)UUID{
    [[NSUserDefaults standardUserDefaults] setObject:UUID forKey:@"NL_User_Bluetooth_UUID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getBlueToothUUID{
    NSString *period = [[NSUserDefaults standardUserDefaults] stringForKey:@"NL_User_Bluetooth_UUID"];
    return period;
}
//设置时间
-(void)bluetoothSetTime:(NSString *)time{
    [[NSUserDefaults standardUserDefaults] setObject:time forKey:@"NL_User_Bluetooth_time"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)getBlueToothTime{
    NSString *period = [[NSUserDefaults standardUserDefaults] stringForKey:@"NL_User_Bluetooth_time"];
    return period;
}
-(void)userLogInTime:(NSString *)time{
    [[NSUserDefaults standardUserDefaults] setObject:time forKey:@"NL_User_Loging_time"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)getUserLogInTime{
    NSString *period = [[NSUserDefaults standardUserDefaults] stringForKey:@"NL_User_Loging_time"];
    return period;
}

-(void)userBlothEquipment:(NSData *)equopent{
    [[NSUserDefaults standardUserDefaults] setObject:equopent forKey:@"NL_User_bloth_equment"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSData *)getUserBlothEquipment{
//    NSString *period = [[NSUserDefaults standardUserDefaults] stringForKey:@"NL_User_bloth_equment"];
   NSData *data = [[NSUserDefaults standardUserDefaults] dataForKey:@"NL_User_bloth_equment"];
    return data;
}
@end
