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


#pragma mark 注释 

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

+(NSString *)sportDayTaskData:(NSString *)timeDay{
    NSString *string = nil;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    NSString *taskCreate = [NSString stringWithFormat:@"select * from SportData WHERE YEARWEEK(date_format(sportDate,'Y-m')) = '2015-12'"];
    FMResultSet *rs = [db executeQuery:taskCreate];
    while ([rs next]) {
        [dic setValue:[rs stringForColumn:@"stepsAmount"] forKey:@"stepsAmount"];
    }
    return string;
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




+(void)establishSportDataTable{
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    
    NSString *createTableBig = @"CREATE TABLE IF NOT EXISTS SportDataBig (sportDate TEXT PRIMARY KEY,count INTEGER NOT NULL,distanceAmount INTEGER NOT NULL,caloriesAmount INTEGER NOT NULL,stepsAmount INTEGER NOT NULL,user_id TEXT NOT NULL,isUpData TEXT NOT NULL,timestamp INTEGER NOT NULL)";//创建一个大表
    NSString *createTableSmall = @"CREATE TABLE IF NOT EXISTS SportDataSmall (calories INTEGER NOT NULL,ids INTEGER NOT NULL,steps INTEGER NOT NULL,distance INTEGER NOT NULL,seris TEXT PRIMARY KEY,activeTime INTEGER NOT NULL,sportDate TEXT NOT NULL)";//创建一个小表
    [db executeUpdate:createTableBig];
    [db executeUpdate:createTableSmall];
    [db close];
}
+(void)insterSportData:(NSArray *)dataArr
              isUpdata:(NSInteger)updata{
    
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    NSInteger num = 0;
    __goto:
    if (num == 0) {
        NSDate *date = [ApplicationStyle whatMonth:[NSDate date] timeDay:num];
        NSInteger dayInt = [ApplicationStyle whatDays:date];
        NSInteger dayMonth = [ApplicationStyle whatMonths:date];
        NSInteger dayYear = [ApplicationStyle whatYears:date];
        for (NSInteger i=0; i<dayInt; i++) {
            
            NSString *month = nil;
            NSString *days = nil;
            if (dayMonth>=10) {
                month = [NSString stringWithFormat:@"%ld",(long)dayMonth];
            }else{
                month = [NSString stringWithFormat:@"0%ld",(long)dayMonth];
            }
            
            if (dayInt - i>=10) {
                days = [NSString stringWithFormat:@"%ld",(long)dayInt - i];
            }else{
                days = [NSString stringWithFormat:@"0%ld",(long)dayInt - i];
            }
            
            
            NSString *inster = @"INSERT OR REPLACE INTO SportDataBig (sportDate,count,distanceAmount,caloriesAmount,stepsAmount,user_id,isUpData,timestamp) VALUES (?,?,?,?,?,?,?,?)";
            NSArray *dataArrBig = [NSArray arrayWithObjects:
                                [NSString stringWithFormat:@"%ld-%@-%@",(long)dayYear,month,days],
                                @"",
                                @"",
                                @"",
                                @"0",
                                [kAPPDELEGATE._loacluserinfo GetUser_ID],
                                @"",
                                @"",
                                nil];
            
            [db executeUpdate:inster withArgumentsInArray:dataArrBig];
            
            if ([[kAPPDELEGATE._loacluserinfo getUserLogInTime] isEqualToString:[NSString stringWithFormat:@"%ld-%@-%@",(long)dayYear,month,days]]) {
                return;
            }
            
    
        }
        num = num - 1;
        goto __goto;
    }else{
        NSDate *date = [ApplicationStyle whatMonth:[NSDate date] timeDay:num];
        NSInteger dayCount = [ApplicationStyle totalDaysInMonth:date];
        //        NSInteger dayInt = [ApplicationStyle whatDays:date];
        NSInteger dayMonth = [ApplicationStyle whatMonths:date];
        NSInteger dayYear = [ApplicationStyle whatYears:date];
        for (NSInteger i=0; i<dayCount; i++) {
            NSString *establishTime = nil;
    
            NSString *month = nil;
            NSString *days = nil;
            
            if (dayMonth>=10) {
                month = [NSString stringWithFormat:@"%ld",(long)dayMonth];
            }else{
                month = [NSString stringWithFormat:@"0%ld",(long)dayMonth];
            }
            
            if (dayCount  - i >=10) {
                days = [NSString stringWithFormat:@"%ld",(long)dayCount  - i];
            }else{
                days = [NSString stringWithFormat:@"0%ld",(long)dayCount  - i];
            }
            
            
            establishTime = [NSString stringWithFormat:@"%ld-%@-%@",(long)dayYear,month,days];
            
            if ([establishTime isEqualToString:[kAPPDELEGATE._loacluserinfo getUserLogInTime]]) {
                [db close];
                return;
            }
            
            NSString *inster = @"INSERT OR REPLACE INTO SportDataBig (sportDate,count,distanceAmount,caloriesAmount,stepsAmount,user_id,isUpData,timestamp) VALUES (?,?,?,?,?,?,?,?)";
            NSArray *dataArrBig = [NSArray arrayWithObjects:
                                [NSString stringWithFormat:@"%ld-%@-%@",(long)dayYear,month,days],
                                @"",
                                @"",
                                @"",
                                @"0",
                                [kAPPDELEGATE._loacluserinfo GetUser_ID],
                                @"",
                                @"",
                                nil];
            
            [db executeUpdate:inster withArgumentsInArray:dataArrBig];
            
            
            if ([[kAPPDELEGATE._loacluserinfo getUserLogInTime] isEqualToString:establishTime]) {
                return;
            }
            
        }
        num = num - 1;
        goto __goto;
    }
}

+(void)upDataSport:(NSArray *)arr isUpdata:(NSInteger)updata{
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    
    NSDictionary *dic = nil;
    for (dic in arr) {
        NSString *timesTame = [NSString stringWithFormat:@"%0.0f",[[ApplicationStyle dateTransformationStringWhiffletree:[dic objectForKey:@"sportDate"]]timeIntervalSince1970]];
        NSString *updateTable = @"UPDATE SportDataBig SET count = ?,distanceAmount = ?,caloriesAmount = ?,stepsAmount = ?,isUpData = ?,timestamp = ? WHERE sportDate = ? and user_id = ?";
        [db executeUpdate:
         updateTable,
         [dic objectForKey:@"count"]==nil?@"0":[dic objectForKey:@"count"],
         [dic objectForKey:@"distanceAmount"]==nil?@"0":[dic objectForKey:@"distanceAmount"],
         [dic objectForKey:@"caloriesAmount"]==nil?@"0":[dic objectForKey:@"caloriesAmount"],
         [dic objectForKey:@"stepsAmount"]==nil?@"0":[dic objectForKey:@"stepsAmount"],
         [dic objectForKey:@"isUpData"]==nil?@"0":[dic objectForKey:@"isUpData"],
         timesTame,
         [dic objectForKey:@"sportDate"]==nil?@"0":[dic objectForKey:@"sportDate"],
         [kAPPDELEGATE._loacluserinfo GetUser_ID]];
        
        
        NSArray *small = [arr[0] objectForKey:@"stepFragments"];
        
        for (NSInteger i=0; i<small.count; i++) {
            

            NSString *step = [small[i] objectForKey:@"steps"];
            
            
            if (![[NSString stringWithFormat:@"%@",step] isEqualToString:@"0"]) {
                NSString *insterSmall = @"INSERT OR REPLACE INTO SportDataSmall (calories,ids,steps,distance,seris,activeTime,sportDate) VALUES (?,?,?,?,?,?,?)";
                NSArray *dataArrSmall = [NSArray arrayWithObjects:
                                         [small[i] objectForKey:@"calories"],
                                         @"",
                                         [small[i] objectForKey:@"steps"],
                                         [small[i] objectForKey:@"distance"],
                                         [small[i] objectForKey:@"seris"],
                                         [small[i] objectForKey:@"activeTime"],
                                         [dic objectForKey:@"sportDate"]==nil?@"0":[dic objectForKey:@"sportDate"],
                                         nil];
                
                [db executeUpdate:insterSmall withArgumentsInArray:dataArrSmall];
            }
        }
    }
    [db close];
}

+(NSMutableArray *)sportDataObtainTimeStr:(NSString *)timeStr{
    NSMutableArray *dataArray = [NSMutableArray array];
    NSMutableArray *stepFragments = [NSMutableArray array];
    
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    
    NSString *takeCreate = [NSString stringWithFormat:@"SELECT * FROM SportDataBig WHERE user_id = '%@' and sportDate = '%@'",[kAPPDELEGATE._loacluserinfo GetUser_ID],timeStr];
    FMResultSet *rs = [db executeQuery:takeCreate];
    NSString *time = nil;
    while ([rs next]) {
        NSMutableDictionary *dicBig = [NSMutableDictionary dictionary];
        time = [rs stringForColumn:@"sportDate"];
        [dicBig setValue:[rs stringForColumn:@"caloriesAmount"] forKey:@"caloriesAmount"];
        [dicBig setValue:[rs stringForColumn:@"count"] forKey:@"count"];
        [dicBig setValue:[rs stringForColumn:@"distanceAmount"] forKey:@"distanceAmount"];
        [dicBig setValue:[rs stringForColumn:@"sportDate"] forKey:@"sportDate"];
        [dicBig setValue:[rs stringForColumn:@"stepsAmount"] forKey:@"stepsAmount"];
        NSString *sportSamll = [NSString stringWithFormat:@"SELECT * FROM SportDataSmall WHERE sportDate = '%@'",time];
        FMResultSet *samll = [db executeQuery:sportSamll];
        while ([samll next]) {
            NSMutableDictionary *dicSamll = [NSMutableDictionary dictionary];
            [dicSamll setValue:[samll stringForColumn:@"activeTime"] forKey:@"activeTime"];
            [dicSamll setValue:[samll stringForColumn:@"calories"] forKey:@"calories"];
            [dicSamll setValue:[samll stringForColumn:@"distance"] forKey:@"distance"];
            [dicSamll setValue:[samll stringForColumn:@"seris"] forKey:@"seris"];
            [dicSamll setValue:[samll stringForColumn:@"steps"] forKey:@"steps"];
            [stepFragments addObject:dicSamll];
        }
        [dicBig setValue:stepFragments forKey:@"stepFragments"];
        [dataArray addObject:dicBig];
    }
    [db close];
    return dataArray;
}

+(NSMutableArray *)obtainSportDataBig{
    NSMutableArray *array = [NSMutableArray array];
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    NSString *takeCreate = [NSString stringWithFormat:@"SELECT * FROM SportDataBig WHERE user_id = '%@'",[kAPPDELEGATE._loacluserinfo GetUser_ID]];
    FMResultSet *rs = [db executeQuery:takeCreate];
    while ([rs next]) {
        NSMutableDictionary *dicBig = [NSMutableDictionary dictionary];
        [dicBig setValue:[rs stringForColumn:@"caloriesAmount"] forKey:@"caloriesAmount"];
        [dicBig setValue:[rs stringForColumn:@"count"] forKey:@"count"];
        [dicBig setValue:[rs stringForColumn:@"distanceAmount"] forKey:@"distanceAmount"];
        [dicBig setValue:[rs stringForColumn:@"sportDate"] forKey:@"sportDate"];
        [dicBig setValue:[rs stringForColumn:@"stepsAmount"] forKey:@"stepsAmount"];
        [dicBig setValue:[rs stringForColumn:@"timestamp"] forKey:@"timestamp"];
        [array addObject:dicBig];
    }
    [db close];
    return array;
}


+(void)delSportDataTable{
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    NSString *delBig = [NSString stringWithFormat:@"DELETE FROM SportDataBig"];
    NSString *delSmall = [NSString stringWithFormat:@"DELETE FROM SportDataSmall"];
    [db executeUpdate:delBig];
    [db executeUpdate:delSmall];
    [db close];
}

+(void)canlenderUncomfortable{
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    NSString *createTable = @"CREATE TABLE IF NOT EXISTS CanlenderTable (time TEXT PRIMARY KEY,aunt TEXT NOT NULL,loveLove TEXT NOT NULL,habitsAndCustoms TEXT NOT NULL,uncomfortable TEXT NOT NULL,user_id TEXT NOT NULL)";
    [db executeUpdate:createTable];
    [db close];
}
+(void)insterCanlenderData{
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    NSInteger num = 0;
__goto:
    if (num == 0) {
        NSDate *date = [ApplicationStyle whatMonth:[NSDate date] timeDay:num];
        NSInteger dayInt = [ApplicationStyle whatDays:date];
        NSInteger dayMonth = [ApplicationStyle whatMonths:date];
        NSInteger dayYear = [ApplicationStyle whatYears:date];
        
        for (NSInteger i=0; i<dayInt; i++) {
            NSString *inster = @"INSERT OR REPLACE INTO CanlenderTable(time,aunt,loveLove,habitsAndCustoms,uncomfortable,user_id) VALUES (?,?,?,?,?,?)";
            
            NSString *month = nil;
            NSString *days = nil;
            
            if (dayMonth>=10) {//判断个位是否大于两位，如果不是，则补0
                month = [NSString stringWithFormat:@"%ld",(long)dayMonth];
            }else{
                month = [NSString stringWithFormat:@"0%ld",(long)dayMonth];
            }
            
            if (dayInt-i>= 10) {
                days = [NSString stringWithFormat:@"%ld",(long)dayInt-i];
            }else{
                days = [NSString stringWithFormat:@"0%ld",(long)dayInt-i];
            }
            
            
            NSString *times = [NSString stringWithFormat:@"%ld-%@-%@",(long)dayYear,month,days];
            if ([[self canlenderDayData:times] count]==0) {
                NSArray *dataArr = [NSArray arrayWithObjects:
                                    times,
                                    @"0",
                                    @"0",
                                    CommonText_Canlender_habitsAndCustoms,
                                    CommonText_Canlender_uncomfortable,
                                    [kAPPDELEGATE._loacluserinfo GetUser_ID],nil];
                [db executeUpdate:inster withArgumentsInArray:dataArr];
            }
            
            
            if ([[kAPPDELEGATE._loacluserinfo getUserLogInTime] isEqualToString:times]) {
                return;
            }
        }
        
        
        
        num = num -1;
        goto __goto;
    }else{
        NSDate *date = [ApplicationStyle whatMonth:[NSDate date] timeDay:num];
        NSInteger dayCount = [ApplicationStyle totalDaysInMonth:date];
//        NSInteger dayInt = [ApplicationStyle whatDays:date];
        NSInteger dayMonth = [ApplicationStyle whatMonths:date];
        NSInteger dayYear = [ApplicationStyle whatYears:date];
        
        for (NSInteger i=0; i<dayCount; i++) {
            NSString *establishTime = nil;
            
            
            NSString *month = nil;
            NSString *days = nil;
            if (dayMonth>=10) {//判断个位是否大于两位，如果不是，则补0
                month = [NSString stringWithFormat:@"%ld",(long)dayMonth];
            }else{
                month = [NSString stringWithFormat:@"0%ld",(long)dayMonth];
            }
            
            if (dayCount - i < 10) {
                days = [NSString stringWithFormat:@"0%ld",(long)dayCount  - i];
            }else{
                days = [NSString stringWithFormat:@"%ld",(long)dayCount  - i];
            }
            
            establishTime = [NSString stringWithFormat:@"%ld-%@-%@",(long)dayYear,month,days];
            
            
            if ([establishTime isEqualToString:[kAPPDELEGATE._loacluserinfo getUserLogInTime]]) {
                [db close];
                return;
            }
            NSString *inster = @"INSERT OR REPLACE INTO CanlenderTable(time,aunt,loveLove,habitsAndCustoms,uncomfortable,user_id) VALUES (?,?,?,?,?,?)";
            
            
            NSString *times = [NSString stringWithFormat:@"%ld-%@-%@",(long)dayYear,month,days];
            if ([[self canlenderDayData:times] count]==0) {
                NSArray *dataArr = [NSArray arrayWithObjects:
                                    times,
                                    @"0",
                                    @"0",
                                    CommonText_Canlender_habitsAndCustoms,
                                    CommonText_Canlender_uncomfortable,
                                    [kAPPDELEGATE._loacluserinfo GetUser_ID],nil];
                [db executeUpdate:inster withArgumentsInArray:dataArr];
            }
            
            
            if ([[kAPPDELEGATE._loacluserinfo getUserLogInTime] isEqualToString:times]) {
                return;
            }
        }
        
        
        
        
        num = num -1;
        goto __goto;
    }
}

+(void)upDataCanlenderLoveLove:(NSDictionary *)dic{
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    NSString *updateTable = @"UPDATE CanlenderTable SET loveLove = ? WHERE time = ? and user_id = ?";
    [db executeUpdate:
     updateTable,
     [dic objectForKey:@"loveLove"]==nil?@"":[dic objectForKey:@"loveLove"],
     [dic objectForKey:@"time"]==nil?@"":[dic objectForKey:@"time"],
     [kAPPDELEGATE._loacluserinfo GetUser_ID]];
    [db close];
}
+(void)upDataCanlenderhabitsAndCustoms:(NSDictionary *)dic{
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    NSString *updateTable = @"UPDATE CanlenderTable SET habitsAndCustoms = ? WHERE time = ? and user_id = ?";
    [db executeUpdate:
     updateTable,
     [dic objectForKey:@"habitsAndCustoms"]==nil?@"":[dic objectForKey:@"habitsAndCustoms"],
     [dic objectForKey:@"time"]==nil?@"":[dic objectForKey:@"time"],
     [kAPPDELEGATE._loacluserinfo GetUser_ID]];
    [db close];
}
+(void)upDataCanlenderuncomfortable:(NSDictionary *)dic{
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    NSString *updateTable = @"UPDATE CanlenderTable SET uncomfortable = ? WHERE time = ? and user_id = ?";
    [db executeUpdate:
     updateTable,
     [dic objectForKey:@"uncomfortable"]==nil?@"":[dic objectForKey:@"uncomfortable"],
     [dic objectForKey:@"time"]==nil?@"":[dic objectForKey:@"time"],
     [kAPPDELEGATE._loacluserinfo GetUser_ID]];
    [db close];
}


+(NSMutableDictionary *)canlenderDayData:(NSString *)dayTime{
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    NSString *takeCreate = [NSString stringWithFormat:@"SELECT * FROM CanlenderTable WHERE time = '%@' and user_id = '%@'",dayTime,[kAPPDELEGATE._loacluserinfo GetUser_ID]];
    FMResultSet *rs = [db executeQuery:takeCreate];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    while ([rs next]) {
        [dic setValue:[rs stringForColumn:@"time"] forKey:@"time"];
        [dic setValue:[rs stringForColumn:@"habitsAndCustoms"] forKey:@"habitsAndCustoms"];
        [dic setValue:[rs stringForColumn:@"uncomfortable"] forKey:@"uncomfortable"];
    }
    return dic;
    
}


+ (void)sleepDataTable{
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    NSString *createTable = @"CREATE TABLE IF NOT EXISTS SleepData(sleepDate TEXT PRIMARY KEY,endSleep_Time TEXT NOT NULL,total_time TEXT NOT NULL,lightSleep_count TEXT NOT NULL,deepSleep_count TEXT NOT NULL,awake_count TEXT NOT NULL,lightSleep_mins TEXT NOT NULL,deepSleep_mins TEXT NOT NULL,user_id TEXT NOT NULL,timestamp TEXT NOT NULL)";
    [db executeUpdate:createTable];
    [db close];
}

+ (void)insterSleepData:(NSArray *)dataArr isUpdata:(NSInteger)updata{
//    FMDatabase *db = [self sqlDataRoute];
//    [db open];
//    
//    NSDictionary *dic = nil;
//    for (dic in dataArr) {
//        NSString *timesTame = [NSString stringWithFormat:@"%0.0f",[[ApplicationStyle dateTransformationStringWhiffletree:[dic objectForKey:@"sleepDate"]]timeIntervalSince1970]];
//        
//        NSString *inster = @"INSERT OR REPLACE INTO SleepData(sleepDate,endSleep_Time,total_time,lightSleep_count,deepSleep_count,awake_count,lightSleep_mins,deepSleep_mins,user_id,timestamp) VALUES (?,?,?,?,?,?,?,?,?,?)";
//        NSArray *gumentsArr = [NSArray arrayWithObjects:
//                               [dic objectForKey:@"sleepDate"],
//                               [dic objectForKey:@"endSleep_Time"],
//                               [dic objectForKey:@"total_time"],
//                               [dic objectForKey:@"lightSleep_count"],
//                               [dic objectForKey:@"deepSleep_count"],
//                               [dic objectForKey:@"awake_count"],
//                               [dic objectForKey:@"lightSleep_mins"],
//                               [dic objectForKey:@"deepSleep_mins"],
//                               [kAPPDELEGATE._loacluserinfo GetUser_ID],
//                               timesTame,nil];
//        [db executeUpdate:inster withArgumentsInArray:gumentsArr];
//    }
//    [db close];
    
    
    
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    NSInteger num = 0;
__goto:
    if (num == 0) {
        NSDate *date = [ApplicationStyle whatMonth:[NSDate date] timeDay:num];
        NSInteger dayInt = [ApplicationStyle whatDays:date];
        NSInteger dayMonth = [ApplicationStyle whatMonths:date];
        NSInteger dayYear = [ApplicationStyle whatYears:date];
        for (NSInteger i=0; i<dayInt; i++) {
            
            NSString *month = nil;
            NSString *days = nil;
            if (dayMonth>=10) {
                month = [NSString stringWithFormat:@"%ld",(long)dayMonth];
            }else{
                month = [NSString stringWithFormat:@"0%ld",(long)dayMonth];
            }
            
            if (dayInt - i>=10) {
                days = [NSString stringWithFormat:@"%ld",(long)dayInt - i];
            }else{
                days = [NSString stringWithFormat:@"0%ld",(long)dayInt - i];
            }
            NSString *times = [NSString stringWithFormat:@"%ld-%@-%@",(long)dayYear,month,days];
            if ([[self sleepDayData:times] count]==0) {
                NSString *inster = @"INSERT OR REPLACE INTO SleepData(sleepDate,endSleep_Time,total_time,lightSleep_count,deepSleep_count,awake_count,lightSleep_mins,deepSleep_mins,user_id,timestamp) VALUES (?,?,?,?,?,?,?,?,?,?)";
                NSArray *gumentsArr = [NSArray arrayWithObjects:
                                       [NSString stringWithFormat:@"%ld-%@-%@",(long)dayYear,month,days],
                                       @"0",
                                       @"",
                                       @"",
                                       @"",
                                       @"",
                                       @"",
                                       @"",
                                       [kAPPDELEGATE._loacluserinfo GetUser_ID],
                                       @"",nil];
                
                
                [db executeUpdate:inster withArgumentsInArray:gumentsArr];
            }
            
            
            if ([[kAPPDELEGATE._loacluserinfo getUserLogInTime] isEqualToString:[NSString stringWithFormat:@"%ld-%@-%@",(long)dayYear,month,days]]) {
                return;
            }
            
            
        }
        num = num - 1;
        goto __goto;
    }else{
        NSDate *date = [ApplicationStyle whatMonth:[NSDate date] timeDay:num];
        NSInteger dayCount = [ApplicationStyle totalDaysInMonth:date];
        //        NSInteger dayInt = [ApplicationStyle whatDays:date];
        NSInteger dayMonth = [ApplicationStyle whatMonths:date];
        NSInteger dayYear = [ApplicationStyle whatYears:date];
        for (NSInteger i=0; i<dayCount; i++) {
            NSString *establishTime = nil;
            
            NSString *month = nil;
            NSString *days = nil;
            
            if (dayMonth>=10) {
                month = [NSString stringWithFormat:@"%ld",(long)dayMonth];
            }else{
                month = [NSString stringWithFormat:@"0%ld",(long)dayMonth];
            }
            
            if (dayCount  - i >=10) {
                days = [NSString stringWithFormat:@"%ld",(long)dayCount  - i];
            }else{
                days = [NSString stringWithFormat:@"0%ld",(long)dayCount  - i];
            }
            
            
            establishTime = [NSString stringWithFormat:@"%ld-%@-%@",(long)dayYear,month,days];
            
            if ([establishTime isEqualToString:[kAPPDELEGATE._loacluserinfo getUserLogInTime]]) {
                [db close];
                return;
            }
            NSString *times = [NSString stringWithFormat:@"%ld-%@-%@",(long)dayYear,month,days];
            if ([[self sleepDayData:times] count]==0) {
                NSString *inster = @"INSERT OR REPLACE INTO SleepData(sleepDate,endSleep_Time,total_time,lightSleep_count,deepSleep_count,awake_count,lightSleep_mins,deepSleep_mins,user_id,timestamp) VALUES (?,?,?,?,?,?,?,?,?,?)";
                NSArray *gumentsArr = [NSArray arrayWithObjects:
                                       [NSString stringWithFormat:@"%ld-%@-%@",(long)dayYear,month,days],
                                       @"0",
                                       @"",
                                       @"",
                                       @"",
                                       @"",
                                       @"",
                                       @"",
                                       [kAPPDELEGATE._loacluserinfo GetUser_ID],
                                       @"",nil];
                
                
                [db executeUpdate:inster withArgumentsInArray:gumentsArr];
            }
            
            
            if ([[kAPPDELEGATE._loacluserinfo getUserLogInTime] isEqualToString:establishTime]) {
                return;
            }
            
        }
        num = num - 1;
        goto __goto;
    }
}

+(void)upDataSleep:(NSArray *)arr isUpdata:(NSInteger)updata{
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    
    NSLog(@"%@",arr);
    
    NSDictionary *dic = nil;
    for (dic in arr) {
        NSString *updateTable = @"UPDATE SleepData SET endSleep_Time = ?,total_time = ?,lightSleep_count = ?,deepSleep_count = ?,awake_count = ?,lightSleep_mins = ?,deepSleep_mins = ? WHERE sleepDate = ? and user_id = ?";
        [db executeUpdate:
         updateTable,
         [dic objectForKey:@"endSleep_Time"]==nil?@"0":[dic objectForKey:@"endSleep_Time"],
         [dic objectForKey:@"total_time"]==nil?@"0":[dic objectForKey:@"total_time"],
         [dic objectForKey:@"lightSleep_count"]==nil?@"0":[dic objectForKey:@"lightSleep_count"],
         [dic objectForKey:@"deepSleep_count"]==nil?@"0":[dic objectForKey:@"deepSleep_count"],
         [dic objectForKey:@"awake_count"]==nil?@"0":[dic objectForKey:@"awake_count"],
         [dic objectForKey:@"lightSleep_mins"]==nil?@"0":[dic objectForKey:@"lightSleep_mins"],
         [dic objectForKey:@"deepSleep_mins"]==nil?@"0":[dic objectForKey:@"deepSleep_mins"],
         [dic objectForKey:@"sleepDate"]==nil?@"0":[dic objectForKey:@"sleepDate"],
         [kAPPDELEGATE._loacluserinfo GetUser_ID]];
    }
    [db close];
}

+ (NSMutableArray *)sleepDataObtain{
    NSMutableArray *array = [NSMutableArray array];
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    NSString *takeCreate = [NSString stringWithFormat:@"SELECT * FROM SleepData WHERE user_id = '%@'",[kAPPDELEGATE._loacluserinfo GetUser_ID]];
    FMResultSet *rs = [db executeQuery:takeCreate];
    while ([rs next]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:[rs stringForColumn:@"sleepDate"] forKey:@"sleepDate"];
        [dic setValue:[rs stringForColumn:@"endSleep_Time"] forKey:@"endSleep_Time"];
        [dic setValue:[rs stringForColumn:@"total_time"] forKey:@"total_time"];
        [dic setValue:[rs stringForColumn:@"lightSleep_count"] forKey:@"lightSleep_count"];
        [dic setValue:[rs stringForColumn:@"deepSleep_count"] forKey:@"deepSleep_count"];
        [dic setValue:[rs stringForColumn:@"awake_count"] forKey:@"awake_count"];
        [dic setValue:[rs stringForColumn:@"lightSleep_mins"] forKey:@"lightSleep_mins"];
        [dic setValue:[rs stringForColumn:@"deepSleep_mins"] forKey:@"deepSleep_mins"];
        [dic setValue:[rs stringForColumn:@"user_id"] forKey:@"user_id"];
        [dic setValue:[rs stringForColumn:@"timestamp"] forKey:@"timestamp"];
        [array addObject:dic];
    }
    [db close];
    return array;
}

+(NSMutableDictionary *)sleepDayData:(NSString *)dayTime{
    FMDatabase *db = [self sqlDataRoute];
    [db open];
    NSString *takeCreate = [NSString stringWithFormat:@"SELECT * FROM SleepData WHERE sleepDate = '%@' and user_id = '%@'",dayTime,[kAPPDELEGATE._loacluserinfo GetUser_ID]];
    FMResultSet *rs = [db executeQuery:takeCreate];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    while ([rs next]) {
        [dic setValue:[rs stringForColumn:@"endSleep_Time"] forKey:@"endSleep_Time"];
    }
    return dic;
    
}

@end
