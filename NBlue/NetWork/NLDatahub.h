//
//  NLDatahub.h
//  pinai
//
//  Created by LYD on 15/11/19.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLDatahub : NSObject
+(NLDatahub *)sharedInstance;
/**
 *获得验证码
 */
-(void)getVerificationCodePhones:(NSString *)phone;
/**
 *注册手机号
 */
-(void)registeredCodephone:(NSString *)phone verification:(NSString *)verfication password:(NSString *)password;
/**
 *用户登录
 */
-(void)userSignInPhone:(NSString *)phone password:(NSString *)password;
/**
 *获取用户运动数据
 */
-(void)userStepNumberToken:(NSString *)authToken
                consumerId:(NSString *)consumerId
                 startDate:(NSString *)startDate
                   endDate:(NSString *)endDate;
@end
