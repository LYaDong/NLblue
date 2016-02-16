//
//  NLHTTPRequestFactory.m
//  pinai
//
//  Created by LYD on 15/11/19.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLHTTPRequestFactory.h"

@implementation NLHTTPRequestFactory
static int TIME_OUT = 30; // 延时30秒
static NSString *NLmobileApiBaseUrl = @"http://123.56.127.139/warman";//主接口
static NSString *NLUserApi = @"/user";//各个接口端
static NSString *NLSportApi = @"/sport";//各个接口端


+ (NSMutableURLRequest *)createRequestWithURL:(NSURL *)url body:(NSDictionary *)body method:(NLHTTPRequestMethodType)method authHeader:(BOOL)insertAuthHeader
{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[url absoluteString]] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:TIME_OUT];
    switch (method) {
        case NLHTTPRequestMethodTypeSkip:
            break;
        default:
        case NLHTTPRequestMethodGet:
            [request setHTTPMethod:@"GET"];
            break;
        case NLHTTPRequestMethodPost:
            [request setHTTPMethod:@"POST"];
            break;
        case NLHTTPRequestMethodPut:
            [request setHTTPMethod:@"PUT"];
            break;
        case NLHTTPRequestMethodDelete:
            [request setHTTPMethod:@"DELETE"];
            break;
    }

//    NSString *myBoundary=@"0xKhTmLbOuNdArY";//这个很重要，用于区别输入的域
//    NSString *myContent=[NSString stringWithFormat:@"multipart/form-data;boundary=%@",myBoundary];//意思是要提交的是表单数据
//    
//    
//    
//    
//    [request setValue:myContent forHTTPHeaderField:@"Content-Type"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Accept"];
//
//    if (insertAuthHeader) {
//        NSString *accessToken = nil;
////        if (![kAPPDELEGATE._loacluserinfo GetAccessToken]) {
////
////        }else{
////
////        }
//        [request setValue:accessToken forHTTPHeaderField:@"Access-Token"];
//    }
    
    
//    NSString *jsonString = nil;
//    if (body) {
//        NSData *data = nil;
//        NSError *error = nil;
//        @try {
//            data = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
//        }
//        @catch (NSException *exception) {
//            NSLog(@"Caught %@ while create JSON data (%@)", [exception name], [exception reason]);
//        }
//        
//        if (data) {
//            jsonString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        } else {
//            NSLog(@"JSON data is empty");
//        }
//        
//        [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
//    }
//    NSLog(@"Request:%@\nHeader:%@\nBody:%@",request, [request allHTTPHeaderFields], jsonString);
    
    

//    NSMutableString *bodyContent = [NSMutableString stringWithCapacity:0];
//    if (body) {
//        
//        for(NSString *key in body.allKeys){
//            id value = [body objectForKey:key];
//            [bodyContent appendFormat:@"--%@rn",myBoundary];
//            [bodyContent appendFormat:@"Content-Disposition: form-data; name='%@'rnrn",key];
//            [bodyContent appendFormat:@"%@",value];
//        }
//        [bodyContent appendFormat:@"--%@rn",myBoundary];
//        NSData *bodyData=[bodyContent dataUsingEncoding:NSUTF8StringEncoding];
//        [request setHTTPBody:bodyData];
//    }
//    
//    
//    NSLog(@"Request:%@\nHeader:%@\nBody:%@",request, [request allHTTPHeaderFields], bodyContent);
    
    
    

    
    
    
    
