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
 *忘记密码
 */
- (void)forgetPassWordphone:(NSString *)phone verification:(NSString *)verfication password:(NSString *)password;
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
/**
 *上传用户信息
 */
- (void)upDataUserInformationConsumerid:(NSString *)consumerid
                                   name:(NSString *)name
                               nickname:(NSString *)nickname
                                 gender:(NSString *)gender
                                    age:(NSString *)age
                                 height:(NSString *)height
                                 weight:(NSString *)weight
                                 header:(NSString *)header
                               stepGoal:(NSString *)stepGoal;
/**
 *二维码扫描
 */
- (void)qrCodeNextWorkFrom_to_id:(NSString *)from_to_id;

-(void)uploadUserImage:(UIImage *)image imageType:(NSString *)imageType;

@end
