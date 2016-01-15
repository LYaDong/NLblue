//
//  NLHealthStepNumberCell.m
//  NBlue
//
//  Created by LYD on 15/12/23.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLHealthStepNumberCell.h"
#import "NLStepColumnImage.h"
#import "NLStepImageLabView.h"
@interface NLHealthStepNumberCell ()
@property(nonatomic,strong)UIButton *stepNumber;
@property(nonatomic,strong)UILabel *maxStepNumber;
@property(nonatomic,strong)NSMutableArray *arrs;

@end
@implementation NLHealthStepNumberCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        


    }
    return self;
}


-(void)histogram:(NSArray *)arrs sportData:(NSArray *)sportData target:(NSInteger)target{

    NSInteger num = 0;
    for (NSInteger i=0; i<arrs.count; i++) {
        if ([[NSString stringWithFormat:@"%@",arrs[i]] intValue] > num) {
            num = [[NSString stringWithFormat:@"%@",arrs[i]] intValue];
        }
    }
    
    
    if (num > target) {
        target = target * 1.2;
    }
    
    
    
    
    NSMutableArray *dataArray = [NSMutableArray array];
//    for (NSInteger i=0; i<arrs.count; i++) {
//        NSInteger index = [[NSString stringWithFormat:@"%@",arrs[i]] integerValue];
//        [dataArray addObject:[NSNumber numberWithInteger:index * ([ApplicationStyle control_height:480] * 0.8)/num]];
//    }
#warning 测试
    for (NSInteger i=0; i<24; i++) {
//        NSInteger index = [[NSString stringWithFormat:@"%@",arrs[i]] integerValue];
        NSInteger index = arc4random()%500;
        [dataArray addObject:[NSNumber numberWithInteger:index * ([ApplicationStyle control_height:480] * 0.8)/1000]];
    }
    
    
    
    
    
    CGFloat x = [ApplicationStyle control_weight:24], h = [ApplicationStyle control_height:60];
    
    UILabel *targetNumber = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, [ApplicationStyle control_weight:170], h)];
    targetNumber.text = NSLocalizedString(@"NLHealthStepNumber_TargetNumber", nil);
    targetNumber.textColor = [self titleColor];
    targetNumber.font = [ApplicationStyle  textThrityFont];
    targetNumber.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:targetNumber];
    
    _stepNumber = [UIButton buttonWithType:UIButtonTypeCustom];
    _stepNumber.frame = CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:150] - x, 0, [ApplicationStyle control_weight:150], h);
    [_stepNumber setTitle:@"8,000" forState:UIControlStateNormal];
    [_stepNumber setTitleColor:[self titleColor] forState:UIControlStateNormal];
    [_stepNumber setImage:[UIImage imageNamed:@"Health_M_R_B"] forState:UIControlStateNormal];
    [_stepNumber addTarget:self action:@selector(stepNumberDown) forControlEvents:UIControlEventTouchUpInside];
    _stepNumber.titleLabel.font = [ApplicationStyle textThrityFont];
    [self.contentView addSubview:_stepNumber];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x,h, SCREENWIDTH - x * 2, [ApplicationStyle control_height:1])];
    line.backgroundColor = [self lineColor];
    [self.contentView addSubview:line];
    
    _maxStepNumber = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:110] - x, line.bottomOffset, [ApplicationStyle control_weight:110], [ApplicationStyle control_height:50])];
    _maxStepNumber.text = @"4,000";
    _maxStepNumber.font = [ApplicationStyle textSuperSmallFont];
    _maxStepNumber.textColor = [self titleColor];
    _maxStepNumber.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_maxStepNumber];
    
    
    CGRect frame = CGRectMake(0, line.bottomOffset, SCREENWIDTH, [ApplicationStyle control_height:480]);
    
    
    NSLog(@"%@",dataArray);
    
    NLStepColumnImage  *column = [[NLStepColumnImage alloc] initWithFrame:frame DataArr:dataArray strokeColor:[@"882a00" hexStringToColor] withColor:[self histogramColor]];
    column.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:column];
    
    UIView *viewTimeBack = [[UIView alloc] initWithFrame:CGRectMake(0, column.bottomOffset, SCREENWIDTH, [ApplicationStyle control_height:60])];
    viewTimeBack.backgroundColor = [ApplicationStyle subjectWithColor];
    viewTimeBack.alpha = 0.1;
    [self.contentView addSubview:viewTimeBack];
    
    
    
    NSArray *arrTime = @[@"00:00",@"06:00",@"12:00",@"18:00",@"24:00"];
    
    
    CGSize sizeTime = [ApplicationStyle textSize:@"06:00" font:[ApplicationStyle textSuperSmallFont] size:SCREENWIDTH];
    
    
    for (NSInteger i=0; i<arrTime.count; i++) {
        UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:14] + i * (SCREENWIDTH - [ApplicationStyle control_weight:14 * 2] - sizeTime.width)/4 , column.bottomOffset, sizeTime.width, [ApplicationStyle control_height:60])];
        timeLab.text = arrTime[i];
        timeLab.font = [ApplicationStyle textSuperSmallFont];
        timeLab.textColor = [self titleColor];
        [self.contentView addSubview:timeLab];
    }
    UIView *lineTime = [[UIView alloc] initWithFrame:CGRectMake(0, column.bottomOffset + [ApplicationStyle control_height:60 - 1], SCREENWIDTH, [ApplicationStyle control_height:1])];
    lineTime.backgroundColor = [self lineColor];
    [self.contentView addSubview:lineTime];

    

    NSString *sportCount = nil;
    NSString *calorCount = nil;
    NSString *distanceAmount = nil;
    if (!sportData.count == 0) {
        if (sportData>0) {
            sportCount = [sportData[0] objectForKey:@"stepsAmount"];
            calorCount = [sportData[0] objectForKey:@"caloriesAmount"];
            distanceAmount = [sportData[0] objectForKey:@"distanceAmount"];
        }
    }else{
        sportCount = @"0";
        calorCount = @"0";
        distanceAmount = @"0";
    }
    
    NSArray *stepArr = @[@"Step_Num",@"Step_KM",@"Step_KLL"];
    NSArray *stepData = @[[NSString stringWithFormat:@"%@步",sportCount],
                          [NSString stringWithFormat:@"%@米",distanceAmount],
                          [NSString stringWithFormat:@"%@卡",calorCount]];
    
    NSArray *stepRemark = @[NSLocalizedString(@"NLHealthStepNumber_TheCurrent", nil),
                            NSLocalizedString(@"NLHealthStepNumber_MovingDistance", nil),
                            NSLocalizedString(@"NLHealthStepNumber_ConsumedEnergy", nil)];
    
    for (NSInteger i=0; i<stepArr.count; i++) {
        CGRect frames = CGRectMake(0+i*SCREENWIDTH/3, lineTime.bottomOffset+ [ApplicationStyle control_height:100], SCREENWIDTH/3, [ApplicationStyle control_height:200]);
        
        NLStepImageLabView *viewLab = [[NLStepImageLabView alloc] initWithImage:[UIImage imageNamed:stepArr[i]]
                                                                       textFont:[ApplicationStyle textThrityFont]
                                                                      textColor:[self titleColor]
                                                                     textRemark:stepRemark[i]
                                                                        textNum:stepData[i]
                                                                          frame:frames];
        viewLab.frame = frames;
        [self.contentView addSubview:viewLab];
    }
}

-(void)stepNumberDown{
    NSLog(@"填写步数");
}

- (UIColor *)histogramColor{
    UIColor *color = nil;
    if ([[kAPPDELEGATE._loacluserinfo getUserGender]isEqualToString:@"0"]) {
        color = [@"fac96f" hexStringToColor];
    }else{
        color = [@"fac96f" hexStringToColor];
    }
    return color;
}
- (UIColor *)titleColor{
    UIColor *color = nil;
    if ([[kAPPDELEGATE._loacluserinfo getUserGender]isEqualToString:@"0"]) {
        color = [ApplicationStyle subjectWithColor];
    }else{
        color = [@"d49a2f" hexStringToColor];
    }
    return color;
}

- (UIColor *)lineColor{
    UIColor *color = nil;
    if ([[kAPPDELEGATE._loacluserinfo getUserGender]isEqualToString:@"0"]) {
        color = [@"ffcdd0" hexStringToColor];
    }else{
        color = [@"ddab56" hexStringToColor];
    }
    return color;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
