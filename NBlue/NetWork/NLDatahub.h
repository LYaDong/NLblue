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
 * 获得用户信息
 */
-(void)getUserInformation;
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
                              authtoken:(NSString *)authtoken
                          userCountData:(NSMutableDictionary *)userCountData;
/**
 *二维码扫描
 */
- (void)qrCodeNextWorkFrom_to_id:(NSString *)from_to_id;
/**
 * 上传用户头像
 */
-(void)uploadUserImage:(UIImage *)image imageType:(NSString *)imageType;
/**
 * 更新经期信息
 */
-(void)upDateMenstruationData:(NSDictionary *)menstruationData;
/**
 * 查询是否拥有男友
 */
-(void)maleJudgeIsHave;
/**
 * 获得周期和经期
 */
-(void)getUserCycleOrperiod;
/**
 * 上传用户经期，周期，开始时间
 */
-(void)upDataCycleOrPeriod:(NSDictionary *)dic;
/**
 * 第三方登录
 */
-(void)thirdLogin:(NSDictionary *)dic;
/**
 * 获取我的消息
 */
-(void)getMyMessages;
/**
 * 提醒他 
 * message:你需要提醒的内容 type:页面的Type
 */
-(void)remindMessage:(NSString *)message type:(NSString *)type;
/**
 *  日历上传接口
 */
-(void)calendarUpLoadDataDic:(NSDictionary *)dataDic;
/**
 * 获得日历数据
 */
-(void)getCalendar:(NSDictionary *)dic;
/**
 * 反馈接口
 */
-(void)setFeedback:(NSString *)count;
/**
 * 权限接口
 */
-(void)permissionStr:(NSMutableDictionary *)dic;
/**
 * 获得男友权限
 */
-(void)getMalePermission:(NSString *)maleID;
@end
