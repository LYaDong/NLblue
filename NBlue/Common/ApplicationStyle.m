//
//  ApplicationStyle.m
//  NBlue
//
//  Created by LYD on 15/11/20.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "ApplicationStyle.h"
#import <UIKit/UIKit.h>
@implementation ApplicationStyle


@end

@implementation ApplicationStyle (Sizes)

+ (CGFloat)navigationBarSize{
    UINavigationController *nav = [[UINavigationController alloc] init];
    NSInteger  rectNav = nav.navigationBar.frame.size.height;
    return rectNav;
}
+ (CGFloat)tabBarSize{
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    NSInteger tab =  tabBarController.tabBar.frame.size.height;
    return tab;
}
+ (CGFloat)statusBarSize{
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    return rectStatus.size.height;
}
+ (CGFloat)navBarAndStatusBarSize{
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    NSInteger tab =  tabBarController.tabBar.frame.size.height;
    return tab+rectStatus.size.height;
}
+ (CGFloat)screenWidth {return [UIScreen mainScreen].bounds.size.width;}

+ (CGFloat)screenHeight {return [UIScreen mainScreen].bounds.size.height;}

+ (CGFloat)proportion_weight{return [self screenWidth]/640;}

+ (CGFloat)Proportion_height{return [self screenHeight]/1136;}

+ (CGFloat)control_weight:(CGFloat)weight{return weight * [self proportion_weight];}

+ (CGFloat)control_height:(CGFloat)height{return height * [self Proportion_height];}
+ (CGSize)textSize:(NSString *)text font:(UIFont *)font size:(CGFloat)size{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize questionSize = [text boundingRectWithSize:CGSizeMake(size, MAXFLOAT)  options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return questionSize;
}

@end

@implementation ApplicationStyle (Fonts)

+ (UIFont *)textSuperSmallFont{return [UIFont systemFontOfSize:[self control_weight:24]];}
+ (UIFont *)textThrityFont{return [UIFont systemFontOfSize:[self control_weight:30]];}
+ (UIFont *)textTwentySixFont{return [UIFont systemFontOfSize:[self control_weight:26]];}
@end

@implementation ApplicationStyle (Colors)
+ (UIColor *)subjectRedColor{return [@"ff0000" hexStringToColor];}
+ (UIColor *)subjectBlackColor{return [UIColor blackColor];}
+ (UIColor *)subjectPinkColor{return [@"f12e56" hexStringToColor];}
+ (UIColor *)subjectShowAllPinkColor{return [@"fe4e7c" hexStringToColor];}
+ (UIColor *)subJectNavBarColor{return [@"ff8aa9" hexStringToColor];}
+ (UIColor *)subjectLineViewColor{return [@"f5d6d6" hexStringToColor];}
+ (UIColor *)SubjectCustomLineColor{return [@"dedede" hexStringToColor];}
+ (UIColor *)subjectBackViewColor{return [@"f1ebeb" hexStringToColor];}
+ (UIColor *)subjectNavBarBackColor{return [@"fb4d7e" hexStringToColor];}
+ (UIColor *)subjectTableCellLabColor{return [@"1b1b1b" hexStringToColor];}
+ (UIColor *)subjectWithColor{return [@"ffffff" hexStringToColor];}
+ (UIColor *)subjectMaleBlueColor{return [@"56cbf9" hexStringToColor];}
+ (UIColor *)subjectMaleBackColor{return [@"fffeeb" hexStringToColor];}


//渐变颜色
+ (UIColor *)customColor:(NSString *)color{ return [color hexStringToColor];}
+ (CAGradientLayer *)shadowAsInverse:(CGRect )frome colorOne:(UIColor *)colorOne colorTow:(UIColor *)colorTow{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    newShadow.frame = frome;
    newShadow.colors = [NSArray arrayWithObjects:(id)colorOne.CGColor,(id)colorTow.CGColor,nil];
    return newShadow;
}




@end

@implementation ApplicationStyle (BooLs)

+(BOOL)PhoteFormat:(NSString *)phone{
    NSString *phoneFormat = @"\\b(1)[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]\\b";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneFormat];
    BOOL isMatch = [pred evaluateWithObject:phone];
    return isMatch;
    return YES;
}
@end

@implementation ApplicationStyle (Edition)

+(NSString *)theCurrentEditionVersion{
    return  [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
}
+(NSString *)theCurrnetEditionBuild{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (void)jumpAppStoreScore{[[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_Story_URL]];}
@end

@implementation ApplicationStyle (date)
/**
 *计算当月的第一天在周几
 */
+(NSInteger)getWeekofFirstInDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [components setDay:1];
    NSDate *firstDate = [calendar dateFromComponents:components];
    NSDateComponents *firstComponents = [calendar components:NSCalendarUnitWeekday fromDate:firstDate];
    return firstComponents.weekday - 1;
}
/**
 *计算现在是多少年
 */
+(NSInteger)whatYears:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    return [components year];
}
/**
 *计算现在是多少月
 */
+(NSInteger)whatMonths:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    return [components month];
}
/**
 *计算现在是多少日
 */
+(NSInteger)whatDays:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    return [components day];
}
/**
 *计算本月的时间
 */
+(NSDate*)whatMonth:(NSDate *)date timeDay:(NSInteger)day{
    /*
     * day + 0                                  当月时间
     * day + 1                                  下个月时间
     * day - 1                                  上个月时间
     */
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = + day;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}
/**
 *一个月有多少天
 */
+(NSInteger)totalDaysInMonth:(NSDate *)date{
    NSRange daysInOnMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOnMonth.length;
}
/**
 *查看当前日期在周几
 */
+(NSInteger)currentDayWeek:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond;

    comps = [calendar components:unitFlags fromDate:date];
    return [comps weekday];
}



+(NSString *)datePickerTransformationTextDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *formatDate = [formatter stringFromDate:date];
    return formatDate;
}
+(NSString *)datePickerTransformationCorss:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *formatDate = [formatter stringFromDate:date];
    return formatDate;
}
+(NSString *)datePickerTransformationCorssPoint:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *formatDate = [formatter stringFromDate:date];
    return formatDate;
}

+(NSString *)datePickerTransformationCorssPointMothDay:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    NSString *formatDate = [formatter stringFromDate:date];
    return formatDate;
}
+(NSString *)datePickerTransformationCorssCorssMothDay:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM.dd"];
    NSString *formatDate = [formatter stringFromDate:date];
    return formatDate;
}
+(NSString *)datePickerTransformationStr:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *formatDate = [formatter stringFromDate:date];
    return formatDate;
}
+(NSString *)datePickerTransformationYearAndMonth:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMM"];
    NSString *formatDate = [formatter stringFromDate:date];
    return formatDate;
}
+(NSDate *)dateTransformationStr:(NSString *)str{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *inputDate = [inputFormatter dateFromString:str];
    return inputDate;
}
+(NSDate *)dateTransformationStringWhiffletree:(NSString *)str{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *inputDate = [inputFormatter dateFromString:str];
    return inputDate;
}

+(NSString *)timestampTransformationTime:(int64_t)timestamp{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    return [dateFormatter stringFromDate:date];
}
@end

@implementation ApplicationStyle (UIImages)
+ (CIImage *)createQRForString:(NSString *)qrString{
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // Send the image back
    return qrFilter.outputImage;
}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // create a bitmap image that we'll draw into a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}
+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // traverse pixe
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
            // change color
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // context to image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // release
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

@end
