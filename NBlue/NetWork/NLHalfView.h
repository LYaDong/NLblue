//
//  NLHalfView.h
//  NBlue
//
//  Created by LYD on 15/12/4.
//  Copyright © 2015年 LYD. All rights reserved.
//


@protocol NLHalfViewDelgate <NSObject>
/**
 *滑动到多少个
 */
-(void)index:(NSInteger)index;

@end

#import <UIKit/UIKit.h>
@interface NLHalfView : UIView
@property(nonatomic,assign)id<NLHalfViewDelgate>delegate;
-(instancetype)initWithFrame:(CGRect)frame
                         num:(NSInteger)num
                       index:(NSInteger) index
                      redius:(CGFloat)redius
                       width:(NSInteger)width
                   starColor:(UIColor *)starColor
                    endColor:(UIColor *)endColor;
@end
