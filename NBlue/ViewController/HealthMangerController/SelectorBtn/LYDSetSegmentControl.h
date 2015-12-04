//
//  LYDSetSegmentControl.h
//  分段选择Btn
//
//  Created by 刘亚栋 on 15/11/24.
//  Copyright © 2015年 LiuYaDong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LYDSetSegmentControl : NSObject
+(LYDSetSegmentControl *)shareInstance;
/**
 *控制器的圆形幅度
 */
@property(nonatomic,assign)CGFloat cornerRedius;
/**
 *控制器线的颜色
 */
@property(nonatomic,strong)UIColor *borderColors;
/**
 *控制器线的粗细
 */
@property(nonatomic,assign)CGFloat borderWidth;
/**
 *控制器的选中颜色
 */
@property(nonatomic,strong)UIColor *backGroupColor;
/**
 *控制器是否切掉圆角
 */
@property(nonatomic,assign)BOOL clipsBounds;
/**
 *控制器的内容
 */
@property(nonatomic,strong)NSArray *titleArray;
/**
 *控制器的初始位置
 */
@property(nonatomic,assign)NSInteger selectedSegmentIndex;
/**
 *控制器里面的文字颜色
 */
@property(nonatomic,strong)UIColor *titleColor;
/**
 *控制器里面的文字的大小
 */
@property(nonatomic,strong)UIFont *titleFont;

@end
