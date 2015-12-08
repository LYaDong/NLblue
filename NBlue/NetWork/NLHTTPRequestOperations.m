//
//  NLHTTPRequestOperations.m
//  pinai
//
//  Created by LYD on 15/11/19.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLHTTPRequestOperations.h"

@implementation NLHTTPRequestOperations
- (instancetype)initWithRequest:(NSURLRequest *)urlRequest {
    
    self = [super initWithRequest:urlRequest];
    if (self) {
        //TODO:encode
        //self.securityPolicy = [self defaultSecurityPolicy];
    }
    return self;
}

- (AFSecurityPolicy*) defaultSecurityPolicy {
    static AFSecurityPolicy *policy = nil;
    if(!policy)
        policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    return policy;
}
@end
