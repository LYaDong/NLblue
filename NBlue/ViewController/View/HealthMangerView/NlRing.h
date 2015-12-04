//
//  NlRing.h
//  NBlue
//
//  Created by LYD on 15/12/1.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLRing : NSObject
/**
 *画多少个块
 */
@property(nonatomic,assign)NSInteger lineIndex;
/**
 *底色
 */
@property(nonatomic,strong)UIColor *backColors;
/**
 *覆盖的颜色
 */
@property(nonatomic,strong)UIColor *coverColor;
/**
 *线的宽度
 */
@property(nonatomic,assign)float lineWidth;
/**
 *圈的大小
 */
@property(nonatomic,assign)float  radius;
/**
 *已画多少个
 */
@property(nonatomic,assign)NSInteger progressCounter;
@end
