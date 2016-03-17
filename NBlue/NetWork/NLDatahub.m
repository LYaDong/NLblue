//
//  NLDatahub.m
//  pinai
//
//  Created by LYD on 15/11/19.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLDatahub.h"
#import "NLHTTPRequestFactory.h"
#import <AFHTTPSessionManager.h>
#import "SMProgressHUD.h"
static NLDatahub *datahub = nil;
static NSString *NLtextHeml = @"text/html";
static NSString *NLapplication = @"application/json";
static NSString *NLmobileApiBaseUrl = @"http://123.56.127.139/warman";//主接口
static NSString *NLUserApi = @"/user";//各个接口端
static NSString *NLSportApi = @"/sport";//各个接口端
static NSString *NLMenstruation = @"/menstruation";//各个接口端
static NSString *NLFolks = @"/folks";//各个接口端 User的子接口
static NSString *NLMessage = @"/message";//消息接口端
static const NSInteger errorStatusCode = 401;//报错：一般是登录过期


@interface NLDatahub(){
    dispatch_queue_t _networkSerialQueue;
    dispatch_queue_t _networkConcurrentQueue;
    NSOperationQueue *_networkOperationQueue;
}

@property(nonatomic,strong)AFHTTPSessionManager *manager;
@end

@implementation NLDatahub



+(NLDatahub *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        datahub = [[NLDatahub alloc] init];
    });
    return datahub;
}

-(instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)resetDispatchQueue
{
    if (_networkConcurrentQueue) {
        dispatch_suspend(_networkConcurrentQueue);
        _networkConcurrentQueue = nil;
    }
    
    if (_networkSerialQueue) {
        dispatch_suspend(_networkSerialQueue);
        _networkSerialQueue = nil;
    }
    
    _networkConcurrentQueue = dispatch_queue_create("com.NL.network.concurrent.dispatchQ", DISPATCH_QUEUE_CONCURRENT);
    _networkSerialQueue = dispatch_queue_create("com.NL.network.serial.dispatchQ", DISPATCH_QUEUE_SERIAL);
}

- (void)resetNetworkOperationQueue
{
    if (_networkOperationQueue) {
        [_networkOperationQueue cancelAllOperations];
        _networkOperationQueue = nil;
    }
    _networkOperationQueue = [[NSOperationQueue alloc]init];
    _networkOperationQueue.name = @"com.NL.network.operationQ";
    _networkOperationQueue.maxConcurrentOperationCount = 3;
}

#pragma mark 获取验证码
-(void)getVerificationCodePhones:(NSString *)phone{
    
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager GET:[NSString stringWithFormat:@"%@%@%@%@",NLmobileApiBaseUrl,NLUserApi,User_GetRegistercode,phone] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"expecting NSDictionary class");
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLGetVerficationSuccessNotification object:nil userInfo:nil];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLGetVerficationFicaledNotification object:nil userInfo:nil];
        });
    }];
}
#pragma mark 注册
-(void)registeredCodephone:(NSString *)phone verification:(NSString *)verfication password:(NSString *)password{
    
    NSDictionary * parameters= @{@"phone":phone,@"code":verfication,@"password":password,@"platform":@"ios"};
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager POST:[NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLUserApi,User_register] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLRegisteredViewControllewSuccessNotification object:[self dataTransformationJson:responseObject] userInfo:nil];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLRegisteredViewControllewFicaledNotification object:nil userInfo:nil];
        });
    }];
}
#pragma mark 忘记密码
- (void)forgetPassWordphone:(NSString *)phone verification:(NSString *)verfication password:(NSString *)password {
    
    NSDictionary * parameters= @{@"phone":phone,@"code":verfication,@"password":password,@"platform":@"ios"};
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager POST:[NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLUserApi,user_ForgetPassWord] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLUserForgetPassWordSuccessNotification object:[self dataTransformationJson:responseObject] userInfo:nil];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLUserForgetPassWordFicaledNotification object:nil userInfo:nil];
        });
    }];

}
#pragma mark 登录
-(void)userSignInPhone:(NSString *)phone password:(NSString *)password{
    [self loadingView];
    NSDictionary *parameters= @{@"phone":phone,@"code":@"",@"password":password,@"platform":@"ios"};
    
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:NLtextHeml,NLapplication, nil];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager POST:[NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLUserApi,User_Login] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissHide];
            [[NSNotificationCenter defaultCenter] postNotificationName:NLLogInSuccessNotification object:[self dataTransformationJson:responseObject] userInfo:nil];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissHide];
            NSLog(@"%@",error);
            [[NSNotificationCenter defaultCenter] postNotificationName:NLLogInFailedNotiFicaledtion object:nil userInfo:nil];
        });
    }];
}
#pragma mark  获取用户信息
-(void)getUserInformation{
    [self  loadingView];
    NSDictionary *parameters = @{@"consumerId":[kAPPDELEGATE._loacluserinfo GetUser_ID],@"authToken":[kAPPDELEGATE._loacluserinfo GetAccessToken]};
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager GET:[NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLUserApi,User_Consumer] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"expecting NSDictionary class");
        }
        NSLog(@"%@",[self dataTransformationJson:responseObject]);
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLUsergetUserInformationSuccessNotification object:[self dataTransformationJson:responseObject] userInfo:nil];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLUsergetUserInformationFicaledNotification object:nil userInfo:nil];
            [self urlResponseErrorCode:task.response];
        });
    }];
}

