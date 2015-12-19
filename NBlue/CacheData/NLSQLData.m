//
//  NLSQLData.m
//  NBlue
//
//  Created by LYD on 15/11/27.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLSQLData.h"
#import "FMDatabase.h"
@implementation NLSQLData
+(NSString *)seekPath{
    NSString *str = NSHomeDirectory();
    NSString *documentPath = [str stringByAppendingString:@"/Documents"];
    return documentPath;
}

+(FMDatabase *)sqlDataRoute{
    FMDatabase *db = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@/NLData.sqlite",[self seekPath]]];
    return db;
}

#pragma mark 蓝牙设备信息
+(void)bluetoothEquipmentInformation:(NSDictionary *)dic{
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    
    NSString *createTable = @"create table if not exists EquipmentInformation (Device_id text primary key,Version integer not null,Mode text not null,Batt_status text null,Energe text not null,Pair_flag text not null,Reserved text not null)";
    [db executeUpdate:createTable];
    
    [db executeUpdate:@"insert or replace into EquipmentInformation (Device_id,Version,Mode,Batt_status,Energe,Pair_flag,Reserved) values (?,?,?,?,?,?,?)" withArgumentsInArray:
     [NSArray arrayWithObjects:
      [dic objectForKey:@"Device_id"],
      [dic objectForKey:@"Version"],
      [dic objectForKey:@"Mode"],
      [dic objectForKey:@"Batt_status"],
      [dic objectForKey:@"Energe"],
      [dic objectForKey:@"Pair_flag"],
      [dic objectForKey:@"Reserved"],
      nil]];
    [db close];
}
+(NSMutableDictionary *)getBluetoothEquipmentInformation{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    NSString *takeCreate = [NSString stringWithFormat:@"select * from EquipmentInformation"];
    FMResultSet *rs = [db executeQuery:takeCreate];
    while ([rs next]) {
        [dictionary setValue:[rs stringForColumn:@"Device_id"] forKey:@"Device_id"];
        [dictionary setValue:[rs stringForColumn:@"Version"] forKey:@"Version"];
        [dictionary setValue:[rs stringForColumn:@"Mode"] forKey:@"Mode"];
        [dictionary setValue:[rs stringForColumn:@"Batt_status"] forKey:@"Batt_status"];
        [dictionary setValue:[rs stringForColumn:@"Energe"] forKey:@"Energe"];
        [dictionary setValue:[rs stringForColumn:@"Pair_flag"] forKey:@"Pair_flag"];
        [dictionary setValue:[rs stringForColumn:@"Reserved"] forKey:@"Reserved"];
    }
    [db close];
    return dictionary;
}
+(void)deleEquiomentINformation{
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    NSString *del = @"drop table EquipmentInformation";
    [db executeUpdate:del];
    [db close];
}


#pragma mark 运动数据
+(void)sportRecordCreateData:(NSArray *)arr isDeposit:(NSInteger)isDeposit{
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    NSString *createTable = @"create table if not exists SportData (caloriesAmount integer not null,count integer not null,sportDate text not null,stepsAmount integer not null,calories integer not null,endTime text not null,id text not null,startTime text not null,steps integer not null,user_id text not null,isDeposit text not null,timeInterval text not null,distanceCount text not null)";
    [db executeUpdate:createTable];
    NSDictionary *dic = nil;
    for (dic in arr) {
        for (NSInteger i = 0; i<[[dic objectForKey:@"stepFragments"] count]; i++) {
            
            NSString *ids = [self sportDateCheckID:[[[dic objectForKey:@"stepFragments"] objectAtIndex:i] objectForKey:@"id"]];
            if (!ids) {
                [self setSportData:db dicData:dic i:i];
            }else{
                [self  delDateSportIDData:ids];
                [self setSportData:db dicData:dic i:i];
            }  
        }
    }
    [db close];
}

+(void)setSportData:(FMDatabase *)db dicData:(NSDictionary *)dic i:(NSInteger)i{
    [db executeUpdate:@"insert or replace into SportData (caloriesAmount,count,sportDate,stepsAmount,calories,endTime,id,startTime,steps,user_id,isDeposit,timeInterval) values (?,?,?,?,?,?,?,?,?,?,?,?)" withArgumentsInArray:
     [NSArray arrayWithObjects:
      [dic objectForKey:@"caloriesAmount"],
      [dic objectForKey:@"count"],
      [dic objectForKey:@"sportDate"],
      [dic objectForKey:@"stepsAmount"],
      [[[dic objectForKey:@"stepFragments"] objectAtIndex:i] objectForKey:@"calories"],
      [[[dic objectForKey:@"stepFragments"] objectAtIndex:i] objectForKey:@"endTime"],
      [[[dic objectForKey:@"stepFragments"] objectAtIndex:i] objectForKey:@"id"],
      [[[dic objectForKey:@"stepFragments"] objectAtIndex:i] objectForKey:@"startTime"],
      [[[dic objectForKey:@"stepFragments"] objectAtIndex:i] objectForKey:@"steps"],
      [kAPPDELEGATE._loacluserinfo GetUser_ID],
      @"1",
      @"nil",
      @"nil",
      nil]];
}



