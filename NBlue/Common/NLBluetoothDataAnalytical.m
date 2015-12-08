//
//  NLBluetoothDataAnalytical.m
//  NBlue
//
//  Created by LYD on 15/11/23.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLBluetoothDataAnalytical.h"
#import "NLSQLData.h"
    
@interface NLBluetoothDataAnalytical ()
@property(nonatomic,strong)NSMutableArray *sportArrData;
@end
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

//4为Byte 转时间
+(NSString *)bytesToFour:(NSString *)data{
    NSString *yearRang = data;
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



#pragma mark 16进制 四位数的进制转换 10进制
+ (long)ToHexConversion:(NSString *)num
{
    long   number = strtoul([[num substringWithRange:NSMakeRange(0, 4)] UTF8String],0,16);
    return number;
}

#pragma mark 两位16进制转换10进制
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

//运动数据
+(void)blueSportOrdinArrayData:(NSArray *)arr{
//    NSString *timeByte = arr[0];
//    NSString *format = [timeByte substringWithRange:NSMakeRange(8, 4)];
//    NSLog(@"%@",[self bytesToFour:@"df07"]);
//    NSLog(@"%@",[self FourHexConversion:[timeByte substringWithRange:NSMakeRange(12, 4)]]);
    
    
    NSArray *arrData = @[@"08030110df070c0800000f602200",
                     @"08030210d50000000800000095000000a3000000",
                     @"0803030f00000000000000000000000000000000",
                     @"0803040f00000000000000000000000000000000",
                     @"0803050f00000000000000000000000000000000",
                     @"0803060f00000000000000000000000000000000",
                     @"0803070f00000000000000000000000000000000",
                     @"0803080f00000000000000000000000000000000",
                     @"0803090f00000000000000000000000000000000",
                     @"08030a0f00000000000000000000000000000000",
                     @"08030b0f00000000000000000000000000000000",
                     @"08030c0f00000000000000000000000000000000",
                     @"08030d0f00000000000000000000000000000000",
                     @"08030e0f00000000000000000000000000000000",
                     @"08030f0f00000000000000000000000000000000",
                     @"0803100f00000000000000000000000000000000",
                     @"0803110f00000000000000000000000000000000",
                     @"0803120f00000000000000000000000000000000",
                     @"0803130f00000000000000000000000000000000",
                     @"0803140f00000000000000000000000000000000",
                     @"0803150f00000000000000000000000000000000",
                     @"0803160f604112e0030000000000000000000000",
                     @"0803170f00000000000000000000000000000000",
                     @"0803180f00000000000000000000000000000000",
                     @"0803190f00000000000000000000000000000000",
                     @"08031a0f5cc003000188c00a7001000000000000",
                     @"08031b0f88800480013080039000000000000000",
                     @"08031c0f00000000000000000000580004f00000",
                     @"08031d0f00000000000000000000000000000000",
                     @"08031e0f00000000000000000000000000000000",
                     @"08031f0f00000000000000000000000000000000",
                     @"0803200f00000000000000000000000000000000",
                     @"0803210f00000000000000000000000000000000",
                     @"0803220f00000000000000000000000000000000",];


   [self toDecimalSystemWithBinarySystem:[self getBinaryByhex:[self reversedPositionStr:@"604112e003"]]];
    
    
    for (NSInteger i = 0; i<arrData.count; i++) {
        if (i==0||i==1) {}else{
            NSString *data = arrData[i];
            for (NSInteger j = 0; j<3; j++) {
                NSString *format = [data substringWithRange:NSMakeRange(8 + j*10, 10)];
                NSString *reversenStr = [self reversedPositionStr:format];
                NSString *hexTo = [self getBinaryByhex:reversenStr];
                NSString *hexSixTeen = [self toDecimalSystemWithBinarySystem:hexTo];
                
                NSLog(@"%@",hexSixTeen);
                
            }
        }
        
    }

    
}





#pragma mark 前后位置颠倒
+(NSString *)reversedPositionStr:(NSString *)str{
    NSMutableString *string = [NSMutableString string];
    NSMutableArray *dataArr = [NSMutableArray array];
    for (NSInteger i=0; i<str.length; i+=2) {
        [dataArr addObject:[str substringWithRange:NSMakeRange(i, 2)]];
    }
    NSInteger j = dataArr.count;
    while (j !=0) {
        j--;
        [string appendFormat:@"%@",dataArr[j]];
    }
    return string;
}

#pragma mark 16进制转2进制
+(NSString *)getBinaryByhex:(NSString *)hex
{
    NSMutableDictionary  *hexDic = [[NSMutableDictionary alloc] init];
    hexDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    [hexDic setObject:@"0000" forKey:@"0"];
    [hexDic setObject:@"0001" forKey:@"1"];
    [hexDic setObject:@"0010" forKey:@"2"];
    [hexDic setObject:@"0011" forKey:@"3"];
    [hexDic setObject:@"0100" forKey:@"4"];
    [hexDic setObject:@"0101" forKey:@"5"];
    [hexDic setObject:@"0110" forKey:@"6"];
    [hexDic setObject:@"0111" forKey:@"7"];
    [hexDic setObject:@"1000" forKey:@"8"];
    [hexDic setObject:@"1001" forKey:@"9"];
    [hexDic setObject:@"1010" forKey:@"a"];
    [hexDic setObject:@"1011" forKey:@"b"];
    [hexDic setObject:@"1100" forKey:@"c"];
    [hexDic setObject:@"1101" forKey:@"d"];
    [hexDic setObject:@"1110" forKey:@"e"];
    [hexDic setObject:@"1111" forKey:@"f"];
    
    NSMutableString *binaryString=[[NSMutableString alloc] init];
    for (int i=0; i<[hex length]; i++) {
        NSRange rage;
        rage.length = 1;
        rage.location = i;
        NSString *key = [hex substringWithRange:rage];
        [binaryString appendFormat:@"%@",[hexDic objectForKey:key]];
    }
    return binaryString;
}




#pragma mark 2进制转10进制
+ (NSString *)toDecimalSystemWithBinarySystem:(NSString *)binary
{
    int ll = 0 ;
    int  temp = 0 ;
    for (int i = 0; i < binary.length; i ++)
    {
        temp = [[binary substringWithRange:NSMakeRange(i, 1)] intValue];
        temp = temp * powf(2, binary.length - i - 1);
        ll += temp;
    }
    
    NSString * result = [NSString stringWithFormat:@"%d",ll];
    
    return result;
}
#pragma mark 10进制转换2进制
+ (NSString *)toBinarySystemWithDecimalSystem:(NSString *)decimal
{
    int num = [decimal intValue];
    int remainder = 0;      //余数
    int divisor = 0;        //除数
    
    NSString * prepare = @"";
    
    while (true)
    {
        remainder = num%2;
        divisor = num/2;
        num = divisor;
        prepare = [prepare stringByAppendingFormat:@"%d",remainder];
        
        if (divisor == 0)
        {
            break;
        }
    }
    
    NSString * result = @"";
    for (NSInteger i = prepare.length - 1; i >= 0; i --)
    {
        result = [result stringByAppendingFormat:@"%@",[prepare substringWithRange:NSMakeRange(i , 1)]];
    }
    
    return result;
}























@end