#pragma mark 添加睡眠信息
-(void)addSleepRecord:(NSNumber *)consumerId wareUUID:(NSNumber *)wareUUID sleepDate:(NSData *)sleepDate startTime:(NSString *)startTime duration:(NSString *)duratTime deepSleep:(NSString *)deepSleep shallowSleep:(NSString *)shallowSleep authToken:(NSNumber *)authToken{
//    NSDictionary *sleepDic = @{@"":@"",@"":@"",@"":@"",@"":@"",@"":@"",@"":@"",@"":@""};
    
}

#pragma mark 获得记步数据
-(void)userStepNumberToken:(NSString *)authToken
                consumerId:(NSString *)consumerId
                 startDate:(NSString *)startDate
                   endDate:(NSString *)endDate{
    NSDictionary *parameters = @{@"authToken":authToken,
                               @"consumerId":consumerId,
                               @"startDate":startDate,
                               @"endDate":endDate};
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:NLtextHeml,NLapplication, nil];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [_manager GET:[NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLSportApi,Sport_record] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"%@",[self dataTransformationJson:responseObject]);
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NLGetSoortRecordDataSuccessNotification object:[self dataTransformationJson:responseObject] userInfo:nil];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLGetSoortRecordDataFicaledNotification object:error userInfo:nil];
            [self urlResponseErrorCode:task.response];
        });
    }];
}

#pragma mark 上传个人信息
- (void)upDataUserInformationConsumerid:(NSString *)consumerid
                              authtoken:(NSString *)authtoken
                          userCountData:(NSMutableDictionary *)userCountData{
    
    [self loadingView];
    
    NSDictionary *parmeter = @{@"consumerId":consumerid,
                               @"authToken":authtoken,
                               @"name":[userCountData objectForKey:@"userName"]==nil?@"":[userCountData objectForKey:@"userName"],
                               @"age":[userCountData objectForKey:@"age"]==nil?@"":[userCountData objectForKey:@"age"],
                               @"height":[userCountData objectForKey:@"height"]==nil?@"":[userCountData objectForKey:@"height"],
                               @"weight":[userCountData objectForKey:@"width"]==nil?@"":[userCountData objectForKey:@"width"],
                               @"gender":[userCountData objectForKey:@"gender"]==nil?@"":[userCountData objectForKey:@"gender"],
                          };
    
    NSLog(@"%@",parmeter);
    
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:NLtextHeml,NLapplication, nil];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [_manager PUT:[NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLUserApi,User_Consumer] parameters:parmeter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self dismissHide];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NLUpDateUserInformationSuccessNotification object:[self dataTransformationJson:responseObject] userInfo:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self urlResponseErrorCode:task.response];
        
        
        [self dismissHide];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NLUpDateUserInformationFicaledNotification object:error userInfo:nil];
    }];
}
#pragma mark 扫二维码
- (void)qrCodeNextWorkFrom_to_id:(NSString *)from_to_id{
    
    NSDictionary *parameters =@{@"consumerId":[kAPPDELEGATE._loacluserinfo GetUser_ID],@"folkConsumerId":from_to_id,@"authToken":[kAPPDELEGATE._loacluserinfo GetAccessToken]};

    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:NLtextHeml,NLapplication, nil];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager POST:[NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLUserApi,User_QRCode] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLMaleBindingSuccessNotification object:[self dataTransformationJson:responseObject] userInfo:nil];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLMaleBindingFicaledNotification object:error userInfo:nil];
            [self urlResponseErrorCode:task.response];
        });
    }];
}

