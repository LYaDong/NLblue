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
    NSString *bytesTo = [NSString stringWithFormat:@"%ld",[self sixTenHexTeen:[NSString stringWithFormat:@"%@%@",toStr,oneStr]]];
//    NSString *bytesTo = [NSString stringWithFormat:@"%ld",[self sixTenHexTeen:[NSString stringWithFormat:@"%@%@",toStr,oneStr]]];
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
    NSString *bytesTo = [NSString stringWithFormat:@"%ld",[self sixTenHexTeen:[NSString stringWithFormat:@"%@%@",toStr,oneStr]]];
//    NSString *bytesTo = [NSString stringWithFormat:@"%ld",[self ToHexConversion:[NSString stringWithFormat:@"%@%@",toStr,oneStr]]];
    return bytesTo;
}



#pragma mark 16进制 四位数的进制转换 10进制
+ (long)ToHexConversion:(NSString *)num __attribute((deprecated("方法已经替换，不建议使用，使用 sixTenHexTeen：")))
{
    long   number = strtoul([[num substringWithRange:NSMakeRange(0, 4)] UTF8String],0,16);
    return number;
}

+ (long)sixTenHexTeen:(NSString *)num
{
    long   number = strtoul([[num substringWithRange:NSMakeRange(0, num.length)] UTF8String],0,16);
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


+(NSString *)tenTurnSixTeen:(NSInteger)index __attribute((deprecated("方法写的不是很完整：故转换用tenturnSinTenNew：")))
{
    if (index<3){return nil;}
    NSMutableString *string = [NSMutableString string];
    NSString  *sixTeen = [[NSString alloc] initWithFormat:@"%lx",(long)index];
    NSString *forTo = [sixTeen substringWithRange:NSMakeRange(sixTeen.length - 2, 2)];
    NSString *forOne = [sixTeen substringWithRange:NSMakeRange(0, 1)];
    [string appendFormat:@"%@%@",forTo,forOne];
    return string;
}
#pragma mark 10进制转16进制
+(NSString *)tenturnSinTenNew:(NSInteger)index{
    NSString  *sixTeen = [[NSString alloc] initWithFormat:@"%lx",(long)index];
    return sixTeen;
}


+(void)bluetoothCommandReturnData:(NSString *)data{
    if (data.length<=4) {
        return;
    }
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




#pragma mark ===========================数据分割线=============================

//运动数据
+(void)blueSportOrdinArrayData:(NSArray *)arr{
    
    
    NSLog(@"%@",arr);
    //    NSString *timeByte = arr[0];
    //    NSString *format = [timeByte substringWithRange:NSMakeRange(8, 4)];
    //    NSLog(@"%@",[self bytesToFour:@"df07"]);
    //    NSLog(@"%@",[self FourHexConversion:[timeByte substringWithRange:NSMakeRange(12, 4)]]);
    
    
//    arr = @[@"08030110e007010700000f602200",
//            @"080302100f000000000000000a0000000c000000",
//            @"0803030f00000000000000000000000000000000",
//            @"0803040f00000000000000000000000000000000",
//            @"0803050f00000000000000000000000000000000",
//            @"0803060f00000000000000000000000000000000",
//            @"0803070f00000000000000000000000000000000",
//            @"0803080f00000000000000000000000000000000",
//            @"0803090f00000000000000000000000000000000",
//            @"08030a0f00000000000000000000000000000000",
//            @"08030b0f00000000000000000000000000000000",
//            @"08030c0f00000000000000000000000000000000",
//            @"08030d0f00000000000000000000000000000000",
//            @"08030e0f00000000000000000000000000000000",
//            @"08030f0f00000000000000000000000000000000",
//            @"0803100f00000000000000000000000000000000",
//            @"0803110f00000000000000000000000000000000",
//            @"0803120f00000000000000000000000000000000",
//            @"0803130f00000000000000000000000000000000",
//            @"0803140f00000000000000000000000000000000",
//            @"0803150f00000000000000000000000000000000",
//            @"0803160f00000000000000000000000000000000",
//            @"0803170f00000000000000000000000000000000",
//            @"0803180f00000000000000000000000000000000",
//            @"0803190f00000000000000000000000000000000",
//            @"08031a0f3c0003a0000000000000000000000000",
//            @"08031b0f00000000000000000000000000000000",
//            @"08031c0f00000000000000000000000000000000",
//            @"08031d0f00000000000000000000000000000000",
//            @"08031e0f00000000000000000000000000000000",
//            @"08031f0f00000000000000000000000000000000",
//            @"0803200f00000000000000000000000000000000",
//            @"0803210f00000000000000000000000000000000",
//            @"0803220f00000000000000000000000000000000"];
    
    
    
//    08031a0f5cc003000188c00a7001000000000000
    
    
    
    NSLog(@"%@",arr);
    
    [NLSQLData establishSportDataTable];//创建sportData表
    


    Byte *testByte = [self stringConversionByte:@"5cc0030001"];
    NSInteger step = ((testByte[0] & 0xFC) >> 2) + ((testByte[1] & 0x3F) << 6);
    NSInteger time = ((testByte[1] & 0xC0) >> 6) + ((testByte[2] & 0x03) << 2);
    NSInteger cal = ((testByte[2] & 0xFC) >> 2) + ((testByte[3] & 0x0F) << 6);
    NSInteger
    dis = ((testByte[3] & 0xF0) >> 4) + ((testByte[4] & 0xFF) << 4);
    
    NSLog(@"step = %ld time %ld cal %ld dis %ld",(long)step,(long)time,(long)cal,(long)dis);
    
    

    
    NSMutableDictionary *dicSportDataBig = [NSMutableDictionary dictionary];
//    //计算时间
    NSString *year = [arr[0] substringWithRange:NSMakeRange(8, 4)];
    NSString *yearDate = [NSString stringWithFormat:@"%ld",[self sixTenHexTeen:[self reversedPositionStr:year]]];
    NSString *moht = [arr[0] substringWithRange:NSMakeRange(12, 4)];
    NSArray *mothDate = [self FourHexConversion:moht];
    
    NSString *month = nil;
    NSString *days = nil;
    //判断大不大于10  大于10 则不补0  否则补0
    if ([mothDate[0] integerValue]>=10) {
        month = [NSString stringWithFormat:@"%@",mothDate[0]];
    }else{
        month = [NSString stringWithFormat:@"0%@",mothDate[0]];
    }
    
    if ([mothDate[1] integerValue]>=10) {
        days = [NSString stringWithFormat:@"%@",mothDate[1]];
    }else{
        days = [NSString stringWithFormat:@"0%@",mothDate[1]];
    }
    
    NSString *sportDate = [NSString stringWithFormat:@"%@-%@-%@",yearDate,month,days];
    
    //计算总步数 总卡路里
    NSString *sportCountStr = [arr[1] substringWithRange:NSMakeRange(8 * 1, 8)];
    NSString *sportCount = [NSString stringWithFormat:@"%ld",[self sixTenHexTeen:[self reversedPositionStr:sportCountStr]]];
    NSString *sportClaorie =[arr[1] substringWithRange:NSMakeRange(8 * 2, 8)];
    NSString *caloriesAmount = [NSString stringWithFormat:@"%ld",[self sixTenHexTeen:[self reversedPositionStr:sportClaorie]]];
    NSString *distanceStr = [arr[1] substringWithRange:NSMakeRange(8 * 3, 8)];
    NSString *distanceCount = [NSString stringWithFormat:@"%ld",[self sixTenHexTeen:[self reversedPositionStr:distanceStr]]];
    
    [dicSportDataBig setValue:sportDate forKey:@"sportDate"];
    [dicSportDataBig setValue:sportCount forKey:@"stepsAmount"];
    [dicSportDataBig setValue:caloriesAmount forKey:@"caloriesAmount"];
    [dicSportDataBig setValue:distanceCount forKey:@"distanceAmount"];
    
    
    
    
    static NSInteger timeInterval = 0;
    NSInteger stepCount = 0;
    NSMutableArray *stepFragments = [NSMutableArray array];
    NSInteger count = 0;
    for (NSInteger i = 0; i<arr.count; i++) {
        if (i==0||i==1) {
            
        }else{
            
            NSString *data = arr[i];
            for (NSInteger j = 0; j<3; j++) {
                timeInterval ++;
                NSMutableDictionary *dicSportDataSmall = [NSMutableDictionary dictionary];
                
                //计算步数卡路里什么的
                NSString *format = [data substringWithRange:NSMakeRange(8 + j*10, 10)];
                
                if (![format isEqualToString:@"0000000000"]) {
                    count++;
                }
                
                NSString *countinterVal = nil;
                if (timeInterval>=10) {
                    countinterVal = [NSString stringWithFormat:@"%ld",(long)timeInterval];
                }else{
                    countinterVal = [NSString stringWithFormat:@"0%ld",(long)timeInterval];
                }
                
                Byte *testByte = [self stringConversionByte:format];
                NSInteger step = ((testByte[0] & 0xFC) >> 2) + ((testByte[1] & 0x3F) << 6);
                NSInteger time = ((testByte[1] & 0xC0) >> 6) + ((testByte[2] & 0x03) << 2);
                NSInteger calorie = ((testByte[2] & 0xFC) >> 2) + ((testByte[3] & 0x0F) << 6);
                NSInteger distance = ((testByte[3] & 0xF0) >> 4) + ((testByte[4] & 0xFF) << 4);
                [dicSportDataSmall setValue:[NSNumber numberWithInteger:time] forKey:@"activeTime"];
                [dicSportDataSmall setValue:[NSNumber numberWithInteger:calorie] forKey:@"calories"];
                [dicSportDataSmall setValue:[NSNumber numberWithInteger:distance] forKey:@"distance"];
                [dicSportDataSmall setValue:[NSNumber numberWithInteger:step] forKey:@"steps"];
                [dicSportDataSmall setValue:[NSString stringWithFormat:@"%@-%@-%@-%@",yearDate,month,days,countinterVal] forKey:@"seris"];
               
                NSLog(@"步数 = %ld 时间 %ld 卡路里 %ld 距离 %ld",(long)step,(long)time,(long)calorie,(long)distance);
                
                    
                stepCount = step + stepCount;
                
                [stepFragments addObject:dicSportDataSmall];
            }
        }
    }
    
    
    [dicSportDataBig setValue:stepFragments forKey:@"stepFragments"];
    [dicSportDataBig setValue:[NSNumber numberWithInteger:count] forKey:@"count"];
    
    NSLog(@"%@",dicSportDataBig);
    
    
    [NLSQLData upDataSport:[NSArray arrayWithObjects:dicSportDataBig, nil] isUpdata:0];
}

+(void)bluesleepOrdinArrayData:(NSArray *)arr{
    NSLog(@"%@",arr);
    
//    08040110df0708010623d8000904,
//    080402100604015c005000000804,
//    arr = @[@"08040110df0708010623d8000904",
//            @"080402100604015c005000000804"];
    
    NSMutableArray *sleepDataArray = [NSMutableArray array];
    NSMutableDictionary *sleepDataDic = [NSMutableDictionary dictionary];
    
    
    //年月日
    NSString *timesYear = [self reversedPositionStr:[arr[0] substringWithRange:NSMakeRange(8, 4)]];
    NSArray *monthDay =[self FourHexConversion:[arr[0] substringWithRange:NSMakeRange(12, 4)]];
    long years = (long)[self sixTenHexTeen:timesYear];
    NSString * months = nil;
    NSString * days = nil;
    //判断大不大于10  大于10 则不补0  否则补0
    if ([monthDay[0] integerValue]>=10) {
        months = [NSString stringWithFormat:@"%@",monthDay[0]];
    }else{
        months = [NSString stringWithFormat:@"0%@",monthDay[0]];
    }
    
    if ([monthDay[1] integerValue]>=10) {
        days = [NSString stringWithFormat:@"%@",monthDay[1]];
    }else{
        days = [NSString stringWithFormat:@"0%@",monthDay[1]];
    }
    
    
    //结束睡眠时间
    NSArray *endTimeArr = [self FourHexConversion:[arr[0] substringWithRange:NSMakeRange(16, 4)]];
    NSString *hours = nil;
    NSString *miute = nil;
    if ([endTimeArr[0] integerValue]>=10) {
        hours = [NSString stringWithFormat:@"%@",endTimeArr[0]];
    }else{
        hours = [NSString stringWithFormat:@"0%@",endTimeArr[0]];
    }
    
    if ([endTimeArr[1] integerValue]>=10) {
        miute = [NSString stringWithFormat:@"%@",endTimeArr[1]];
    }else{
        miute = [NSString stringWithFormat:@"0%@",endTimeArr[1]];
    }
    
    long sleepTime = [self sixTenHexTeen:[self reversedPositionStr:[arr[0] substringWithRange:NSMakeRange(20, 4)]]];
    
    
    
    NSString *yearMonthDay = [NSString stringWithFormat:@"%ld-%@-%@",(long)years,months,days];
    NSString *endTime = [NSString stringWithFormat:@"%@:%@",hours,miute];
    
//    NSLog(@"%@ %@睡醒 持续%f",yearMonthDay,endTime,sleepTime/60.0f);
    
    
//    08040210 06 04 01 5c005000000804,
    
    NSArray *sleepCountArr = [self FourHexConversion:[arr[1] substringWithRange:NSMakeRange(8, 6)]];
    long showllContinuedTime = [self sixTenHexTeen:[self reversedPositionStr:[arr[1] substringWithRange:NSMakeRange(14, 4)]]];
    long deepContinuedTime = [self sixTenHexTeen:[self reversedPositionStr:[arr[1] substringWithRange:NSMakeRange(18, 4)]]];
    
    NSLog(@"%@ %@睡醒 持续%f",yearMonthDay,endTime,sleepTime/60.0f);
    NSLog(@"浅睡眠%@次 深睡眠%@次  醒来%@次  浅睡眠时间：%0.01f 深睡眠时间%0.01f",sleepCountArr[0],sleepCountArr[1],sleepCountArr[2],showllContinuedTime/60.0f,deepContinuedTime/60.0f);
    
    [sleepDataDic setValue:yearMonthDay forKey:@"sleepDate"];
    [sleepDataDic setValue:endTime forKey:@"endSleep_Time"];
    [sleepDataDic setValue:[NSString stringWithFormat:@"%ld",(long)sleepTime] forKey:@"total_time"];
    [sleepDataDic setValue:sleepCountArr[0] forKey:@"lightSleep_count"];
    [sleepDataDic setValue:sleepCountArr[1] forKey:@"deepSleep_count"];
    [sleepDataDic setValue:sleepCountArr[2] forKey:@"awake_count"];
    [sleepDataDic setValue:[NSString stringWithFormat:@"%ld",(long)showllContinuedTime] forKey:@"lightSleep_mins"];
    [sleepDataDic setValue:[NSString stringWithFormat:@"%ld",(long)showllContinuedTime] forKey:@"deepSleep_mins"];
    
    [sleepDataArray addObject:sleepDataDic];
    
    
    [NLSQLData sleepDataTable];
    [NLSQLData insterSleepData:sleepDataArray isUpdata:0];
}



+(Byte *)stringConversionByte:(NSString *)hexString{

    NSInteger j=0;
    unsigned long num = hexString.length/2;
    Byte bytes[num];
    for(NSInteger i=0;i<[hexString length];i++)
    {
        NSInteger int_ch;  /// 两位16进制数转化后的10进制数
        
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        NSInteger int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        NSInteger int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            int_ch2 = hex_char2-87; //// a 的Ascll - 97
        
        int_ch = int_ch1+int_ch2;
        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
        j++;
    }
    
    NSData *newData = [[NSData alloc] initWithBytes:bytes length:num];
    Byte *testByte = (Byte *)[newData bytes];
    return testByte;
}



@end





