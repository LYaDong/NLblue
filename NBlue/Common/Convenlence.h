//
//  Convenlence.h
//  NBlue
//
//  Created by LYD on 15/11/20.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (Convenience)
/**
 *self.frame.size.height
 */
- (CGFloat)viewHeight;
/**
 *self.frame.origin.x
 */
- (CGFloat)leftSidePosition;
/**
 *self.frame.origin.y
 */
- (CGFloat)topPosition;
/**
 *self.frame.origin.x + self.frame.size.width
 */
- (CGFloat)rightSideOffset;
/**
 *self.frame.origin.y + self.frame.size.height
 */
- (CGFloat)bottomOffset;
/**
 *self.frame.size.width
 */
- (CGFloat)viewWidth;
/**
 *渐变描边
 */
+ (UIView *)statusBackView:(CGRect)frame;
/**
 *渐变Btn
 */
+ (UIButton *)gradiengBtnFrame:(CGRect)frame;
@end

@interface NSString (Convenience)

- (UIColor *)hexStringToColor;

- (UIColor *)hexStringToColorWithAlpha: (CGFloat)alpha;

@end



