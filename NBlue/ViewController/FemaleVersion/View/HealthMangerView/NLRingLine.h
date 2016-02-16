//
//  NLRingLine.h
//  NBlue
//
//  Created by LYD on 15/12/1.
//  Copyright © 2015年 LYD. All rights reserved.
//

typedef NS_ENUM(NSInteger,NLRingType) {
    NLRingType_SimpleCircle = 0,
    NLRingType_separateCircle = 1,
};

#import <UIKit/UIKit.h>
#import "NLRing.h"
@interface NLRingLine : UIView
-(instancetype)initWithRing:(NLRing *)ring frame:(CGRect)frame;
@end
