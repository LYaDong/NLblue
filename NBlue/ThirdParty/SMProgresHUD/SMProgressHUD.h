//
//  SMProgressHUD.h
//  SMProgressHUD
//
//  Created by OrangeLife on 15/10/9.
//  Copyright (c) 2015年 Shenme Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMProgressHUDTipView.h"

@interface SMProgressHUD : NSObject
+(instancetype)shareInstancetype;


- (void)showLoading;
- (void)showLoadingWithTip:(NSString *)tip;
- (void)showTip:(NSString*)tip;
- (void)showErrorTip:(NSString *)tip;
- (void)showWarningTip:(NSString *)tip;
- (void)showDoneTip:(NSString *)tip;
- (void)showTip:(NSString *)tip type:(SMProgressHUDTipType)type completion:(void (^)(void))completion;


- (void)dismiss;
- (void)dismissLoadingView;
- (void)dismissAlertView;
- (void)dismissActionSheet;
@end