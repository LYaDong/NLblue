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
@interface NLStepCountLabView : UIView

-(instancetype)initWithFrame:(CGRect)frame type:(NSInteger)type remarkLabText:(NSString *)reamrkLab dataLabText:(NSString *)dataLabText;
@end
