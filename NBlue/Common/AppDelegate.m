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
    
//    NSLog(@"%@",[kAPPDELEGATE._loacluserinfo getControllew]);
//    [kAPPDELEGATE._loacluserinfo goControllew:@"1"];
//    [kAPPDELEGATE._loacluserinfo SetUser_ID:@"88830130-15c5-4fa9-92c2-b6960f11edc1"];
//    [kAPPDELEGATE._loacluserinfo SetUserAccessToken:@"123123123123"];
    
    if (![[kAPPDELEGATE._loacluserinfo getControllew] isEqualToString:@"1"]) {
        [self tabBarViewControllerType:Controller_Loing];
    }else{
        [self tabBarViewControllerType:Controller_Main];
    }
    
    [self setUMSocial];
    
    
    
//    if ([application applicationState] == UIApplicationStateBackground) {
//        NSLog(@"是自启动");
//    }else{
//        NSLog(@"不是");
//    }
    
    
    return YES;
}
-(void)tabBarViewControllerType:(Controller)type{
    
    
    if (type == Controller_Loing) {
        NLLogInViewController *vc = [[NLLogInViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = nav;
    }else{
        UIColor *titleWhite = [UIColor whiteColor];
        NSMutableArray *controllewArr = [NSMutableArray arrayWithCapacity:0];
        NSArray *arrVC = [NSArray array];
        NSArray *arrTitle = [NSArray array];
        NSArray *arrTabBarImageX = [NSArray array];
        NSArray *arrTabBarImage = [NSArray array];
        UITabBarController *tabBar = [[UITabBarController alloc] init];
        NLHealthMangerViewController *healthVC = [[NLHealthMangerViewController alloc] init];
        NLHotMoxibustionViewController *hotVC = [[NLHotMoxibustionViewController alloc] init];
        NLProfileViewController *proVC = [[NLProfileViewController alloc] init];
        arrVC = @[healthVC,hotVC,proVC];
        arrTitle = @[NSLocalizedString(@"TabBar_HealthManger", nil),NSLocalizedString(@"TabBar_HotMoxibustion", nil),NSLocalizedString(@"TabBar_Profile", nil)];
        arrTabBarImageX = @[@"Health_Manger_X",@"Hot_Moxibus_X",@"Pro_File_X"];
        arrTabBarImage = @[@"Health_Manger",@"Hot_Moxibus",@"Pro_File"];
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
        viewBack.backgroundColor = [@"1d1b24" hexStringToColor];
        [tabBar.tabBar insertSubview:viewBack atIndex:0];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [ApplicationStyle subjectPinkColor],NSFontAttributeName:[UIFont systemFontOfSize:10]}            forState:UIControlStateSelected];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : titleWhite,NSFontAttributeName:[UIFont systemFontOfSize:10]}            forState:UIControlStateNormal];
        tabBar.viewControllers = controllewArr;
        tabBar.selectedIndex = 1;
        self.window.rootViewController = tabBar;
    }
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






@end
