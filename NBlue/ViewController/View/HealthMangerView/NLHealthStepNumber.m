//
//  NLHealthStepNumber.m
//  NBlue
//
//  Created by LYD on 15/11/24.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLHealthStepNumber.h"
#import "NLColumnImage.h"
#import "NLStepImageLabView.h"
#import "NLStepColumnImage.h"
@interface NLHealthStepNumber()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIButton *stepNumber;
@property(nonatomic,strong)UILabel *maxStepNumber;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation NLHealthStepNumber
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self bulidUI];
    }
    return self;
}
-(void)bulidUI{
    
    
    
    

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self addSubview:_tableView];
    
}

#pragma mark 系统代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.frame.size.height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"LYD";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    CGFloat x = [ApplicationStyle control_weight:24], h = [ApplicationStyle control_height:60];
    
    
    UILabel *targetNumber = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, [ApplicationStyle control_weight:170], h)];
    targetNumber.text = NSLocalizedString(@"NLHealthStepNumber_TargetNumber", nil);
    targetNumber.textColor = [@"ffffff" hexStringToColor];
    targetNumber.font = [ApplicationStyle  textThrityFont];
    targetNumber.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:targetNumber];
    
    _stepNumber = [UIButton buttonWithType:UIButtonTypeCustom];
    _stepNumber.frame = CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:150] - x, 0, [ApplicationStyle control_weight:150], h);
    [_stepNumber setTitle:@"8,000" forState:UIControlStateNormal];
    [_stepNumber setImage:[UIImage imageNamed:@"Health_M_R_B"] forState:UIControlStateNormal];
    [_stepNumber addTarget:self action:@selector(stepNumberDown) forControlEvents:UIControlEventTouchUpInside];
    _stepNumber.titleLabel.font = [ApplicationStyle textThrityFont];
    [cell addSubview:_stepNumber];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x,h, SCREENWIDTH - x * 2, [ApplicationStyle control_height:1])];
    line.backgroundColor = [@"ffcdd0" hexStringToColor];
    [cell addSubview:line];
    
    _maxStepNumber = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:110] - x, line.bottomOffset, [ApplicationStyle control_weight:110], [ApplicationStyle control_height:50])];
    _maxStepNumber.text = @"4,000";
    _maxStepNumber.font = [ApplicationStyle textSuperSmallFont];
    _maxStepNumber.textColor = [@"ffecf0" hexStringToColor];
    _maxStepNumber.textAlignment = NSTextAlignmentRight;
    [cell addSubview:_maxStepNumber];
    
    NSMutableArray *arrs = [NSMutableArray array];
    for (NSInteger i=0; i<=24; i++) {
        NSInteger num = arc4random()%150;
        [arrs addObject:[NSNumber numberWithInteger:num]];
    }
    
    CGRect frame = CGRectMake(0, line.bottomOffset, SCREENWIDTH, [ApplicationStyle control_height:480]);
    
    NLStepColumnImage  *column = [[NLStepColumnImage alloc] initWithFrame:frame DataArr:arrs strokeColor:[@"882a00" hexStringToColor] withColor:[@"fac96f" hexStringToColor]];
    column.backgroundColor = [UIColor clearColor];
    [cell addSubview:column];
    
    UIView *viewTimeBack = [[UIView alloc] initWithFrame:CGRectMake(0, column.bottomOffset, SCREENWIDTH, [ApplicationStyle control_height:60])];
    viewTimeBack.backgroundColor = [ApplicationStyle subjectWithColor];
    viewTimeBack.alpha = 0.1;
    [cell addSubview:viewTimeBack];
    
    
    
    NSArray *arrTime = @[@"00:00",@"06:00",@"12:00",@"18:00",@"24:00"];
    
    
    CGSize sizeTime = [ApplicationStyle textSize:@"06:00" font:[ApplicationStyle textSuperSmallFont] size:SCREENWIDTH];
    
    
    for (NSInteger i=0; i<arrTime.count; i++) {
        UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:14] + i * (SCREENWIDTH - [ApplicationStyle control_weight:14 * 2] - sizeTime.width)/4 , column.bottomOffset, sizeTime.width, [ApplicationStyle control_height:60])];
        timeLab.text = arrTime[i];
        timeLab.font = [ApplicationStyle textSuperSmallFont];
        timeLab.textColor = [ApplicationStyle subjectWithColor];
        [cell addSubview:timeLab];
    }
    UIView *lineTime = [[UIView alloc] initWithFrame:CGRectMake(0, column.bottomOffset + [ApplicationStyle control_height:60 - 1], SCREENWIDTH, [ApplicationStyle control_height:1])];
    lineTime.backgroundColor = [ApplicationStyle subjectWithColor];
    [cell addSubview:lineTime];
    
    
    
    
    NSArray *stepArr = @[@"Step_Num",@"Step_KM",@"Step_KLL"];
    NSArray *stepData = @[@"1111步",@"5.34千米",@"241千卡"];
    NSArray *stepRemark = @[NSLocalizedString(@"NLHealthStepNumber_TheCurrent", nil),
                            NSLocalizedString(@"NLHealthStepNumber_MovingDistance", nil),
                            NSLocalizedString(@"NLHealthStepNumber_ConsumedEnergy", nil)];
    
    for (NSInteger i=0; i<stepArr.count; i++) {
        CGRect frames = CGRectMake(0+i*SCREENWIDTH/3, lineTime.bottomOffset+ [ApplicationStyle control_height:100], SCREENWIDTH/3, [ApplicationStyle control_height:200]);
        
        NLStepImageLabView *viewLab = [[NLStepImageLabView alloc] initWithImage:[UIImage imageNamed:stepArr[i]]
                                                                       textFont:[ApplicationStyle textThrityFont]
                                                                      textColor:[ApplicationStyle subjectWithColor]
                                                                     textRemark:stepRemark[i]
                                                                        textNum:stepData[i]
                                                                          frame:frames];
        viewLab.frame = frames;
        [cell addSubview:viewLab];
    }
    

    
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
#pragma mark 填写步数
-(void)stepNumberDown{
    NSLog(@"填写步数");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
