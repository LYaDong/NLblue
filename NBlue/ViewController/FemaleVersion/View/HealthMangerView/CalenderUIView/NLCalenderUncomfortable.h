//
//  NLCalenderUncomfortable.h
//  NBlue
//
//  Created by LYD on 15/12/16.
//  Copyright © 2015年 LYD. All rights reserved.
//

typedef NS_ENUM(NSUInteger,Uncomfortable) {
    Uncomfortable_TT = 0,                                               //头疼
    Uncomfortable_BD = 1,                                               //爆豆
    Uncomfortable_HELY = 2,                                             //喝了冷饮
    Uncomfortable_FX = 3,                                               //腹泻
    Uncomfortable_XFZT = 4,                                             //小腹坠痛
    Uncomfortable_MSY = 5,                                              //没食欲
    Uncomfortable_YS = 6,                                               //腰酸
    Uncomfortable_HSST = 7,                                             //浑身酸痛
    Uncomfortable_RFZT = 8,                                             //乳房胀痛
    Uncomfortable_RFCT = 9,                                             //乳房刺痛
    Uncomfortable_BDYC = 10,                                            //白带异常
    Uncomfortable_QT = 11,                                              //其他
    Uncomfortable_QC = 100,                                             //清除
};
@protocol NLCalenderUncomfortableDelegate <NSObject>

-(void)uncomfortableArr:(NSArray *)array;

@end
#import <UIKit/UIKit.h>

@interface NLCalenderUncomfortable : UIView
@property(nonatomic,strong)id<NLCalenderUncomfortableDelegate>delegate;
-(void)buildUI;
@property(nonatomic,strong)NSString *commonTime;
@end
