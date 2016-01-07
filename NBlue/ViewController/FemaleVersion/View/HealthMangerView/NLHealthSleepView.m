//
//  NLHealthSleepView.m
//  NBlue
//
//  Created by LYD on 15/11/24.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLHealthSleepView.h"
#import "NLRingLine.h"
#import "NlRing.h"
#import "NLStepImageLabView.h"
@interface NLHealthSleepView()
@property(nonatomic,strong)UILabel *timeSleep;
@property(nonatomic,strong)UILabel *depthLab;
@property(nonatomic,strong)NLRing *ring;
@end

@implementation NLHealthSleepView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}
-(void)btnDownsss{
    _ring.progressCounter = 100;
}

-(void)buildUI{
    CGRect frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:500])/2,([ApplicationStyle control_height:600] - [ApplicationStyle control_height:500])/2, [ApplicationStyle control_weight:500], [ApplicationStyle control_height:500]);
    
    _ring = [[NLRing alloc] init];
    _ring.backColors = [@"f7f3ff" hexStringToColor];
    _ring.coverColor = [@"ffde6a" hexStringToColor];
    _ring.lineWidth = [ApplicationStyle control_weight:30];
    _ring.lineIndex = 100;
    _ring.progressCounter = 30;
    _ring.radius = [ApplicationStyle control_weight:200];
    
    NLRingLine *ringLine = [[NLRingLine alloc] initWithRing:_ring frame:frame];
    ringLine.backgroundColor = [UIColor clearColor];
    [self addSubview:ringLine];

    
    
    
    
    
    UILabel *yesterdayLab = [[UILabel alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:128])/2, [ApplicationStyle control_height:220], [ApplicationStyle control_weight:128], [ApplicationStyle control_height:30])];
    yesterdayLab.text = NSLocalizedString(@"NLHealthSleepView_YesterDay", nil);
    yesterdayLab.font = [UIFont  systemFontOfSize:[ApplicationStyle control_weight:28]];
    yesterdayLab.textColor = [ApplicationStyle subjectWithColor];
    [self addSubview:yesterdayLab];
    
    _timeSleep = [[UILabel alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:300])/2, yesterdayLab.bottomOffset + [ApplicationStyle control_height:20], [ApplicationStyle control_weight:300], [ApplicationStyle control_height:50])];
    _timeSleep.font = [UIFont  fontWithName:@"Helvetica-Bold" size:[ApplicationStyle control_weight:40]];
    _timeSleep.textColor = [ApplicationStyle subjectWithColor];
    _timeSleep.textAlignment = NSTextAlignmentCenter;
    _timeSleep.text = @"6小时30分钟";
    [self addSubview:_timeSleep];
    
    _depthLab = [[UILabel alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:300])/2, _timeSleep.bottomOffset + [ApplicationStyle control_height:34], [ApplicationStyle control_weight:300 ], [ApplicationStyle control_height:30])];
    _depthLab.font = [UIFont  fontWithName:@"Helvetica-Bold" size:[ApplicationStyle control_weight:26]];
    _depthLab.textColor = [ApplicationStyle subjectWithColor];
    _depthLab.textAlignment = NSTextAlignmentCenter;
    _depthLab.text = @"深度睡眠 3小时30分钟";
    [self addSubview:_depthLab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:40], [ApplicationStyle control_height:600], SCREENWIDTH - [ApplicationStyle control_weight:40 * 2], [ApplicationStyle control_height:1])];
    line.backgroundColor = [ApplicationStyle subjectWithColor];
    [self addSubview:line];
    
    
    NSArray *timeArr = @[@"23:30",@"06:45",@"良"];
    NSArray *sleepLabArr = @[NSLocalizedString(@"NLHealthSleepView_GOSleepTime", nil),
                             NSLocalizedString(@"NLHealthSleepView_WakeUPSleepTime", nil),
                             NSLocalizedString(@"NLHealthSleepView_SleepQuality", nil)];
    NSArray *slppeImage = @[@"Sleep_RS",@"Sleep_SX",@"Sleep_ZL"];
    
    for (NSInteger i =0 ; i<timeArr.count; i++) {
        CGRect frames = CGRectMake(0+i*SCREENWIDTH/3, line.bottomOffset+ [ApplicationStyle control_height:100], SCREENWIDTH/3, [ApplicationStyle control_height:200]);
        
        NLStepImageLabView *viewLab = [[NLStepImageLabView alloc] initWithImage:[UIImage imageNamed:slppeImage[i]]
                                                                       textFont:[ApplicationStyle textThrityFont]
                                                                      textColor:[ApplicationStyle subjectWithColor]
                                                                     textRemark:sleepLabArr[i]
                                                                        textNum:timeArr[i]
                                                                          frame:frames];
        viewLab.frame = frames;
        [self addSubview:viewLab];
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
