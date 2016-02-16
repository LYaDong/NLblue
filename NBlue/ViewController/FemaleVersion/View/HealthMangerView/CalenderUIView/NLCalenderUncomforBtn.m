//
//  NLCalenderUncomforBtn.m
//  NBlue
//
//  Created by LYD on 15/12/16.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLCalenderUncomforBtn.h"

@implementation NLCalenderUncomforBtn
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeLeft;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake([ApplicationStyle control_weight:5], 0, contentRect.size.width, contentRect.size.height);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake([ApplicationStyle control_weight:5], 0, contentRect.size.width, contentRect.size.height);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
