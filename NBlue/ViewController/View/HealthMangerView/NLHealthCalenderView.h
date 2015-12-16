//
//  NLHealthCalenderView.h
//  NBlue
//
//  Created by LYD on 15/11/24.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,PlayLove) {
    PlayLove_MYZ                = 0,                                    //没有做
    PlayLove_DTZ                = 1,                                    //带套做
    PlayLove_CLYSH              = 2,                                    //吃了药事后
    PlayLove_WBHCS              = 3,                                    //无保护措施
    PlayLove_QC                 = 10,                                   //清除
};
@interface NLHealthCalenderView : UIView
@end
