//
//  ApplicationStyle.h
//  NBlue
//
//  Created by LYD on 15/11/20.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ApplicationStyle : NSObject

@end

@interface ApplicationStyle (Sizes)
/**
 *NavigationBar高度
 */
+ (CGFloat)navigationBarSize;
/**
 *TabBar高度
 */
+ (CGFloat)tabBarSize;
/**
 *状态栏高度
 */
+ (CGFloat)statusBarSize;
/**
 *系统屏幕的宽
 */
+ (CGFloat)screenWidth;
/**
 *系统屏幕的高
 */
+ (CGFloat)screenHeight;
+ (CGFloat)proportion_weight;
+ (CGFloat)Proportion_height;
/**
 *设计图适配的宽
 */
+ (CGFloat)control_weight:(CGFloat)weight;
/**
 *设计图适配的高
 */
+ (CGFloat)control_height:(CGFloat)height;
/**
 *根据文字多少计算文本的Size
 */
+ (CGSize)textSize:(NSString *)text font:(UIFont *)font size:(CGFloat)size;

@end

@interface ApplicationStyle (Fonts)
/**
 *设计图24号字体
 */
+ (UIFont *)textSuperSmallFont;
/**
 *设计图30号字体
 */
+ (UIFont *)textThrityFont;
@end


@interface ApplicationStyle (Colors)
/**
 *红色  //只是目前做个列子  后期需要在多定义
 */
+ (UIColor *)subjectRedColor;
/**
 *主题黑色
 */
+ (UIColor *)subjectBlackColor;
/**
 *主题粉色
 */
+ (UIColor *)subjectPinkColor;
/**
 *主题浅粉色
 */
+ (UIColor *)subjectShowAllPinkColor;
/**
 *navBar的颜色
 */
+ (UIColor *)subJectNavBarColor;
/**
 *主题线的颜色
 */
+ (UIColor *)subjectLineViewColor;
/**
 *自定义线的颜色
 */
+ (UIColor *)SubjectCustomLineColor;
/**
 *常用背景颜色
 */
+ (UIColor *)subjectBackViewColor;
/**
 *常用NavBarBackColor
 */
+ (UIColor *)subjectNavBarBackColor;
/**
 *常用TableCell字体颜色
 */
+ (UIColor *)subjectTableCellLabColor;
/**
 *常用字体白色
 */
+ (UIColor *)subjectWithColor;
/**
 *男版常用蓝色
 */
+ (UIColor *)subjectMaleBlueColor;
/**
 *男版字体常用黑色
 */
+ (UIColor *)subjectMaleTextBlackColor;
/**
 *渐变颜色 //不知道会不会用到 方法先写下来
 */
+ (CAGradientLayer *)shadowAsInverse:(CGRect )frome colorOne:(UIColor *)colorOne colorTow:(UIColor *)colorTow;
@end

@interface ApplicationStyle (BooLs)
/**
 *判断手机格式
 */
+(BOOL)PhoteFormat:(NSString *)phone;
@end

@interface ApplicationStyle (Edition)
/**
 *判断项目Version版本
 */
+(NSString *)theCurrentEditionVersion;
/**
 *判断Build版本
 */
+(NSString *)theCurrnetEditionBuild;
@end

@interface ApplicationStyle (date)
/**
 *计算当月的第一天在周几
 */
+(NSInteger)getWeekofFirstInDate:(NSDate *)date;
/**
 *计算现在是多少年
 */
+(NSInteger)whatYears:(NSDate *)date;
/**
 *计算现在是多少月
 */
+(NSInteger)whatMonths:(NSDate *)date;
/**
 *计算现在是多少日
 */
+(NSInteger)whatDays:(NSDate *)date;
/**
 *计算本月的时间 
 *day 0 是本月 -1 上月 +1 下月 依次计算
 *date 当前的date
 */
+(NSDate*)whatMonth:(NSDate *)date timeDay:(NSInteger)day;
/**
 *一个月有多少天
 */
+(NSInteger)totalDaysInMonth:(NSDate *)date;
/**
 *查看当前日期在周几
 */
+(NSInteger)currentDayWeek:(NSDate *)date;
/**
 *2015年01月01日 格式
 */
+(NSString *)datePickerTransformationTextDate:(NSDate *)date;
/**
 *2015-01-01  格式
 */
+(NSString *)datePickerTransformationCorss:(NSDate *)date;
/**
 *2015.01.01  格式
 */
+(NSString *)datePickerTransformationCorssPoint:(NSDate *)date;
/**
 *01-01 格式
 */
+(NSString *)datePickerTransformationCorssPointMothDay:(NSDate *)date;
/**
 *01.01 格式
 */
+(NSString *)datePickerTransformationCorssCorssMothDay:(NSDate *)date;
/**
 *20150101格式
 */
+(NSString *)datePickerTransformationStr:(NSDate *)date;
/**
 *201512 只有年和月格式
 */
+(NSString *)datePickerTransformationYearAndMonth:(NSDate *)date;
/**
 *字符串转Date   字符串格式   20150101
 */
+(NSDate *)dateTransformationStr:(NSString *)str;
/**
 *字符串转Date   字符串格式   2015-01-01
 */
+(NSDate *)dateTransformationStringWhiffletree:(NSString *)str;
/**
 *时间戳转时间
 */
+(NSString *)timestampTransformationTime:(int64_t)timestamp;
@end


