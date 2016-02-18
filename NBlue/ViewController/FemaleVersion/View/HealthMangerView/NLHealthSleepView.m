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
#import "NLSQLData.h"
#import "MJRefresh.h"
#import "NLBluetoothAgreement.h"
@interface NLHealthSleepView()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UILabel *timeSleep;
@property(nonatomic,strong)UILabel *depthLab;
@property(nonatomic,strong)NLRing *ring;
@property(nonatomic,strong)UITableView *mainTableView;
@end

@implementation NLHealthSleepView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
        [self notification];
    }
    return self;
}
-(void)btnDownsss{
    _ring.progressCounter = 100;
}

-(void)buildUI{
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.viewWidth, self.viewHeight) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.backgroundColor = [UIColor clearColor];
    _mainTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:_mainTableView];
    
    _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
}

-(void)notification{
    NSNotificationCenter *notifi= [NSNotificationCenter defaultCenter];
    [notifi addObserver:self selector:@selector(refishData) name:RefrefhSleepDataNotification object:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.viewHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"LYD";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGRect frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:500])/2,([ApplicationStyle control_height:600] - [ApplicationStyle control_height:500])/2, [ApplicationStyle control_weight:500], [ApplicationStyle control_height:500]);
    
    _ring = [[NLRing alloc] init];
    _ring.lineWidth = [ApplicationStyle control_weight:30];
    _ring.lineIndex = 100;
    _ring.progressCounter = 97;
    _ring.radius = [ApplicationStyle control_weight:200];
    _ring.backColors = [self circleBackColor];
    _ring.coverColor = [self circleCoverdColor];
    _ring.types = NLRingType_separateCircle;
    
    NLRingLine *ringLine = [[NLRingLine alloc] initWithRing:_ring frame:frame];
    ringLine.backgroundColor = [UIColor clearColor];
    [cell addSubview:ringLine];
    
    
    
    

    
    NSMutableArray *sleepData = [NLSQLData sleepDataObtainTime:[ApplicationStyle datePickerTransformationCorss:[NSDate date]]];
    NSLog(@"%@",sleepData);
    
    
    
    UILabel *yesterdayLab = [[UILabel alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:128])/2, [ApplicationStyle control_height:220], [ApplicationStyle control_weight:128], [ApplicationStyle control_height:30])];
    yesterdayLab.text = NSLocalizedString(@"NLHealthSleepView_YesterDay", nil);
    yesterdayLab.font = [UIFont  systemFontOfSize:[ApplicationStyle control_weight:28]];
    yesterdayLab.textColor = [self titleColor];
    [cell addSubview:yesterdayLab];
    
    _timeSleep = [[UILabel alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:300])/2, yesterdayLab.bottomOffset + [ApplicationStyle control_height:20], [ApplicationStyle control_weight:300], [ApplicationStyle control_height:50])];
    _timeSleep.font = [UIFont  fontWithName:@"Helvetica-Bold" size:[ApplicationStyle control_weight:40]];
    _timeSleep.textColor = [self titleColor];
    _timeSleep.textAlignment = NSTextAlignmentCenter;
    NSString *total_time = nil;
    if (sleepData.count==0) {
        total_time = @"0";
    }else{
        total_time = [sleepData[0] objectForKey:@"total_time"];
    }
    
    NSArray *timeSleep = [ApplicationStyle interceptText:[NSString stringWithFormat:@"%0.01f",[total_time integerValue]/60.0f] interceptCharacter:@"."];
    _timeSleep.text = [NSString stringWithFormat:@"%@小时%@分钟",timeSleep[0],timeSleep[1]];
    [cell addSubview:_timeSleep];
    
    _depthLab = [[UILabel alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:300])/2, _timeSleep.bottomOffset + [ApplicationStyle control_height:34], [ApplicationStyle control_weight:300 ], [ApplicationStyle control_height:30])];
    _depthLab.font = [UIFont  fontWithName:@"Helvetica-Bold" size:[ApplicationStyle control_weight:26]];
    _depthLab.textColor = [self titleColor];
    _depthLab.textAlignment = NSTextAlignmentCenter;
    
    
    NSString *deepSleep_mins = nil;
    if (sleepData.count==0) {
        deepSleep_mins = @"0";
    }else{
        deepSleep_mins = [sleepData[0] objectForKey:@"deepSleep_mins"];
    }
    
    
    NSArray *depthLab = [ApplicationStyle interceptText:[NSString stringWithFormat:@"%0.01f",[deepSleep_mins integerValue]/60.0f] interceptCharacter:@"."];
    _depthLab.text = [ NSString stringWithFormat:@"深度睡眠%@小时%@分钟",depthLab[0],depthLab[1]];
    [cell addSubview:_depthLab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:40], [ApplicationStyle control_height:600], SCREENWIDTH - [ApplicationStyle control_weight:40 * 2], [ApplicationStyle control_height:1])];
    line.backgroundColor = [self circleBackColor];
    [cell addSubview:line];
    
    
    NSString *wakeUp = nil;
    if (sleepData.count==0) {
        wakeUp = @"0";
    }else{
        wakeUp = [sleepData[0] objectForKey:@"endSleep_Time"];
    }
    
    NSArray *wakeUpArr = [ApplicationStyle interceptText:wakeUp interceptCharacter:@":"];
    
    NSInteger hourTime = [total_time integerValue]/60;
    NSInteger miueTime = [total_time integerValue]%60;

    if (wakeUpArr.count >=2) {
        if ([wakeUpArr[1] integerValue] - miueTime<0) {
            miueTime = [wakeUpArr[1] integerValue] - miueTime + 60;
            hourTime = hourTime + 1;
        }else{
            miueTime = [wakeUpArr[1] integerValue] - miueTime;
        }
        
        
        if ([wakeUpArr[0] integerValue] - hourTime<0) {
            hourTime = [wakeUpArr[0] integerValue] - hourTime  + 24;
        }else{
            hourTime = [wakeUpArr[0] integerValue] - hourTime;
        }
    }
    
    NSString *endSleep_Time = nil;
    if (sleepData.count==0) {
        endSleep_Time = @"0";
    }else{
        endSleep_Time = [sleepData[0] objectForKey:@"endSleep_Time"];
    }
    
    
    NSArray *timeArr = @[[NSString stringWithFormat:@"%ld:%ld",(long)hourTime,(long)miueTime],endSleep_Time,@"良"];
    NSArray *sleepLabArr = @[NSLocalizedString(@"NLHealthSleepView_GOSleepTime", nil),
                             NSLocalizedString(@"NLHealthSleepView_WakeUPSleepTime", nil),
                             NSLocalizedString(@"NLHealthSleepView_SleepQuality", nil)];
    NSArray *slppeImage = @[@"Sleep_RS",@"Sleep_SX",@"Sleep_ZL"];
    
    for (NSInteger i =0 ; i<timeArr.count; i++) {
        CGRect frames = CGRectMake(0+i*SCREENWIDTH/3, line.bottomOffset+ [ApplicationStyle control_height:100], SCREENWIDTH/3, [ApplicationStyle control_height:200]);
        
        NLStepImageLabView *viewLab = [[NLStepImageLabView alloc] initWithImage:[UIImage imageNamed:slppeImage[i]]
                                                                       textFont:[ApplicationStyle textThrityFont]
                                                                      textColor:[self titleColor]
                                                                     textRemark:sleepLabArr[i]
                                                                        textNum:timeArr[i]
                                                                          frame:frames];
        viewLab.frame = frames;
        [cell addSubview:viewLab];
    }
    
    return cell;
}

