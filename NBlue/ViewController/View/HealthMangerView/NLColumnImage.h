//
//  NLColumnImage.h
//  NBlue
//
//  Created by LYD on 15/12/1.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger,NLCalendarType) {
    NLCalendarType_Day = 0,                                 //已天为单位
    NLCalendarType_Week = 1,                                //已星期为单位
    NLCalendarType_Month = 2,                               //已月为单位
    NLCalendarType_Ordinary = 3,                            //普通格式
};

@interface NLColumnImage : UIView




- (instancetype)initWithDataArr:(NSArray *)arr
                    strokeColor:(UIColor *)strokeColor
                      withColor:(UIColor *)withColor
                           type:(NSInteger)type
                     timeLabArr:(NSArray *)labTimeArr;
@end
