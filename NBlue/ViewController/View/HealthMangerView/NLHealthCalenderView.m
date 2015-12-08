//
//  NLHealthCalenderView.m
//  NBlue
//
//  Created by LYD on 15/11/24.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLHealthCalenderView.h"
#import "NLCalenderPackage.h"
@implementation NLHealthCalenderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor yellowColor];
        [self bulidUI];
    }
    return self;
}

#pragma mark 基础UI
-(void)bulidUI{
    NLCalenderPackage *view = [[NLCalenderPackage alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:509])];
    [self addSubview:view];
}
#pragma mark 系统Delegate
#pragma mark 自己的Delegate
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
