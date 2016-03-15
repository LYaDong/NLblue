//
//  SubRootViewController.h
//  NBlue
//
//  Created by LYD on 15/11/23.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLRootViewController.h"

@interface NLSubRootViewController : NLRootViewController
//==========================================
//-------------------女版-------------------
//==========================================
/**
 * NabBar常用背景
 */
@property(nonatomic,strong)UIView *navBarBack;
@property(nonatomic,strong)UILabel *titles;

/**
 *有的页面用 有的不用
 */
@property(nonatomic,strong)UIButton *returnBtn;
@property(nonatomic,strong)UIButton *rightBtn;





//==========================================
//-------------------男版-------------------
//==========================================
/**
 *男版NabBar背景颜色
 */
@property(nonatomic,strong)UIView *navBarMaleBack;




@end
