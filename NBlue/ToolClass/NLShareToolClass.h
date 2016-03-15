//
//  NLShareToolClass.h
//  NBlue
//
//  Created by LYD on 16/3/15.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLShareToolClass : NSObject
+(NLShareToolClass *)sharedInstance;
/**
 * QQ分享
 */
-(void)qqShareText:(NSString *)text title:(NSString *)title url:(NSString *)url viewController:(__weak UIViewController *)viewControllers;
/**
 * 微信好友分享
 */
-(void)weiChatText:(NSString *)text title:(NSString *)title url:(NSString *)url viewController:(__weak UIViewController *)viewControllers;
/**
 * 微博分享
 */
-(void)weiboText:(NSString *)text title:(NSString *)title url:(NSString *)url viewController:(__weak UIViewController *)viewControllers;
/**
 * 微信朋友圈分享
 */
-(void)WechatTimelineText:(NSString *)text title:(NSString *)title url:(NSString *)url viewController:(__weak UIViewController *)viewControllers;

@end
