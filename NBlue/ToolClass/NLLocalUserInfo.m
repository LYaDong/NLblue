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
@end