#pragma mark 获取经期和周期
-(void)getUserCycleOrperiod{
    [self  loadingView];
    NSDictionary *parameters =@{@"consumerId":[kAPPDELEGATE._loacluserinfo GetUser_ID],@"authToken":[kAPPDELEGATE._loacluserinfo GetAccessToken]};
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager GET:[NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLMenstruation,User_MenstruationRecord] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissHide];
            [[NSNotificationCenter defaultCenter] postNotificationName:NLGetCycleOrPeriodSuccessNotification object:[self dataTransformationJson:responseObject] userInfo:nil];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissHide];
            NSLog(@"%@",error);
            [[NSNotificationCenter defaultCenter] postNotificationName:NLGetCycleOrPeriodFicaledNotification object:nil userInfo:nil];
            [self urlResponseErrorCode:task.response];
        });
    }];
}

#pragma mark 提醒他
-(void)remindMale{
    
}
#pragma mark 上传用户头像
-(void)uploadUserImage:(UIImage *)image imageType:(NSString *)imageType{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CGSize newImageSize =  [ApplicationStyle compressImageSize:image];
        UIImage *newImage = [ApplicationStyle compressFinishIsImages:image scaledToSize:newImageSize];
        NSData *imgData = UIImagePNGRepresentation(newImage);
        NSDictionary * parameters = @{@"consumerId":[kAPPDELEGATE._loacluserinfo  GetUser_ID],@"authToken":[kAPPDELEGATE._loacluserinfo GetAccessToken]};
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:NLtextHeml,NLapplication, nil];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [_manager POST:[NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLUserApi,@"/header"] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            //        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"sdfsdf.png" withExtension:nil];
            //        [formData appendPartWithFileURL:[NSURL URLWithString:image] name:@"file" fileName:@"sdfsdf.png" mimeType:@"image/png" error:NULL];
//            NSString *files = [NSString stringWithFormat:@"%0.0f",[[NSDate date] timeIntervalSince1970]];
            [formData appendPartWithFileData:imgData name:@"file" fileName:@"test.png" mimeType:@"image/png"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:NLUserUploadUserImageSuccessNotification object:result userInfo:nil];
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:NLUserUploadUserImageFicaledNotification object:error userInfo:nil];
                [self urlResponseErrorCode:task.response];
            });
        }];
    });
}
//上传经期和周期
-(void)upDataCycleOrPeriod:(NSDictionary *)dic{
    

    [self loadingView];
    
    
    NSLog(@"%@ %@ %@ %@ %@",[kAPPDELEGATE._loacluserinfo GetUser_ID],[kAPPDELEGATE._loacluserinfo getLastTimeGoPeriodDate],[dic objectForKey:@"periodTime"],[dic objectForKey:@"cycleTime"],[kAPPDELEGATE._loacluserinfo GetAccessToken]);
    
    
    NSDictionary *paramenters = @{@"consumerId":[kAPPDELEGATE._loacluserinfo GetUser_ID],
                                  @"startDate":[kAPPDELEGATE._loacluserinfo getLastTimeGoPeriodDate]==nil?@"":[kAPPDELEGATE._loacluserinfo getLastTimeGoPeriodDate],
                                  @"duration":[dic objectForKey:@"periodTime"],
                                  @"cycle":[dic objectForKey:@"cycleTime"],
                                  @"authToken":[kAPPDELEGATE._loacluserinfo GetAccessToken]};
    
    
    
    
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:NLtextHeml,NLapplication, nil];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager POST:[NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLMenstruation,User_MenstruationRecord] parameters:paramenters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissHide];
            [[NSNotificationCenter defaultCenter] postNotificationName:NLUpCycleOrPeriodSuccessNotification object:[self dataTransformationJson:responseObject] userInfo:nil];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissHide];
            [[NSNotificationCenter defaultCenter] postNotificationName:NLUpCycleOrPeriodFicaledNotification object:nil userInfo:nil];
            [self urlResponseErrorCode:task.response];
        });
    }];
    
    
}

