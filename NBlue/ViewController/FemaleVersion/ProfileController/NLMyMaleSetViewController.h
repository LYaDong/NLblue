//
//  NLMyMaleSetViewController.h
//  NBlue
//
//  Created by LYD on 16/3/18.
//  Copyright © 2016年 LYD. All rights reserved.
//
typedef void (^DelMale) (NSString *delMale);
#import "NLSubRootViewController.h"

@interface NLMyMaleSetViewController : NLSubRootViewController
@property(nonatomic,strong)DelMale delMale;
@property(nonatomic,strong)NSString *maleID;
@end