//
//  NLStepCountLabView.h
//  NBlue
//
//  Created by LYD on 15/12/3.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,LabTextType) {
    LabTextType_DayStepNum = 0,
    LabTextType_DayDistance = 1,
    LabTextType_DayEnergy = 2,
    LabTextType_DayActovity = 3,
};
typedef NS_ENUM(NSUInteger,SlppeLabTextType) {
    SlppeLabTextType_FallAsleepTime = 0,
    SlppeLabTextType_WakeupTime = 1,
    SlppeLabTextType_SleepTime = 2,
    SlppeLabTextType_ShallowSleepTime = 3,
    SlppeLabTextType_DeepSleepTime = 4,
    SlppeLabTextType_SleepQualityTime = 5,
};
@interface NLStepCountLabView : UIView

-(instancetype)initWithFrame:(CGRect)frame type:(NSInteger)type remarkLabText:(NSString *)reamrkLab dataLabText:(NSString *)dataLabText;
@end
