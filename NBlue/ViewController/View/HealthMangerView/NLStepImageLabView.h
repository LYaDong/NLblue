//
//  NLStepImageLab.h
//  NBlue
//
//  Created by LYD on 15/12/1.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLStepImageLabView : UIView
- (instancetype)initWithImage:(UIImage *)images
                     textFont:(UIFont *)textFont
                    textColor:(UIColor *)textColor
                   textRemark:(NSString *)textRemark
                      textNum:(NSString *)textNum
                        frame:(CGRect)frame;
@end
