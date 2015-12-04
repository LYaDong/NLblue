//
//  NLIndividuaEditingViewController.h
//  NBlue
//
//  Created by LYD on 15/11/26.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLSubRootViewController.h"
typedef void (^UserName) (NSString *name);
@interface NLIndividuaEditingViewController : NLSubRootViewController
@property(nonatomic,strong)UserName editionName;
@property(nonatomic,strong)NSString *userName;
@end