//更新经期信息
-(void)upDateMenstruationData:(NSDictionary *)menstruationData{
    
    NSDictionary *parameters = @{@"consumerId":[kAPPDELEGATE._loacluserinfo GetUser_ID],
                          @"startDate":@"",
                          @"duration":@"",
                          @"authToken":[kAPPDELEGATE._loacluserinfo GetAccessToken]};
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLMenstruation,User_MenstruationRecord]);
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:NLtextHeml,NLapplication, nil];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager PUT:[NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLMenstruation,User_MenstruationRecord] parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self urlResponseErrorCode:task.response];
    }];
    
}
#pragma mark 第三方登录
-(void)thirdLogin:(NSDictionary *)dic{
    [self loadingView];
    NSDictionary *paramenters = @{@"openId":[dic objectForKey:@"openId"],
                                  @"type":[dic objectForKey:@"type"],
                                  @"platform":[dic objectForKey:@"platform"]};
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:NLtextHeml,NLapplication, nil];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager POST:[NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLUserApi,User_ThirdLogin] parameters:paramenters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissHide];
            NSLog(@"%@",[self dataTransformationJson:responseObject]);
            [[NSNotificationCenter defaultCenter] postNotificationName:NLThirdLoginSuccessNotification object:[self dataTransformationJson:responseObject] userInfo:nil];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissHide];
            [[NSNotificationCenter defaultCenter] postNotificationName:NLThirdLoginFicaledNotification object:nil userInfo:nil];
            
        });
    }];
}
//判断是否有男友
-(void)maleJudgeIsHave{
    NSDictionary *parameters = @{@"consumerId":[kAPPDELEGATE._loacluserinfo GetUser_ID],
                                 @"authToken":[kAPPDELEGATE._loacluserinfo GetAccessToken]};

    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager GET:[NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLUserApi,NLFolks] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLFolkSuccessNotification object:[self dataTransformationJson:responseObject] userInfo:nil];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLFolkFicaledNotification object:nil userInfo:nil];
            [self urlResponseErrorCode:task.response];
        });
    }];
}
#pragma mark 获取我的消息
-(void)getMyMessages{
    [self loadingView];
    NSDictionary *parameters = @{@"consumerId":[kAPPDELEGATE._loacluserinfo GetUser_ID],
                                 @"authToken":[kAPPDELEGATE._loacluserinfo GetAccessToken]};
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:NLtextHeml,NLapplication, nil];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@%@",NLmobileApiBaseUrl,NLMessage];
    [_manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissHide];
            [[NSNotificationCenter defaultCenter] postNotificationName:NLGetMyMessageSuccessNotification object:[self dataTransformationJson:responseObject]];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissHide];
            [[NSNotificationCenter defaultCenter] postNotificationName:NLGetMyMessageFicaledNotification object:error];
            [self urlResponseErrorCode:task.response];
        });
    }];
    
   
}
//根据消息ID获得消息
-(void)getMyMessagesID:(NSString *)messageID{
    NSDictionary *parameters = @{@"consumerId":[kAPPDELEGATE._loacluserinfo GetUser_ID],
                                 @"authToken":[kAPPDELEGATE._loacluserinfo GetAccessToken]};
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:NLtextHeml,NLapplication, nil];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLMessage,messageID];
    [_manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       dispatch_async(dispatch_get_main_queue(), ^{
           NSLog(@"%@",[self dataTransformationJson:responseObject]);
       });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
             [self urlResponseErrorCode:task.response];
        });
    }];
}
//提醒他的消息接口
-(void)remindMessage:(NSString *)message type:(NSString *)type{
    NSDictionary *parameters = @{@"consumerId":[kAPPDELEGATE._loacluserinfo GetUser_ID],
                                 @"authToken":[kAPPDELEGATE._loacluserinfo GetAccessToken],
                                 @"to":@"2ed1b589-a47d-4663-9884-d9f650aa3d6e",//后期填绑定之后的ID
                                 @"message":message,
                                 @"type":type};
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:NLapplication,NLtextHeml, nil];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = API_BASE_URL(NLMessage);
    [_manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLRemindMessageSuccessNotification object:[self dataTransformationJson:responseObject]];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
             [[NSNotificationCenter defaultCenter] postNotificationName:NLRemindMessageFicaledNotification object:error];
            [self urlResponseErrorCode:task.response];
        });
       

    }];
}

