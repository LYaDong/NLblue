//
//  NLEquipmentCommand.h
//  NBlue
//
//  Created by LYD on 15/11/27.
//  Copyright © 2015年 LYD. All rights reserved.
//

#ifndef NLEquipmentCommand_h
#define NLEquipmentCommand_h
//************************************ 蓝牙 ***********************************
//开始传输数据
#define EquiomentCommandStart @"0801000000000000"
//结束运动数据传输
#define EquiomentCommandEndSportBlue @"08ee000000"
//结束睡眠数据传输
#define EquiomentCommandEndSleepBlue @"08ee020000"
#define EquiomentConnectionSuccess @"连接成功"
#define EquiomentConnectionFiale @"断开连接"
#define EquiomentStartHedting @"开始加热"

#define EquiomentCommand_0201 @"0201"
#define EquiomentCommand_9004 @"9004"
#define EquiomentCommand_0901 @"0901"
#define EquiomentCommand_0803 @"0803"
#define EquiomentCommand_0804 @"0804"
#define EquiomentCommand_9001 @"9001"
#define EquiomentCommand_9002 @"9002"
#define EquiomentCommand_9004 @"9004"
#define EquiomentCommand_0204 @"0204"

//************************************ 蓝牙 ***********************************


//************************************ 常用 ***********************************
#define CommonText_Canlender_habitsAndCustoms @"0.0.0"
#define CommonText_Canlender_uncomfortable @"0.0.0.0.0.0.0.0.0.0.0.0"
#define EquiomentRefresh @"刷新数据中，请耐心等待~~"
#define NLSearchBluetoothNotification @"NLSearchBluetoothNotification"
#define NLSearchBluetoothStartNotification @"NLSearchBluetoothStartNotification"//开始搜索蓝牙
#define NLSearchBluetoothStopNotification @"NLSearchBluetoothStopNotification"//停止搜索蓝牙


//************************************ 常用 ***********************************

#endif /* NLEquipmentCommand_h */
