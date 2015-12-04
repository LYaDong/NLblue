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
-(void)getVerificationCodePhones:(NSNumber *)phone;
/**
 *注册手机号
 */
-(void)registeredCodephone:(NSNumber *)phone verification:(NSNumber *)verfication password:(NSNumber *)password;
/**
 *用户登录
 */
-(void)userSignInPhone:(NSNumber *)phone password:(NSNumber *)password;
@end
