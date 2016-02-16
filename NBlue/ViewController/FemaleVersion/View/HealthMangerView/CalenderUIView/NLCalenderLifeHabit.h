//
//  NLCalenderLifeHabit.h
//  NBlue
//
//  Created by LYD on 15/12/16.
//  Copyright © 2015年 LYD. All rights reserved.
//
typedef NS_ENUM(NSUInteger,LifeHabit) {
    LifeHabit_SG = 0,                                           //水果
    LifeHabit_YD = 1,                                           //运动
    LifeHabit_PB = 2,                                           //排便
    LifeHabit_QC = 10,                                          //清除
};
@protocol NLCalenderLifeHabitDelegate <NSObject>
-(void)lifeHabitCount:(NSArray *)array;
@end

#import <UIKit/UIKit.h>

@interface NLCalenderLifeHabit : UIView
@property(nonatomic,strong)id<NLCalenderLifeHabitDelegate>delegate;
-(void)buildUI;
@property(nonatomic,strong)NSString *commonTime;
@end
