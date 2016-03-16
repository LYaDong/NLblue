//
//  NLCalenderLifeHabit.m
//  NBlue
//
//  Created by LYD on 15/12/16.
//  Copyright © 2015年 LYD. All rights reserved.
//
static const NSInteger BTNTAG = 1000;
static const NSInteger LIFEHABITTAG = 2000;
#import "NLCalenderLifeHabit.h"
#import "NLSQLData.h"
@interface NLCalenderLifeHabit()
@property(nonatomic,strong)NSMutableArray *lifeHabitArr;
@property(nonatomic,strong)NSMutableArray *addDataArr;
@end
@implementation NLCalenderLifeHabit





- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)buildUI{
    
    NSLog(@"%@",self.commonTime);
    
    
    _lifeHabitArr = [NSMutableArray array];
    _addDataArr = [NSMutableArray array];
    
    
    NSArray *habitData = [self canlenData];//获得生活习惯的每天数据
    [_addDataArr addObjectsFromArray:habitData];
    
    
    

    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:40], 0, SCREENWIDTH - [ApplicationStyle control_weight:80], [ApplicationStyle control_height:500])];
    backView.backgroundColor = [ApplicationStyle subjectWithColor];
    backView.layer.cornerRadius = [ApplicationStyle control_weight:10];
    [self addSubview:backView];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, backView.viewWidth, [ApplicationStyle  control_height:80])];
    titleLab.text = NSLocalizedString(@"NLHealthCalender_LifeHabit_Title", nil);
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [ApplicationStyle textThrityFont];
    titleLab.textColor = [ApplicationStyle subjectPinkColor];
    [backView addSubview:titleLab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:10], [ApplicationStyle control_height:80], backView.viewWidth - [ApplicationStyle control_weight:20], [ApplicationStyle control_height:1])];
    line.backgroundColor = [@"f5d6d6" hexStringToColor];
    [backView addSubview:line];
    
    
    NSArray *imageArr = @[@"NLHClen_SHXG_SG_X",
                          @"NLHClen_SHXG_YD_X",
                          @"NLHClen_SHXG_DB_X",];
    
    NSArray *imageArrYes = @[@"NLHClen_SHXG_SG",
                             @"NLHClen_SHXG_YD",
                             @"NLHClen_SHXG_DB",];
    
    NSArray *labArr = @[NSLocalizedString(@"NLHealthCalender_LifeHabit_SG", nil),
                        NSLocalizedString(@"NLHealthCalender_LifeHabit_YD", nil),
                        NSLocalizedString(@"NLHealthCalender_LifeHabit_PB", nil),];
    for (NSInteger i=0; i<imageArr.count; i++) {
        UIButton *lifeHabit = [UIButton buttonWithType:UIButtonTypeCustom];
        lifeHabit.frame = CGRectMake((backView.viewWidth - [ApplicationStyle control_weight:240])/2, [ApplicationStyle control_height:50 + 80]+i*[ApplicationStyle control_height:70], [ApplicationStyle control_weight:240], [ApplicationStyle control_height:60]);
        
        if ([habitData[i] isEqualToString:@"0"]) {
            [lifeHabit setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
            [lifeHabit setTitleColor:[@"dedede" hexStringToColor] forState:UIControlStateNormal];
        }else{
            [lifeHabit setImage:[UIImage imageNamed:imageArrYes[i]] forState:UIControlStateNormal];
            lifeHabit.backgroundColor = [self backColor];
            [lifeHabit setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
            lifeHabit.selected = !lifeHabit.selected;
        }
        [lifeHabit setTitle:labArr[i] forState:UIControlStateNormal];
        lifeHabit.tag = LIFEHABITTAG + i;
        [lifeHabit addTarget:self action:@selector(lifeHabitDown:) forControlEvents:UIControlEventTouchUpInside];
        lifeHabit.layer.cornerRadius = [ApplicationStyle control_weight:10];
        lifeHabit.titleLabel.font = [ApplicationStyle textThrityFont];
        [backView addSubview:lifeHabit];
    }
    
    
    
    
    
    NSArray *btnArr = @[NSLocalizedString(@"NLHealthCalender_Picker_BtnCalue", nil),
                        NSLocalizedString(@"NLHealthCalender_Picker_BtnOK", nil),];
    for (NSInteger i=0; i<btnArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake([ApplicationStyle control_weight:30] + i*(backView.viewWidth - [ApplicationStyle control_weight:220]),
                               backView.bottomOffset - [ApplicationStyle control_height:80] + ([ApplicationStyle control_height:80] - [ApplicationStyle control_height:60])/2,
                               [ApplicationStyle control_weight:160],
                               [ApplicationStyle control_height:60]);
        [btn setTitle:btnArr[i] forState:UIControlStateNormal];
        if (i==0) {
            [btn setTitleColor:[ApplicationStyle subjectPinkColor] forState:UIControlStateNormal];
        }else{
            btn.backgroundColor = [@"fb597a" hexStringToColor];
            [btn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
        }
        btn.layer.borderWidth = [ApplicationStyle control_weight:2];
        btn.layer.borderColor = [@"fb597a" hexStringToColor].CGColor;
        btn.layer.cornerRadius = [ApplicationStyle control_weight:10];
        btn.tag = BTNTAG + i;
        [btn addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btn];
    }
    

}
#pragma mark 按钮事件
-(void)btnDown:(UIButton *)btn{
    if (btn.tag == BTNTAG) {
        
        NSArray *imageArr = @[@"NLHClen_SHXG_SG_X",
                              @"NLHClen_SHXG_YD_X",
                              @"NLHClen_SHXG_DB_X",];
        for (NSInteger i=0; i<imageArr.count; i++) {
            UIButton *liftHabit = (UIButton *)[self viewWithTag:LIFEHABITTAG + i];
            [liftHabit setTitleColor:[@"dedede" hexStringToColor] forState:UIControlStateNormal];
            liftHabit.backgroundColor = [ApplicationStyle subjectWithColor];
            [liftHabit setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
            if (liftHabit.selected == YES) {
               liftHabit.selected = !liftHabit.selected;
            }
        }
        [self.delegate lifeHabitCount:nil];
    }else{
        
        NSLog(@"%@",_addDataArr);
        
        [self.delegate lifeHabitCount:_addDataArr];
    }
}

-(void)lifeHabitDown:(UIButton *)btn{
    NSInteger num = [[NSString stringWithFormat:@"%@",_addDataArr[btn.tag - LIFEHABITTAG]] intValue] - 1;
    btn.selected = !btn.selected;
    switch (btn.tag - LIFEHABITTAG) {
        case LifeHabit_SG:{
            if ([_addDataArr[btn.tag - LIFEHABITTAG] isEqualToString:@"0"]) {
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",(long)btn.tag - LIFEHABITTAG +1]];
            }else{
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",(long)btn.tag - LIFEHABITTAG - num]];
            }
            
            if (btn.selected) {
                [btn setImage:[UIImage imageNamed:@"NLHClen_SHXG_SG"] forState:UIControlStateNormal];
                [btn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
                btn.backgroundColor = [self backColor];
                
                return;
            }else{
                [btn setImage:[UIImage imageNamed:@"NLHClen_SHXG_SG_X"] forState:UIControlStateNormal];
                [btn setTitleColor:[@"dedede" hexStringToColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectWithColor];
                return;
            }
            break;
        }
        case LifeHabit_YD:  {
            if ([_addDataArr[btn.tag - LIFEHABITTAG] isEqualToString:@"0"]) {
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",(long)btn.tag - LIFEHABITTAG +1]];
            }else{
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",(long)btn.tag - LIFEHABITTAG - num]];
            }
            
            if (btn.selected) {
                [btn setImage:[UIImage imageNamed:@"NLHClen_SHXG_YD"] forState:UIControlStateNormal];
                [btn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
                btn.backgroundColor = [self backColor];
                return;
            }else{
                [btn setImage:[UIImage imageNamed:@"NLHClen_SHXG_YD_X"] forState:UIControlStateNormal];
                [btn setTitleColor:[@"dedede" hexStringToColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectWithColor];
                return;
            }
            break;
        }
        case LifeHabit_PB:{
            if ([_addDataArr[btn.tag - LIFEHABITTAG] isEqualToString:@"0"]) {
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",(long)btn.tag - LIFEHABITTAG +1]];
            }else{
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",(long)btn.tag - LIFEHABITTAG - num]];
            }
            if (btn.selected) {
                [btn setImage:[UIImage imageNamed:@"NLHClen_SHXG_DB"] forState:UIControlStateNormal];
                [btn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
                btn.backgroundColor = [self backColor];
                return;
            }else{
                [btn setImage:[UIImage imageNamed:@"NLHClen_SHXG_DB_X"] forState:UIControlStateNormal];
                [btn setTitleColor:[@"dedede" hexStringToColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectWithColor];
                return;
            }
            break;
        }
        default:
            break;
    }
}

-(UIColor *)backColor{
    UIColor *color = [@"ff829b" hexStringToColor];
    return color;
}
-(NSArray *)canlenData{
    NSString *count = [[NLSQLData canlenderDayData:self.commonTime] objectForKey:@"habitsAndCustoms"];
    NSArray *array = [count componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
    
    NSLog(@"%@",array);
    
    return array;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
