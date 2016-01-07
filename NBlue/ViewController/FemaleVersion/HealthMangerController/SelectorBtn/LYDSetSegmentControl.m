//
//  LYDSetSegmentControl.m
//  分段选择Btn
//
//  Created by 刘亚栋 on 15/11/24.
//  Copyright © 2015年 LiuYaDong. All rights reserved.
//

#import "LYDSetSegmentControl.h"
static LYDSetSegmentControl *setSegment = nil;
@implementation LYDSetSegmentControl

+(LYDSetSegmentControl *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        setSegment = [[LYDSetSegmentControl alloc] init];
    });
    return setSegment;
}
@end