//    NSMutableString *bodyContent = [NSMutableString stringWithCapacity:0];
//    if (body) {
//        for (NSString *key in body.allKeys) {
//            id value = [body objectForKey:key];
//            [bodyContent appendFormat:@"\n--%@\n",myBoundary];
//            [bodyContent appendFormat:@"Content-Disposition:form-data;name='%@'\n\n",key];
//            [bodyContent appendFormat:@"%@",value];
//        }
//        [bodyContent appendFormat:@"\n--%@\n",myBoundary];
//        NSData *data = [bodyContent dataUsingEncoding:NSUTF8StringEncoding];
//        [request setHTTPBody:data];
//        
//    }
    
    
//    NSLog(@"Request:%@\nHeader:%@\nBody:%@",request, [request allHTTPHeaderFields], bodyContent);
    
    
//    NSMutableData *bodys = [NSMutableData data];
//    if (body) {
//        for (NSString *key in body.allKeys) {
//            id value = [body objectForKey:key];
//            [bodys appendData:[[NSString stringWithFormat:@"\n--%@\n",myBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
//            [bodys appendData:[[NSString stringWithFormat:@"Content-Disposition:form-data;name='%@'\n\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
//            [bodys appendData:[[NSString stringWithFormat:@"%@",value] dataUsingEncoding:NSUTF8StringEncoding]];
//        }
//        [bodys appendData:[[NSString stringWithFormat:@"\n--%@\n",myBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        [request setHTTPBody:bodys];
    
//    }
//
//    NSLog(@"Request:%@\nHeader:%@",request, [request allHTTPHeaderFields]);
    
    
//    NSMutableData *bodyString = [NSMutableData data];
//    
//    for (NSString *key in body.allKeys) {
//        
//        NSString *key = key;
//        NSString *value = [body allValues][i];
//        if ([key isEqualToString:@"accessToken"]) {
//            value = [value substringToIndex:32];
//        }
//        
//        [bodyString appendFormat:@"-----------------------------%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n",boundary,key,value];
//    }
//    
//    [bodyString appendFormat:@"-----------------------------%@--\r\n", boundary];
    
    
    
    
    
//    NSURL *url = [NSURL URLWithString:@"http://192.168.1.112:8080/TestSerlvet/interfaces"];
//    NSMutableString *bodyContent = [NSMutableString string];
//    for(NSString *key in body.allKeys){
//        id value = [body objectForKey:key];
//        [bodyContent appendFormat:@"\n--%@\n",@"LYD"];
//        [bodyContent appendFormat:@"Content-Disposition:form-data;name='%@'\n\n",key];
//        [bodyContent appendFormat:@"%@\n",value];
//    }
//    [bodyContent appendFormat:@"\n--%@\n",@"LYD"];
//    NSData *bodyData=[bodyContent dataUsingEncoding:NSUTF8StringEncoding];
//
//    [request addValue:[NSString stringWithFormat:@"multipart/form-data;boundary=%@",@"LYD"] forHTTPHeaderField:@"Content-Type"];
//    [request addValue: [NSString stringWithFormat:@"%zd",bodyData.length] forHTTPHeaderField:@"Content-Length"];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:bodyData];
//    NSLog(@"请求的长度%@",[NSString stringWithFormat:@"%zd",bodyData.length]);
//    __autoreleasing NSError *error=nil;
//    __autoreleasing NSURLResponse *response=nil;
//    NSLog(@"输出Bdoy中的内容>>n%@",[[NSString alloc]initWithData:bodyData encoding:NSUTF8StringEncoding]);
//    NSData *reciveData= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    if(error){
//        NSLog(@"出现异常%@",error);
//    }else{
//        NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
//        if(httpResponse.statusCode==200){
//            NSLog(@"服务器成功响应!>>%@",[[NSString alloc]initWithData:reciveData encoding:NSUTF8StringEncoding]);
//            
//        }else{
//            NSLog(@"服务器返回失败>>%@",[[NSString alloc]initWithData:reciveData encoding:NSUTF8StringEncoding]);
//            
//        }
//        
//    }
    
    
    
    
    return request;
}



#pragma mark 获取验证码
+(NSURLRequest *)getVerificationCodePhone:(NSString *)phone{
    if (phone == nil) {
        return nil;
    }
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@",NLmobileApiBaseUrl,NLUserApi,User_GetRegistercode,phone];
    return [NLHTTPRequestFactory createRequestWithURL:[NSURL URLWithString:urlString] body:nil method:NLHTTPRequestMethodGet authHeader:NO];
}


@end
