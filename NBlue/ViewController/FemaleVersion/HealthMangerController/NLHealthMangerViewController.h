//
//  HealthMangerViewController.h
//  NBlue
//
//  Created by LYD on 15/11/23.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLSubRootViewController.h"

typedef NS_ENUM(NSUInteger,NLHealthManger) {
    NLHealthManger_Calender = 0,//日历的View
    NLHealthManger_Sleep = 1,//睡眠的View
    NLHealthManger_StepNumber = 2,//记步的NUmber
};
typedef NS_ENUM(NSUInteger,NLHealthMangerController) {
    NLHealthMangerController_Sleep = 1,       //需要跳转的页面VC  Sleep
    NLHealthMangerController_Step = 2,        //需要跳转的页面VC  Step
};

@interface NLHealthMangerViewController : NLSubRootViewController

@end