+(void)sportBlueData:(NSDictionary *)sportData{
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    
    NSString *createTable = @"create table if not exists SportData (caloriesAmount integer not null,count integer not null,sportDate text not null,stepsAmount integer not null,calories integer not null,endTime text not null,id text not null,startTime text not null,steps integer not null,user_id text not null,isDeposit text not null,timeInterval text not null,distanceCount text not null)";
    [db executeUpdate:createTable];
    [self depositSportBlueData:db sportData:sportData];
}
+(void)depositSportBlueData:(FMDatabase *)db sportData:(NSDictionary *)sportData{
    
    
    
    [db executeUpdate:@"insert or replace into SportData (caloriesAmount,count,sportDate,stepsAmount,calories,endTime,id,startTime,steps,user_id,isDeposit,timeInterval,distanceCount) values (?,?,?,?,?,?,?,?,?,?,?,?,?)" withArgumentsInArray:
     [NSArray arrayWithObjects:
      [sportData objectForKey:@"caloriesAmount"]==nil?@"":[sportData objectForKey:@"caloriesAmount"],
      @"1",
      [sportData objectForKey:@"sportDate"],
      [sportData objectForKey:@"stepsAmount"],
      [sportData objectForKey:@"calories"],
      @"1",
      @"1",
      @"1",
      [sportData objectForKey:@"steps"],
      [kAPPDELEGATE._loacluserinfo GetUser_ID],
      @"1",
      [sportData objectForKey:@"timeInterval"],
      [sportData objectForKey:@"distanceCount"],
      nil]];
    [db close];
}




+(NSMutableArray *)sportRecordGetData{
    NSMutableArray *dataArr = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    FMDatabase *db =[self sqlDataRoute];
    [db open];
    NSString *takeCreate = [NSString stringWithFormat:@"select * from SportData where user_id = '%@'",[kAPPDELEGATE._loacluserinfo GetUser_ID]];
    FMResultSet *rs = [db executeQuery:takeCreate];
    while ([rs next]) {
        [dic setValue:[rs stringForColumn:@"caloriesAmount"] forKey:@"caloriesAmount"];
        [dic setValue:[rs stringForColumn:@"count"] forKey:@"count"];
        [dic setValue:[rs stringForColumn:@"sportDate"] forKey:@"sportDate"];
        [dic setValue:[rs stringForColumn:@"stepsAmount"] forKey:@"stepsAmount"];
        [dic setValue:[rs stringForColumn:@"calories"] forKey:@"calories"];
        [dic setValue:[rs stringForColumn:@"endTime"] forKey:@"endTime"];
        [dic setValue:[rs stringForColumn:@"id"] forKey:@"id"];
        [dic setValue:[rs stringForColumn:@"startTime"] forKey:@"startTime"];
        [dic setValue:[rs stringForColumn:@"steps"] forKey:@"steps"];
        [dic setValue:[rs stringForColumn:@"user_id"] forKey:@"user_id"];
        [dic setValue:[rs stringForColumn:@"isDeposit"] forKey:@"isDeposit"];
        [dic setValue:[rs stringForColumn:@"timeInterval"] forKey:@"timeInterval"];
        [dic setValue:[rs stringForColumn:@"distanceCount"] forKey:@"distanceCount"];
        [dataArr addObject:dic];
    }
    [db close];
    return dataArr;
}
+(NSString *)sportDateCheckID:(NSString *)date{
    NSString *dateStr = nil;
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    NSString *takeCreate = [NSString stringWithFormat:@"select * from SportData where user_id = '%@' and id = '%@' ",[kAPPDELEGATE._loacluserinfo GetUser_ID],date];
    FMResultSet *rs = [db executeQuery:takeCreate];
    while ([rs next]) {
       dateStr = [rs stringForColumn:@"id"];
    }
    return dateStr;
}

+(void)delDateSportData:(NSString *)date{
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    NSString *del = [NSString stringWithFormat:@"delete from SportData where user_id = '%@' and sportDate = '%@'",[kAPPDELEGATE._loacluserinfo GetUser_ID],date];
    [db executeUpdate:del];
    [db close];
}

+(void)delDateSportIDData:(NSString *)data{
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    NSString *del = [NSString stringWithFormat:@"delete from SportData where user_id = '%@' and id = '%@'",[kAPPDELEGATE._loacluserinfo GetUser_ID],data];
    [db executeUpdate:del];
    [db close];
}


@end
