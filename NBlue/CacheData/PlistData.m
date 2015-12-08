//
//  PlistData.m
//  NBlue
//
//  Created by LYD on 15/11/26.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "PlistData.h"

@implementation PlistData
+(NSString *)seekPath{
    NSString *str = NSHomeDirectory();
    NSString *documentPath = [str stringByAppendingString:@"/Documents"];
    NSFileManager *manger = [NSFileManager defaultManager];
    [manger createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",documentPath,@"PlistFile"] withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",documentPath,@"PlistFile"];
    return filePath;
}

+(void)individuaData:(NSDictionary *)dic{
    NSString *plistPath = [[self seekPath] stringByAppendingPathComponent:@"IndiciDua.plist"];
    [dic writeToFile:plistPath atomically:YES];
}
+(NSMutableDictionary *)getIndividuaData{
    NSString *plistPath = [[self seekPath] stringByAppendingPathComponent:@"IndiciDua.plist"];
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    return dicData;
}

@end