-(void)loadNewData{
    NSMutableArray *dataArr = [NSMutableArray array];
    NLBluetoothAgreement *blues = [NLBluetoothAgreement shareInstance];
    dataArr  = blues.arrPeripheral;
    {
        Byte byte[20] = {0x08,0x01,0x01,0x01};
        NSData *data = [NSData dataWithBytes:byte length:20];
        if (dataArr.count>0) {
            [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:dataArr[0] data:data];
        }
    }
    
    {
        Byte byte[20] = {0x08,0x04,0x01};
        NSData *data = [NSData dataWithBytes:byte length:20];
        if (dataArr.count>0) {
            [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:dataArr[0] data:data];
        }
    }
}

-(void)refishData{
    [_mainTableView.mj_header endRefreshing];
}



// 颜色
- (UIColor *)circleBackColor{
    
    UIColor *color = nil;
    if ([[kAPPDELEGATE._loacluserinfo getUserGender]isEqualToString:@"0"]) {
        color = [@"f7f3ff" hexStringToColor];
    }else{
        color = [@"e5aa5f" hexStringToColor];
    }
    return color;
}
- (UIColor *)circleCoverdColor{
    UIColor *color = nil;
    
    if ([[kAPPDELEGATE._loacluserinfo getUserGender]isEqualToString:@"0"]) {
        color = [@"ffde6a" hexStringToColor];
    }else{
        color = [@"a66d1b" hexStringToColor];
    }
    return color;
}
- (UIColor *)titleColor{
    UIColor *color = nil;
    
    if ([[kAPPDELEGATE._loacluserinfo getUserGender]isEqualToString:@"0"]) {
        color = [@"ffde6a" hexStringToColor];
    }else{
        color = [@"a66d1b" hexStringToColor];
    }
    return color;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
