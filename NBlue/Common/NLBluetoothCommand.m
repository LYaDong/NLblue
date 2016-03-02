//
//  NLBluetoothCommand.m
//  NBlue
//
//  Created by 刘亚栋 on 16/2/27.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLBluetoothCommand.h"
#import "NLBluetoothDataAnalytical.h"
static NLBluetoothCommand *bluetoothaCommand = nil;

@interface NLBluetoothCommand ()
@end

@implementation NLBluetoothCommand

+(NLBluetoothCommand *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bluetoothaCommand = [[NLBluetoothCommand alloc] init];
    });
    return bluetoothaCommand;
}

//设置设备时间
+(NSData *)setEquipmentTime{
    NSString *dateTime = [ApplicationStyle datePickerTransformationYearDate:[NSDate date]];
    NSArray *arrText = [ApplicationStyle interceptText:dateTime interceptCharacter:@"-"];
    
    NSString *yeatTime = arrText[0];
    NSString *str = [NLBluetoothDataAnalytical tenTurnSixTeen:[yeatTime integerValue]];
    unsigned long red = strtoul([[str substringWithRange:NSMakeRange(0, 2)] UTF8String],0,16);
    Byte b =  (Byte) ((0xff & red) );//( Byte) 0xff&iByte;
    
    unsigned long red1 = strtoul([[str substringWithRange:NSMakeRange(2, str.length - 2)] UTF8String],0,16);
    Byte b1 =  (Byte) ((0xff & red1) );//( Byte) 0xff&iByte;
    Byte month = [ApplicationStyle byteTransformationTextSixteenByteStr:[NLBluetoothDataAnalytical tenturnSinTenNew:[arrText[1] integerValue]]];
    Byte day = [ApplicationStyle byteTransformationTextSixteenByteStr:[NLBluetoothDataAnalytical tenturnSinTenNew:[arrText[2] integerValue]]];
    Byte dayTime = [ApplicationStyle byteTransformationTextSixteenByteStr:[NLBluetoothDataAnalytical tenturnSinTenNew:[arrText[3] integerValue]]];
    Byte branch = [ApplicationStyle byteTransformationTextSixteenByteStr:[NLBluetoothDataAnalytical tenturnSinTenNew:[arrText[4] integerValue]]];
    Byte second = [ApplicationStyle byteTransformationTextSixteenByteStr:[NLBluetoothDataAnalytical tenturnSinTenNew:[arrText[5] integerValue]]];
    Byte weekDay = [ApplicationStyle byteTransformationTextSixteenByteStr:[NLBluetoothDataAnalytical tenturnSinTenNew:[[NSString stringWithFormat:@"0%ld",(long)[ApplicationStyle currentDayWeek:[NSDate date]]] integerValue]]];
    
    NSLog(@"%hhu %hhu",b,b1);
    
    Byte byte[20] = {0x03,0x01,b,b1,month,day,dayTime,branch,second,weekDay};
    NSData *data = [NSData dataWithBytes:byte length:20];
    return data;
}


#pragma mark 获取运动数据
//开始同步数据
+ (NSData *)startSynchronizationSportData{
    Byte byte[20] = {0x08,0x01,0x01,0x01};
    NSData *data = [NSData dataWithBytes:byte length:20];
    return data;
}
//开始获得运动数据
+ (NSData *)sportDataQuery{
    Byte byte[20] = {0x08,0x03,0x01};
    NSData *data = [NSData dataWithBytes:byte length:20];
    return data;
}
//开始获得睡眠数据
+ (NSData *)sleepDataQuery{
    Byte byte[20] = {0x08,0x04,0x01};
    NSData *data = [NSData dataWithBytes:byte length:20];
    return data;
}
#pragma mark 调温命令

+ (NSData *)setTemperatureAndTime:(NSInteger)temperature time:(NSInteger)temperatureTime{
    NSString *str = [NLBluetoothDataAnalytical tenTurnSixTeen:temperature];
    
    unsigned long red = strtoul([[str substringWithRange:NSMakeRange(0, 2)] UTF8String],0,16);
    Byte b =  (Byte) ((0xff & red) );//( Byte) 0xff&iByte;
    
    unsigned long red1 = strtoul([[str substringWithRange:NSMakeRange(2, str.length - 2)] UTF8String],0,16);
    Byte b1 =  (Byte) ((0xff & red1) );//( Byte) 0xff&iByte;
    
    unsigned long time = strtoul([[NSString stringWithFormat:@"%lx",(long)temperatureTime] UTF8String], 0, 16);
    Byte timeByty =  (Byte) ((0xff & time) );//( Byte) 0xff&iByte;
    
    Byte byte[20] = {0x90,0x03,b,b1,0x00,timeByty,0x00};
    NSData *data = [NSData dataWithBytes:byte length:20];
    return data;
}


//开始加热
+ (NSData *)setTemperatureStart{
    Byte byte[18] = {0x90,0x01,0x55};
    NSData *data = [NSData dataWithBytes:byte length:20];
    return data;
}
//结束加热
+ (NSData *)setTemperatureEnd{
    Byte byte[18] = {0x90,0x01,0xAA};
    NSData *data = [NSData dataWithBytes:byte length:20];
    return data;
}
//查询温度
+ (NSData *)queryTemperatureEquipment{
    Byte byte[20] = {0x90,0x02};
    NSData *data = [NSData dataWithBytes:byte length:20];
    return data;
}
#pragma mark ANCS连接系统
+ (NSData *)setANCSNotification{
    Byte byte[20] = {0x06,0x30};
    NSData *data = [NSData dataWithBytes:byte length:20];
    return data;
}
//子开关
+ (NSData *)setSubclassSwitch{
    Byte byte[20] = {0x03,0x30,0x88,0x00,0x00,0x55};
    NSData *data = [NSData dataWithBytes:byte length:20];
    return data;
}
//总开关
+ (NSData *)setSuperclassSwitch{
    Byte byte[20] = {0x03,0x30,0x55};
    NSData *data = [NSData dataWithBytes:byte length:20];
    return data;
}

//查询A单元电池
+(NSData *)queryAUnitLevel{
    Byte byte[20] = {0x02,0x01};
    NSData *data = [NSData dataWithBytes:byte length:20];
    return data;
}
//查询B单元电量
+(NSData *)queryBUnitLevel{
    Byte byte[20] = {0x90,0x04};
    NSData *data = [NSData dataWithBytes:byte length:20];
    return data;
}
//连接震动
+(NSData *)connectShonk{
    Byte byte[20] = {0x05,0x01};
    NSData *data = [NSData dataWithBytes:byte length:20];
    return data;
}
//重启设备
+(NSData *)connectRestart{
    Byte byte[20] = {0xF0,0x01};
    NSData *data = [NSData dataWithBytes:byte length:20];
    return data;
}
@end
