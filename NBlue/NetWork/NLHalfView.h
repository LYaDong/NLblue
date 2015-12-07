//
//  NLHalfView.h
//  NBlue
//
//  Created by LYD on 15/12/4.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLHalfView : UIView
-(instancetype)initWithFrame:(CGRect)frame
                         num:(NSInteger)num
                       index:(NSInteger) index
                      redius:(CGFloat)redius
                       width:(NSInteger)width
                   starColor:(UIColor *)starColor
                    endColor:(UIColor *)endColor;




@property(nonatomic,assign)NSUInteger progressCount;

@end
