//
//  NLHTTPRequestFactory.h
//  pinai
//
//  Created by LYD on 15/11/19.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLHTTPRequestFactory : NSObject
enum
{
    NLHTTPRequestMethodGet = 0,
    NLHTTPRequestMethodPost = 1,
    NLHTTPRequestMethodPut = 2,
    NLHTTPRequestMethodDelete = 3,
    NLHTTPRequestMethodTypeSkip
};
typedef NSInteger NLHTTPRequestMethodType;

+ (NSMutableURLRequest *)createRequestWithURL:(NSURL *)url body:(NSDictionary *)body method:(NLHTTPRequestMethodType)method authHeader:(BOOL)insertAuthHeader;
#pragma mark 获取验证码
+(NSURLRequest *)getVerificationCodePhone:(NSString *)phone;

@end
