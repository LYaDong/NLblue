//
//  NLBluetoothDataAnalytical.m
//  NBlue
//
//  Created by LYD on 15/11/23.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLBluetoothDataAnalytical.h"
#import "NLSQLData.h"
    

@implementation NLBluetoothDataAnalytical

#pragma mark bytes 为2 的互相转换
+(NSString *)bytesTo:(NSString *)data{
    NSString *yearRang = [data substringWithRange:NSMakeRange(4, 4)];
    NSString *oneStr = nil;
    NSString *toStr = nil;
    for (int i = 0 ; i<yearRang.length; i++) {
        NSString *split = [yearRang substringWithRange:NSMakeRange(i, 2)];
        if (i==0) {
            oneStr = split;
        }else{
            toStr = split;
        }
        i++;
    }
    NSString *bytesTo = [NSString stringWithFormat:@"%ld",[self ToHexConversion:[NSString stringWithFormat:@"%@%@",toStr,oneStr]]];
    return bytesTo;
}



#pragma mark 四位数的进制转换 10进制
+ (long)ToHexConversion:(NSString *)num
{
    long   number = strtoul([[num substringWithRange:NSMakeRange(0, 4)] UTF8String],0,16);
    return number;
}

#pragma mark 两位数进制转换 10进制
+(NSArray *)FourHexConversion:(NSString *)hexString{
    NSMutableArray *numbers = [NSMutableArray arrayWithCapacity:0];
    int int_ch = 0;
    for(int i=0;i<[hexString length];i++)
    {
        unichar hex_char1 = [hexString characterAtIndex:i];
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i];
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            int_ch2 = hex_char2-87; //// a 的Ascll - 97
        
        int_ch = int_ch1+int_ch2;
        [numbers addObject:[NSString stringWithFormat:@"%d",int_ch]];
    }
    
    return numbers;
}

#pragma mark 10进制转16进制
+(NSString *)tenTurnSixTeen:(NSInteger)index{
    if (index<3){return nil;}
    NSMutableString *string = [NSMutableString string];
    NSString  *sixTeen = [[NSString alloc] initWithFormat:@"%lx",(long)index];
    NSString *forTo = [sixTeen substringWithRange:NSMakeRange(sixTeen.length - 2, 2)];
    NSString *forOne = [sixTeen substringWithRange:NSMakeRange(0, 1)];
    [string appendFormat:@"%@%@",forTo,forOne];
    return string;
}







+(void)bluetoothCommandReturnData:(NSString *)data{
    NSString *format = [data substringWithRange:NSMakeRange(0, 4)];
    if ([format isEqualToString:EquiomentCommand_0201]) {
        [self equopmentInformation:data];
    }
    if ([format isEqualToString:EquiomentCommand_0901]) {
        NSLog(@"%@",data);
    }
    
}

+(void)equopmentInformation:(NSString *)data{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *arr = [self FourHexConversion:[data substringFromIndex:8]];
    [dic setValue:[self bytesTo:data] forKey:@"Device_id"];
    [dic setValue:arr[0] forKey:@"Version"];
    [dic setValue:arr[1] forKey:@"Mode"];
    [dic setValue:arr[2] forKey:@"Batt_status"];
    [dic setValue:arr[3] forKey:@"Energe"];
    [dic setValue:arr[4] forKey:@"Pair_flag"];
    [dic setValue:arr[5] forKey:@"Reserved"];
    [NLSQLData bluetoothEquipmentInformation:dic];
}




































@end





