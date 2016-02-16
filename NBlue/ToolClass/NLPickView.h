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
    PickerType_RemindSection = 3,                                   //提醒区间
    PickerType_Cycle = 4,                                           //周期
    PickerType_Period = 5,                                          //经期
};
typedef NS_ENUM(int64_t,DatePickerType) {//时间格式
    DatePickerType_YearMothDay = 0,                                 //年月日格式
    DatePickerType_WhenBranchSeconds = 1,                           //时分秒格式
};
typedef NS_ENUM(int64_t,UseDatePicker) {//谁用到这个时间控件
    UseDatePicker_Cycle = 0,                                        //周期
    UseDatePicker_Period = 1,                                       //经期
    UseDatePicker_UpNext = 2,                                       //上一次来的时间
};

typedef NS_ENUM(int64_t,SeleType) {
    SeleType_Cancel = 0,                            //取消
    SeleType_OK     = 1,                            //确定
};
@protocol NLPickViewDelegate <NSObject>

/**
 * picker 展示
 */
- (void)pickerCount:(NSString *)count seleType:(NSInteger)type pickerType:(NSInteger)pickType;
/**
 * 系统的PickerDate 展示
 */
- (void)datePicker:(NSDate *)date cancel:(NSInteger)cancelType useDatePicker:(NSInteger)useDatePicker;
/**
 * 多个Picker的展示
 */
- (void)multiplePickerDateArray:(NSArray *)array num:(NSUInteger)num type:(NSInteger)pickerDateType;

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
/**
 * 多个PickerDate
 */
- (instancetype)initWithMultiplePickerDateArray:(NSArray *)array num:(NSUInteger)num type:(NSInteger)pickerDateType;
@end
