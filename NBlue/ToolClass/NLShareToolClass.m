//
//  NLShareToolClass.m
//  NBlue
//
//  Created by LYD on 16/3/15.
//  Copyright © 2016年 LYD. All rights reserved.
//



#import "NLShareToolClass.h"
#import <UMSocialWechatHandler.h>
#import <UMSocialDataService.h>
#import <UMSocialSnsPlatformManager.h>
#import <UMSocialAccountManager.h>
#import <WXApi.h>
#import <WeiboSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <UMSocialQQHandler.h>
static NLShareToolClass *_shareToolClass = nil;
@interface NLShareToolClass ()

@end
@implementation NLShareToolClass
+(NLShareToolClass *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareToolClass = [[NLShareToolClass alloc] init];
    });
    return _shareToolClass;
}
-(void)qqShareText:(NSString *)text title:(NSString *)title url:(NSString *)url viewController:(__weak UIViewController *)viewControllers{
    if ([TencentOAuth iphoneQQInstalled]) {
        [UMSocialData defaultData].extConfig.qqData.url = url;
        [UMSocialData defaultData].extConfig.qqData.title = title;
        [self sharePlatformArray:@[UMShareToQQ] shareCount:text icon:[UIImage imageNamed:@"User_Head"] viewController:viewControllers];
    }else{
        [kAPPDELEGATE AutoDisplayAlertView:@"提示：" :@"你还没有安装QQ哦~"];
    }
}
-(void)weiChatText:(NSString *)text title:(NSString *)title url:(NSString *)url viewController:(__weak UIViewController *)viewControllers{
    if ([WXApi isWXAppInstalled]) {
        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
        [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
        [self sharePlatformArray:@[UMShareToWechatSession] shareCount:text icon:[UIImage imageNamed:@"User_Head"] viewController:viewControllers];
    }else{
        [kAPPDELEGATE AutoDisplayAlertView:@"提示：" :@"你还没有安装微信哦~"];
    }
}
-(void)weiboText:(NSString *)text title:(NSString *)title url:(NSString *)url viewController:(__weak UIViewController *)viewControllers{
    if ([WeiboSDK isWeiboAppInstalled]) {
        [UMSocialData defaultData].extConfig.sinaData.urlResource.url = url;
        [UMSocialData defaultData].extConfig.sinaData.shareText = title;
        [self sharePlatformArray:@[UMShareToSina] shareCount:text icon:[UIImage imageNamed:@"User_Head"] viewController:viewControllers];
    }else{
        [kAPPDELEGATE AutoDisplayAlertView:@"提示：" :@"你还没有安装微博哦~"];
    }
}

-(void)WechatTimelineText:(NSString *)text title:(NSString *)title url:(NSString *)url viewController:(__weak UIViewController *)viewControllers{
    if ([WXApi isWXAppInstalled]) {
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
        [self sharePlatformArray:@[UMShareToWechatTimeline] shareCount:text icon:[UIImage imageNamed:@"User_Head"] viewController:viewControllers];
    }else{
        [kAPPDELEGATE AutoDisplayAlertView:@"提示：" :@"你还没有安装微信哦~"];
    }
}
- (void)sharePlatformArray:(NSArray *)platrormArray shareCount:(NSString *)shareCount icon:(UIImage *)icon viewController:(__weak UIViewController *)viewControllers{
    UMSocialUrlResource *urls = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:@"www.baidu.com"];
    [[UMSocialDataService defaultDataService] postSNSWithTypes:platrormArray content:shareCount image:icon location:nil urlResource:urls presentedController:viewControllers completion:^(UMSocialResponseEntity *response) {
        if (response.responseCode == UMSResponseCodeSuccess) {
            [kAPPDELEGATE AutoDisplayAlertView:@"提示：" :@"分享成功"];
        }
    }];
}
@end
