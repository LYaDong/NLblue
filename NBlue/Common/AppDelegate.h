//
//  AppDelegate.h
//  NBlue
//
//  Created by LYD on 15/11/20.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLLocalUserInfo.h"
#import "MiPushSDK.h"
typedef NS_ENUM(NSUInteger,Controller) {
    Controller_Loing = 0,                                   //登录页面
    Controller_WoManMain = 1,                                    //女主页
    Controller_MaleMain = 2,                                    //男主页
};
@interface AppDelegate : UIResponder <UIApplicationDelegate,MiPushSDKDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NLLocalUserInfo *_loacluserinfo;
-(void)tabBarViewControllerType:(Controller)type;
-(void)AutoDisplayAlertView:(NSString*) title :(NSString*)msg;
@end

