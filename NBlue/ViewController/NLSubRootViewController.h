//
//  SubRootViewController.h
//  NBlue
//
//  Created by LYD on 15/11/23.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLRootViewController.h"

@interface NLSubRootViewController : NLRootViewController
/**
 *常用背景
 */
@property(nonatomic,strong)UIView *navBarBack;
@property(nonatomic,strong)UILabel *titles;
/**
 *有的页面才用
 */
@property(nonatomic,strong)UIView *navBarPushBack;
/**
 *有的页面用 有的不用
 */
@property(nonatomic,strong)UIImageView *controllerBack;
@property(nonatomic,strong)UIButton *returnBtn;
@property(nonatomic,strong)UIButton *rightBtn;


@end
