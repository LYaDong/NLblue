//
//  NLTextImageView.h
//  NBlue
//
//  Created by LYD on 16/1/20.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NLTextImageView : UIView
/**
 *图片在前或者view在前的Init
 *
 * @param frame 坐标
 * @param color 颜色
 * @param imageArr  放图片或者View
 * @param font 字体大小
 * @param textColor 字体颜色
 * @param text 文本
 * @param type 类别 判断图片位置是左还是右   //暂时没用到
 */
- (instancetype)initWithFrame:(CGRect)frame
                        color:(UIColor *)color
                        image:(UIImage *)image
                         font:(UIFont *)font
                    textColor:(UIColor *)textColor
                         text:(NSString *)text
                         type:(NSInteger)type;
@end
