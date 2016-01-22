//
//  AppDelegate.m
//  NBlue
//
//  Created by LYD on 15/11/20.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "AppDelegate.h"
#import "NLHealthMangerViewController.h"
#import "NLHotMoxibustionViewController.h"
#import "NLProfileViewController.h"
#import "NLMyHerViewController.h"
#import "NLMaleProfileViewController.h"
#import "NLMaleHealthMangerViewController.h"
#import "MainNavgationControllew.h"
#import "NLLogInViewController.h"
#import "OLGhostAlertView.h"
//友盟
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"


@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize _loacluserinfo;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    
    _loacluserinfo = [[NLLocalUserInfo alloc] init];
    
    
    
    
    if (![[kAPPDELEGATE._loacluserinfo getControllew] isEqualToString:@"1"]) {
        [self tabBarViewControllerType:Controller_Loing];
    }else{
        if ([[kAPPDELEGATE._loacluserinfo getUserGender] isEqualToString:@"0"]) {
            [self tabBarViewControllerType:Controller_WoManMain];
        }else{
            [self tabBarViewControllerType:Controller_MaleMain];
        }
    }
    NSLog(@"%@",[_loacluserinfo GetUser_ID]);
    [MiPushSDK registerMiPush:self type:0 connect:YES];
    [MiPushSDK setAlias:[kAPPDELEGATE._loacluserinfo GetUser_ID]];
    
    
    NSDictionary *remoteNotifiInfo = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    
    //Accept push notification when app is not open
    if (remoteNotifiInfo) {
        [self application:application didReceiveRemoteNotification:remoteNotifiInfo];
    }
    
    
    
    [self setUMSocial];
    [self setMIPush];
    
    return YES;
}
-(void)tabBarViewControllerType:(Controller)type{
    
    
    switch (type) {
        case Controller_Loing:
        {
            NLLogInViewController *vc = [[NLLogInViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            self.window.rootViewController = nav;
            break;
        }
        case Controller_WoManMain:
        {
            NLHealthMangerViewController *healthVC = [[NLHealthMangerViewController alloc] init];
            NLHotMoxibustionViewController *hotVC = [[NLHotMoxibustionViewController alloc] init];
            NLProfileViewController *proVC = [[NLProfileViewController alloc] init];
            
            
            [self nlViewContrller:healthVC
                           middle:hotVC
                            right:proVC
                         titleArr:@[NSLocalizedString(@"TabBar_HealthManger", nil),
                                    NSLocalizedString(@"TabBar_HotMoxibustion", nil),
                                    NSLocalizedString(@"TabBar_Profile", nil)]
                  tabBarImageXArr:@[@"Health_Manger_X",
                                    @"Hot_Moxibus_X",
                                    @"Pro_File_X"]
                   tabBarImageArr:@[@"Health_Manger",
                                    @"Hot_Moxibus",
                                    @"Pro_File"]
                        backColor:[@"1d1b24" hexStringToColor]
                pitchOnTitleColor:[ApplicationStyle subjectPinkColor]
                defaultTitleColor:[UIColor whiteColor]];

            
            break;
        }
        case Controller_MaleMain:
        {
            
            NLMaleHealthMangerViewController *maleHealthManger = [[NLMaleHealthMangerViewController alloc] init];
            NLMyHerViewController *myHer = [[NLMyHerViewController alloc] init];
            NLMaleProfileViewController *maleProfile = [[NLMaleProfileViewController alloc] init];
            
            [self nlViewContrller:maleHealthManger
                           middle:myHer
                            right:maleProfile
                         titleArr:@[NSLocalizedString(@"TabBar_Male_HealthManger", nil),
                                    NSLocalizedString(@"TabBar_Male_HotMoxibustion", nil),
                                    NSLocalizedString(@"TabBar_Profile", nil)]
                  tabBarImageXArr:@[@"NL_Male_H_Manger_X",
                                    @"NL_Male_My_H_X",
                                    @"NL_Male_Profile_X"]
                   tabBarImageArr:@[@"NL_Male_H_Manger",
                                    @"NL_Male_My_H",
                                    @"NL_Male_Profile"]
                        backColor:[@"eef3f4" hexStringToColor]
                pitchOnTitleColor:[ApplicationStyle subjectMaleBlueColor]
                defaultTitleColor:[@"959595" hexStringToColor]];
            
            
            
            break;
        }
        default:
            break;
    }  
}



-(void)nlViewContrller:(__weak UIViewController *)liftController
                middle:(__weak UIViewController *)middleController
                 right:(__weak UIViewController *)rightController
              titleArr:(NSArray *)titleArr
       tabBarImageXArr:(NSArray *)tabBarImageXArr
        tabBarImageArr:(NSArray *)tabBarImageArr
             backColor:(UIColor *)backColor
     pitchOnTitleColor:(UIColor *)pitchOnTitleColor
     defaultTitleColor:(UIColor *)defaultTitleColor{
    
    NSMutableArray *controllewArr = [NSMutableArray arrayWithCapacity:0];
    NSArray *arrVC = [NSArray array];
    NSArray *arrTitle = [NSArray array];
    NSArray *arrTabBarImageX = [NSArray array];
    NSArray *arrTabBarImage = [NSArray array];
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    arrVC = @[liftController,middleController,rightController];
    arrTitle = titleArr;
    arrTabBarImageX = tabBarImageXArr;
    arrTabBarImage = tabBarImageArr;
    for (int i=0 ; i<arrVC.count; i++) {
        MainNavgationControllew *baseVc = [[MainNavgationControllew alloc] initWithRootViewController:arrVC[i]];
        UITabBarItem *tabBaritem = [[UITabBarItem alloc]init];
        [tabBaritem setTitle:arrTitle[i]];
        tabBaritem.image = [[UIImage imageNamed:arrTabBarImage[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBaritem.selectedImage = [[UIImage imageNamed:arrTabBarImageX[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        baseVc.title = arrTitle[i];
        ((UIViewController *)arrVC[i]).tabBarItem = tabBaritem;
        [controllewArr addObject:baseVc];
    }
    UIView *viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, tabBar.tabBar.frame.size.height)];
    viewBack.backgroundColor = backColor;
    [tabBar.tabBar insertSubview:viewBack atIndex:0];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : pitchOnTitleColor,NSFontAttributeName:[UIFont systemFontOfSize:10]}            forState:UIControlStateSelected];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : defaultTitleColor,NSFontAttributeName:[UIFont systemFontOfSize:10]}            forState:UIControlStateNormal];
    tabBar.viewControllers = controllewArr;
    tabBar.selectedIndex = 1;
    self.window.rootViewController = tabBar;
}

-(void)setUMSocial{
    //设置友盟Key
    [UMSocialData setAppKey:UM_APP_KEY];
    //设置微博
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:WB_APP_ID RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    //设置QQ
    [UMSocialQQHandler setQQWithAppId:QQ_APP_ID appKey:QQ_APP_EKY url:@"http://www.umeng.com/social"];
    //设置微信
    [UMSocialWechatHandler setWXAppId:WX_APP_ID appSecret:WX_APP_KEY url:@"http://www.umeng.com/social"];
    
}
-(void)setMIPush{
    
    
    
    
//    [MiPushSDK registerMiPush:self type:0 connect:YES];
//    NSString *messageId = [userInfo objectForKey:@"_id_"];
//    if (messageId!=nil) {
//        [MiPushSDK openAppNotify:messageId];
//    }
    
    
//    // 只启动APNs.
//    [MiPushSDK registerMiPush:self];
    // 同时启用APNs跟应用内长连接
//    [MiPushSDK registerMiPush:self type:0 connect:YES];
}



-(void)AutoDisplayAlertView:(NSString*) title :(NSString*)msg
{
    OLGhostAlertView *_ghostAlertView = [[OLGhostAlertView alloc] initWithTitle:title message:msg timeout:2.0 dismissible:YES];
    _ghostAlertView.position = OLGhostAlertViewPositionBottom;
    [_ghostAlertView show];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        
    }
    return result;
}

#pragma mark push 
#pragma mark UIApplicationDelegate
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    // 注册APNS成功, 注册deviceToken
    [MiPushSDK bindDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err{
    // 注册APNS失败
    // 自行处理
    NSLog(@"注册APNS失败:%@",err);
    
}

#pragma mark 接收远程消息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSString *messageId = [userInfo objectForKey:MI_APP_ID];
    [MiPushSDK openAppNotify:messageId];
 
    
    
    
}
#pragma mark 接收本地消息
- ( void )application:( UIApplication *)application didReceiveRemoteNotification:( NSDictionary *)userInfo{
    [ MiPushSDK handleReceiveRemoteNotification :userInfo];
    NSString *messageId = [userInfo objectForKey:MI_APP_ID];
    if (messageId!=nil) {
        [MiPushSDK openAppNotify:messageId];
    }
//    [MiPushSDK openAppNotify:messageId];
    // 使用此方法后，所有消息会进行去重，然后通过miPushReceiveNotification:回调返回给App
}



#pragma mark MiPushSDKDelegate

- (void)miPushRequestSuccWithSelector:(NSString *)selector data:(NSDictionary *)data{
    // 请求成功
    
    NSLog(@"小米推送 selector == %@ data ==  %@",selector,data);
    
}

- (void)miPushRequestErrWithSelector:(NSString *)selector error:(int)error data:(NSDictionary *)data{
    
    
    if (error == -101) {
        [MiPushSDK registerMiPush:self];
    }
    NSLog(@"请求失败：%d",error);
    NSLog(@"selector：%@",selector);
    NSLog(@"请求data：%@",data);
    
    // 请求失败
}

- ( void )miPushReceiveNotification:( NSDictionary *)data{
    NSLog(@"%@",data);
    
    // 长连接收到的消息。消息格式跟APNs格式一样
}





@end
