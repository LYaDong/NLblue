//
//  NLBluetoothAgreement.h
//  NBlue
//
//  Created by LYD on 15/11/18.
//  Copyright © 2015年 LYD. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
typedef void  (^GetBlueData) (NSString *connect);
typedef void (^Peripheral) (NSArray *perheral);
typedef void (^ConnectionSuccess) (NSString *connectionSuccess);

@interface NLBluetoothAgreement : NSObject
@property(nonatomic,strong)GetBlueData getConnectData;
@property(nonatomic,strong)Peripheral perheral;
@property(nonatomic,strong)ConnectionSuccess getConnectionSuccess;

+(NLBluetoothAgreement *)shareInstance;
-(void)bluetoothAllocInit;


/**
 *UUID 也是通道 0AF6
 */
-(void)writeCharacteristicF6:(CBPeripheral *)peripheral data:(NSData *)data;

/**
 *UUID 也是通道 0AF1
 */
-(void)writeCharacteristicF1:(CBPeripheral *)peripheral data:(NSData *)data;
@end
