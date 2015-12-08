//
//  NLHTTPRequestOperations.h
//  pinai
//
//  Created by LYD on 15/11/19.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "AFHTTPRequestOperation.h"

@interface NLHTTPRequestOperations : AFHTTPRequestOperation
- (instancetype)initWithRequest:(NSURLRequest *)urlRequest;
@end
