//
//  NLDatahub.m
//  pinai
//
//  Created by LYD on 15/11/19.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLDatahub.h"
#import "NLHTTPRequestFactory.h"
#import "NLHTTPRequestOperations.h"
#import "AFHTTPRequestOperationManager.h"
#import "SMProgressHUD.h"
static NLDatahub *datahub = nil;
static NSString *NLtextHeml = @"text/html";
static NSString *NLapplication = @"application/json";
static NSString *NLmobileApiBaseUrl = @"http://123.56.127.139/warman";//主接口
static NSString *NLUserApi = @"/user";//各个接口端
static NSString *NLSportApi = @"/sport";//各个接口端


@interface NLDatahub(){
    dispatch_queue_t _networkSerialQueue;
    dispatch_queue_t _networkConcurrentQueue;
    NSOperationQueue *_networkOperationQueue;
}
@property(nonatomic,strong)AFHTTPRequestOperationManager *manger;

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
    NSURLRequest *request = [NLHTTPRequestFactory getVerificationCodePhone:phone];
    NLHTTPRequestOperations *operation = [[NLHTTPRequestOperations alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    //    operation.completionQueue = _networkConcurrentQueue;
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"expecting NSDictionary class");
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLGetVerficationSuccessNotification object:nil userInfo:nil];
        });
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLGetVerficationFicaledNotification object:nil userInfo:nil];
        });
    }];
    //    [_networkOperationQueue addOperation:operation];
    [operation start];
}
#pragma mark 注册
-(void)registeredCodephone:(NSString *)phone verification:(NSString *)verfication password:(NSString *)password{
    
    NSLog(@"%@ %@ %@",phone,verfication,password);
    
    _manger = [[AFHTTPRequestOperationManager alloc]init];
    NSDictionary * parameters= @{@"phone":phone,@"code":verfication,@"password":password,@"platform":@"ios"};
    _manger.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:NLtextHeml,NLapplication, nil];
    [_manger POST:[NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLUserApi,User_register] parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLRegisteredViewControllewSuccessNotification object:responseObject userInfo:nil];
        });
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLRegisteredViewControllewFicaledNotification object:operation.responseObject userInfo:nil];
        });
    }];
}
#pragma mark 登录
-(void)userSignInPhone:(NSString *)phone password:(NSString *)password{
    [self loadingView];
    NSDictionary *parameters= @{@"phone":phone,@"code":@"",@"password":password,@"platform":@"ios"};
    _manger = [[AFHTTPRequestOperationManager alloc]init];
    _manger.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:NLtextHeml,NLapplication, nil];
    [_manger POST:[NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLUserApi,User_Login] parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissHide];
            [[NSNotificationCenter defaultCenter] postNotificationName:NLLogInSuccessNotification object:responseObject userInfo:nil];
        });
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissHide];
            NSLog(@"%@",error);
            [[NSNotificationCenter defaultCenter] postNotificationName:NLLogInFailedNotiFicaledtion object:nil userInfo:nil];
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
    NSDictionary *parmeter = @{@"authToken":authToken,
                               @"consumerId":consumerId,
                               @"startDate":startDate,
                               @"endDate":endDate};
    AFHTTPRequestOperationManager *manger = [[AFHTTPRequestOperationManager alloc]init];
    manger.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:NLtextHeml,NLapplication, nil];
    [manger GET:[NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLSportApi,Sport_record] parameters:parmeter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLGetSoortRecordDataSuccessNotification object:responseObject userInfo:nil];
        });
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLGetSoortRecordDataFicaledNotification object:error userInfo:nil];
        });
    }];
}

#pragma mark 上传个人信息
- (void)upDataUserInformationConsumerid:(NSString *)consumerid
                                   name:(NSString *)name
                               nickname:(NSString *)nickname
                                 gender:(NSString *)gender
                                    age:(NSString *)age
                                 height:(NSString *)height
                                 weight:(NSString *)weight
                                 header:(NSString *)header
                               stepGoal:(NSString *)stepGoal{
    
    NSDictionary *parmeter = @{@"consumerid":consumerid,
                          @"name":name,
                          @"nickname":nickname,
                          @"gender":gender,
                          @"age":age,
                          @"height":height,
                          @"weight":weight,
                          @"header":header,
                          @"stepGoal":stepGoal,};
    AFHTTPRequestOperationManager *manger = [[AFHTTPRequestOperationManager alloc] init];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:NLtextHeml,NLapplication, nil];
//    [manger POST:[NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLUserApi,User_Consumer] parameters:parmeter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [[NSNotificationCenter defaultCenter] postNotificationName:NLUserConsumerDataSuccessNotification object:responseObject userInfo:nil];
//        });
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [[NSNotificationCenter defaultCenter] postNotificationName:NLUserConsumerDataFicaledNotification object:error userInfo:nil];
//        });
//    }];
    
    
    
    [manger PUT:[NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLUserApi,User_Consumer] parameters:parmeter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLUserConsumerDataSuccessNotification object:responseObject userInfo:nil];
        });
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:NLUserConsumerDataFicaledNotification object:error userInfo:nil];
        });

    }];
}
#pragma mark 扫二维码
- (void)qrCodeNextWorkFrom_to_id:(NSString *)from_to_id{
    NSDictionary *parmeter =@{@"consumerId":[kAPPDELEGATE._loacluserinfo GetUser_ID],@"folkConsumerId":from_to_id,@"authToken":[kAPPDELEGATE._loacluserinfo GetAccessToken]};
    AFHTTPRequestOperationManager *manger = [[AFHTTPRequestOperationManager alloc] init];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:NLtextHeml,NLapplication,nil];
    
    [manger POST:[NSString stringWithFormat:@"%@%@%@",NLmobileApiBaseUrl,NLUserApi,User_QRCode] parameters:parmeter success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"%ld",(long)operation.response.statusCode);
        
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@  error = %@",operation.responseObject,error);
    }];
}
#pragma mark 提醒他
-(void)remindMale{
    
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
