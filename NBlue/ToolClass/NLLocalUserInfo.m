//
//  NLLocalUserInfo.m
//  NBlue
//
//  Created by LYD on 15/11/27.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLLocalUserInfo.h"

@implementation NLLocalUserInfo
-(void)setBluetoothName:(NSString *)bluetoothName{
    [[NSUserDefaults standardUserDefaults] setObject:bluetoothName forKey:@"NL_Project_bluetoothName"];
    [NSUserDefaults standardUserDefaults];
}
-(NSString *)getBluetoothName{
    NSString *infoType = [[NSUserDefaults standardUserDefaults] stringForKey:@"NL_Project_bluetoothName"];
    return infoType;
}
@end
