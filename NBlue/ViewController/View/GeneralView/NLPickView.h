//
//  NLPickView.h
//  NBlue
//
//  Created by LYD on 15/11/26.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(int64_t,PickerType) {//谁用到这个pickerView
    PickerType_Age = 0,                                             //年龄
    PickerType_Height = 1,                                          //身高
    PickerType_Width = 2,                                           //体重
};
typedef NS_ENUM(int64_t,DatePickerType) {//时间格式
    DatePickerType_YearMothDay = 0,                                 //年月日格式
    DatePickerType_WhenBranchSeconds = 1,                           //时分秒格式
};
typedef NS_ENUM(int64_t,UseDatePicker) {//谁用到这个时间控件
    UseDatePicker_Cycle = 0,                                        //周期
    UseDatePicker_Period = 1,                                       //经期
};
@protocol NLPickViewDelegate <NSObject>

- (void)pickerCount:(NSString *)count seleType:(NSInteger)type pickerType:(NSInteger)pickType;
- (void)datePicker:(NSDate *)date cancel:(NSInteger)cancelType useDatePicker:(NSInteger)useDatePicker;

@end
@interface NLPickView : UIView
@property(nonatomic,assign)id <NLPickViewDelegate>delegate;
/**
 *PickerView
 */
- (instancetype)initWithPickTye:(NSInteger)picktype;
/**
 *DatePicker
 */
- (instancetype)initWithDateStyleType:(NSInteger)dateStyleType useDatePicker:(NSInteger)useDatePicker;
@end
