//
//  NLShareView.m
//  NBlue
//
//  Created by LYD on 16/3/7.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLShareView.h"
#import "NLAboutUpperImageBtn.h"
@implementation NLShareView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}
-(void)buildUI{
    
    
    UIView *viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:297])];
    viewBack.backgroundColor = [ApplicationStyle subjectWithColor];
    [self addSubview:viewBack];
    
    NSArray *shareText = @[NSLocalizedString(@"NL_Share_WechatFriend", nil),
                           NSLocalizedString(@"NL_Share_WechatCircle", nil),
                           NSLocalizedString(@"NL_Share_QQ", nil),
                           NSLocalizedString(@"NL_Share_WeiBo", nil),];
    NSArray *shareImage = @[@"NL_Share_WeChartFriend",
                            @"NL_Share_WeChartCircle",
                            @"NL_Share_WB",
                            @"NL_Share_QQ",];
    
    
    for (NSInteger i=0; i<4; i++) {
        NLAboutUpperImageBtn *thirdShare = [[NLAboutUpperImageBtn alloc] initWithFrame:
                                            CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:132])/4/2 + i*(SCREENWIDTH - [ApplicationStyle control_weight:132])/4,
                                                       [ApplicationStyle control_height:44],
                                                       [ApplicationStyle control_weight:132],
                                                       [ApplicationStyle control_height:132])];
        
        [thirdShare setImage:[UIImage imageNamed:shareImage[i]] forState:UIControlStateNormal];
        [thirdShare setTitle:shareText[i] forState:UIControlStateNormal];
        [thirdShare setTitleColor:[@"222222" hexStringToColor] forState:UIControlStateNormal];
        thirdShare.titleLabel.font = [ApplicationStyle textSuperSmallFont];

        [self addSubview:thirdShare];
        
    }
    
    
    
    
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
