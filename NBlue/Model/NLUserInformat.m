//
//  NLUserInformat.m
//  NBlue
//
//  Created by LYD on 15/12/26.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLUserInformat.h"

@implementation NLUserInformat
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
