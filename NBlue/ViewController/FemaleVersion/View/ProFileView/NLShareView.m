//
//  NLShareView.m
//  NBlue
//
//  Created by LYD on 16/3/7.
//  Copyright © 2016年 LYD. All rights reserved.
//

static const NSInteger THIRDSHARETAG = 1000;


#import "NLShareView.h"
#import "NLAboutUpperImageBtn.h"
#import <UMSocialWechatHandler.h>
#import <UMSocialDataService.h>
#import <UMSocialControllerService.h>
#import <UMSocialSnsPlatformManager.h>
@interface NLShareView ()<UMSocialDataDelegate>
@end

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
                            @"NL_Share_QQ",
                            @"NL_Share_WB"];

    for (NSInteger i=0; i<shareText.count; i++) {
        
        
        CGRect frame = CGRectMake((SCREENWIDTH/4 - [ApplicationStyle control_weight:132])/2 + i * SCREENWIDTH/4, [ApplicationStyle control_height:44], [ApplicationStyle control_weight:132], [ApplicationStyle control_height:132]);
        

        NLAboutUpperImageBtn *thirdShare = [[NLAboutUpperImageBtn alloc] initWithFrame:frame];
        
        [thirdShare setImage:[UIImage imageNamed:shareImage[i]] forState:UIControlStateNormal];
        [thirdShare setTitle:shareText[i] forState:UIControlStateNormal];
        [thirdShare setTitleColor:[@"222222" hexStringToColor] forState:UIControlStateNormal];
        thirdShare.titleLabel.font = [ApplicationStyle textSuperSmallFont];
        thirdShare.tag = THIRDSHARETAG + i;
        [thirdShare addTarget:self action:@selector(thirdShareDown:) forControlEvents:UIControlEventTouchUpInside];
        [viewBack addSubview:thirdShare];
        
    }
    
    UIView *lines = [[UIView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle control_height:200], SCREENWIDTH, [ApplicationStyle control_height:1])];
    lines.backgroundColor = [@"dddddd" hexStringToColor];
    [viewBack addSubview:lines];
    
    UIButton *cancle = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancle.frame = CGRectMake(0, lines.bottomOffset+[ApplicationStyle control_height:1], SCREENWIDTH, [ApplicationStyle control_height:96]);
    [cancle setTitle:NSLocalizedString(@"GeneralText_Cancel", nil) forState:UIControlStateNormal];
    [cancle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancle.titleLabel.font = [ApplicationStyle textThrityFont];
    [cancle addTarget:self action:@selector(cancleDown) forControlEvents:UIControlEventTouchUpInside];
    [viewBack addSubview:cancle];
}
-(void)cancleDown{
    [self.delegate cancleBtn];
}
-(void)thirdShareDown:(UIButton *)btn{
    [self.delegate shareBtnDownIndex:btn.tag];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
