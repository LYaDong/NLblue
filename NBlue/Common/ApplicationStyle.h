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
 *navBar+StatusBar 的高度
 */
+ (CGFloat)navBarAndStatusBarSize;
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
/**
 *等比例 屏幕大小压缩图片
 * @param  image  图片
 */
+ (CGSize)compressImageSize:(UIImage *)image;

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
/**
 *设计图26号字体
 */
+ (UIFont *)textTwentySixFont;
@end


@interface ApplicationStyle (Colors)

/**
 *红色  //只是目前做个列子  后期需要在多定义
 */
+ (UIColor *)subjectRedColor;
/**
 * 整体TabBar背景
 */
+ (UIColor *)CodeBackColor;
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
 * 男版背景颜色
 */
+ (UIColor *)subjectMaleBackColor;
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
/**
 * 返回是什么手机
 */
+(NSString *)Judgingdevice;
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
/**
 *跳转到AppStory评分
 */
+ (void)jumpAppStoreScore;
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
 *2015-01-01-00-00-00
 */
+(NSString *)datePickerTransformationYearDate:(NSDate *)date;
/**
 *2015年01月01日 格式
 */
+(NSString *)datePickerTransformationTextDate:(NSDate *)date;
/**
 *2015-01-01  格式
 */
+(NSString *)datePickerTransformationCorss:(NSDate *)date;
/**
 * 2015-01  格式：只有年和月
 */
+(NSString *)datePickerTransformationYearOrMonth:(NSDate *)date;

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
 * 12/23  11:11 格式
 */
+(NSString *)datePickerTransformationVacancyTime:(NSInteger)time;
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
/**
 * 时间大小比较
 *   1                      大于比较的时间
 *  -1                      小于比较的时间
 *   0                      等于比较的时间
 */
+(NSInteger)dateCompareDateCurrentDate:(NSDate *)currentDate afferentDate:(NSDate *)fiierentDate;
/**
 * currentDate 你想重什么时候开始的天数  afferentDate 要比较的天数
 */
+(NSInteger)dateInteverCurrentDate:(NSDate *)currentDate afferentDate:(NSDate *)afferentDate;

@end

@interface ApplicationStyle (UIImages)
/**
 *生成二维码
 */
+ (CIImage *)createQRForString:(NSString *)qrString;
/**
 *把CIImage转成Image
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;
/**
 * 修改二维码颜色 待优化
 */
+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;
/**
 *压缩图片
 * @param  image  要压缩的图片
 * @param  size 要压缩的尺寸
 */
+ (UIImage *)compressFinishIsImages:(UIImage *)image scaledToSize:(CGSize)size;
/**
 * 创建毛玻璃
 * @param  imageView  要做图片的毛玻璃
 */
+ (UIVisualEffectView *)woolGlassEatablishImage:(UIImageView *)imageView;
@end

@interface ApplicationStyle (NSArrays)
/**
 * 截取字符串
 * @param text 内容
 * @param interceptCharacter 要截取的字符串
 */
+ (NSArray *)interceptText:(NSString *)text interceptCharacter:(NSString *)interceptCharacter;
/**
 * 转换字符为十六进制，在转为byte
 * @param str 要转换的字符  一定要等于两位字符，否则补足
 */
+ (Byte)byteTransformationTextSixteenByteStr:(NSString *)str;
/**
 * 字符串拼接
 * @param strArr 要拆开拼接的字符串
 * @param mosiacSymbolStr 要连接在一起的字符
 * @param index 每次重第几个开始
 */
+ (NSMutableString *)stringMosiac:(NSString *)strArr mosiacSymbolStr:(NSString *)mosiacSybolStr index:(NSInteger)index;
/**
 * 字典转JSON
 */
+ (NSString *)jsonDataTransString:(NSDictionary *)dic;
@end
