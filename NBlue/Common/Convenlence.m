//
//  Convenlence.m
//  NBlue
//
//  Created by LYD on 15/11/20.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "Convenlence.h"

@implementation UIView (Convenience)

- (CGFloat)viewHeight{return self.frame.size.height;}
- (CGFloat)leftSidePosition{return self.frame.origin.x;}
- (CGFloat)topPosition{return self.frame.origin.y;}
- (CGFloat)rightSideOffset{return self.frame.origin.x + self.frame.size.width;}
- (CGFloat)bottomOffset{return self.frame.origin.y + self.frame.size.height;}
- (CGFloat)viewWidth{return self.frame.size.width;}

+ (UIView *)statusBackView:(CGRect)frame{
    UIView *statusView = [[UIView alloc] initWithFrame:frame];
    [statusView.layer addSublayer:[ApplicationStyle shadowAsInverse:CGRectMake(0, 0, frame.size.width, frame.size.height) colorOne:[@"a60034" hexStringToColor] colorTow:[@"ffffff" hexStringToColor]]];
    return statusView;
}
+ (UIButton *)gradiengBtnFrame:(CGRect)frame{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = frame;
    [btn.layer addSublayer:[ApplicationStyle shadowAsInverse:CGRectMake(0, 0, frame.size.width, frame.size.height) colorOne:[@"dc2849" hexStringToColor] colorTow:[@"e9395a" hexStringToColor]]];
    return btn;
}

@end

@implementation NSString (Convenience)

- (UIColor *)hexStringToColor
{
    return [self hexStringToColorWithAlpha:1.0f];
}

- (UIColor *)hexStringToColorWithAlpha: (CGFloat)alpha{
    
    NSString *cString = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}
@end