-(void)calendarUpLoadDataDic:(NSDictionary *)dataDic{
    
    
    
    
    NSDictionary *parameters = @{@"consumerId":[kAPPDELEGATE._loacluserinfo GetUser_ID],
                                 @"authToken":[kAPPDELEGATE._loacluserinfo GetAccessToken],
                                 @"currentDate":[dataDic objectForKey:@"currentDate"]==nil?@"":[dataDic objectForKey:@"currentDate"],
                                 @"isMenstruation":@"",
                                 @"dysmenorrhea":[dataDic objectForKey:@"dysmenorrhea"]==nil?@"":[dataDic objectForKey:@"dysmenorrhea"],
                                 @"haveSex":[dataDic objectForKey:@"haveSex"]==nil?@"":[dataDic objectForKey:@"haveSex"],
                                 @"lifeHabit":[dataDic objectForKey:@"lifeHabit"]==nil?@"":[dataDic objectForKey:@"lifeHabit"],
                                 @"uncomfortable":[dataDic objectForKey:@"uncomfortable"]==nil?@"":[dataDic objectForKey:@"uncomfortable"]};
    
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:NLapplication,NLtextHeml, nil];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *api = [NSString stringWithFormat:@"%@%@",NLMenstruation,Menstruation_Calender];
    NSString *url = API_BASE_URL(api);
    [_manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"上传成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self urlResponseErrorCode:task.response];
    }];
}
//获得日历数据
-(void)getCalendar:(NSDictionary *)dic{
    
    NSDictionary *parameters = @{@"consumerId":[kAPPDELEGATE._loacluserinfo GetUser_ID],
                                 @"authToken":[kAPPDELEGATE._loacluserinfo GetAccessToken],
                                 @"startDate":[dic objectForKey:@"startDate"],
                                 @"endDate":[dic objectForKey:@"endDate"]};
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:NLapplication,NLtextHeml, nil];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *api = [NSString stringWithFormat:@"%@%@",NLMenstruation,Menstruation_Calender];
    NSString *url = API_BASE_URL(api);
    [_manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NLGetCalendarSuccessNotification object:[self dataTransformationJson:responseObject]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLGetCalendarFicaledNotification object:error];
            [self urlResponseErrorCode:task.response];
        });
    }];
}
//反馈接口
-(void)setFeedback:(NSString *)count{
    NSDictionary *parameters = @{@"consumerId":[kAPPDELEGATE._loacluserinfo GetUser_ID],
                                 @"authToken":[kAPPDELEGATE._loacluserinfo GetAccessToken],
                                 @"message":count};
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:NLapplication,NLtextHeml, nil];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *api = [NSString stringWithFormat:@"%@%@",NLUserApi,User_Feedback];
    NSString *url = API_BASE_URL(api);
    [_manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       dispatch_async(dispatch_get_main_queue(), ^{
           [[NSNotificationCenter defaultCenter] postNotificationName:NLSetFeedbackSuccessNotification object:nil];
       });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self urlResponseErrorCode:task.response];
        });
    }];
}

#pragma mark 转JSON数据
- (NSDictionary *)dataTransformationJson:(id  _Nullable)responseObject{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                        options:NSJSONReadingMutableLeaves
                                                          error:nil];
    return dic;
}
#pragma mark 处理报错401 直接跳到登录页
- (void)urlResponseErrorCode:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSInteger responseStatusCode = [httpResponse statusCode];
    if (responseStatusCode == errorStatusCode) {
        [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"登录过期"];
        [kAPPDELEGATE tabBarViewControllerType:Controller_Loing];
    }
}


#pragma mark loading提示框
-(void)loadingView{
    [[SMProgressHUD shareInstancetype] showLoading];
}

-(void)loadingViewString:(NSString *)string{
    [[SMProgressHUD shareInstancetype] showLoadingWithTip:string];
}

-(void)dismissHide{
    [[SMProgressHUD shareInstancetype] dismiss];
}

@end
