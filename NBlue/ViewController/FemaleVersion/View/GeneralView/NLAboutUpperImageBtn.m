//
//  NLAboutUpperImageBtn.m
//  NBlue
//
//  Created by LYD on 16/3/7.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLAboutUpperImageBtn.h"
#define contenimgSS [ApplicationStyle control_weight:89]*0.8
#define contentTitleSS contentRect.size.height*0.7
@implementation NLAboutUpperImageBtn
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.numberOfLines = 0;
    }
    return self;
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, [ApplicationStyle control_height:80+18], contentRect.size.width, [ApplicationStyle control_height:40]);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake((self.frame.size.width - [ApplicationStyle control_weight:80])/2, [ApplicationStyle control_height:10], [ApplicationStyle control_weight:80], [ApplicationStyle control_height:80]);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
