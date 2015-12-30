//
//  NLCalenderUncomfortable.m
//  NBlue
//
//  Created by LYD on 15/12/16.
//  Copyright © 2015年 LYD. All rights reserved.
//
static const NSInteger BTNTAG = 1000;
static const NSInteger LIFEHABITTAG = 2000;

#import "NLCalenderUncomfortable.h"
#import "NLCalenderUncomforBtn.h"
@interface NLCalenderUncomfortable()
@property(nonatomic,strong)NSMutableArray *addDataArr;
@end

@implementation NLCalenderUncomfortable
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _addDataArr = [NSMutableArray array];
        [self buildUI];
    }
    return self;
}
-(void)buildUI{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:40], 0, SCREENWIDTH - [ApplicationStyle control_weight:80], [ApplicationStyle control_height:660])];
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
    
    
    NSArray *imageArr = @[@"NLHClen_BSF_TT_X",
                          @"NLHClen_BSF_BD_X",
                          @"NLHClen_BSF_LY_X",
                          @"NLHClen_BSF_BM_X",
                          @"NLHClen_BSF_XFT_X",
                          @"NLHClen_BSF_MSY_X",
                          @"NLHClen_BSF_YS_X",
                          @"NLHClen_BSF_HSST_X",
                          @"NLHClen_BSF_RFZT_X",
                          @"NLHClen_BSF_RFCT_X",
                          @"NLHClen_BSF_BDYC_X",
                          @"NLHClen_BSF_QT_X"];
    
    NSArray *labArr = @[NSLocalizedString(@"NLHealthCalender_Unconmfortable_TT", nil),
                        NSLocalizedString(@"NLHealthCalender_Unconmfortable_BD", nil),
                        NSLocalizedString(@"NLHealthCalender_Unconmfortable_HLLY", nil),
                        NSLocalizedString(@"NLHealthCalender_Unconmfortable_FX", nil),
                        NSLocalizedString(@"NLHealthCalender_Unconmfortable_XFZT", nil),
                        NSLocalizedString(@"NLHealthCalender_Unconmfortable_MSY", nil),
                        NSLocalizedString(@"NLHealthCalender_Unconmfortable_YS", nil),
                        NSLocalizedString(@"NLHealthCalender_Unconmfortable_HSST", nil),
                        NSLocalizedString(@"NLHealthCalender_Unconmfortable_RFZT", nil),
                        NSLocalizedString(@"NLHealthCalender_Unconmfortable_RFCT", nil),
                        NSLocalizedString(@"NLHealthCalender_Unconmfortable_BDYC", nil),
                        NSLocalizedString(@"NLHealthCalender_Unconmfortable_QT", nil),];
    for (NSInteger i=0; i<imageArr.count; i++) {
        NLCalenderUncomforBtn *uncomfortableBtn = [[NLCalenderUncomforBtn alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:54] + i%2*[ApplicationStyle control_weight:200 + 52], [ApplicationStyle control_height:98]+i/2*[ApplicationStyle control_height:80], [ApplicationStyle control_weight:200], [ApplicationStyle control_height:60])];
        [uncomfortableBtn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [uncomfortableBtn setTitleColor:[@"dedede" hexStringToColor] forState:UIControlStateNormal];
        [uncomfortableBtn setTitle:labArr[i] forState:UIControlStateNormal];
        uncomfortableBtn.tag = LIFEHABITTAG + i;
        [uncomfortableBtn addTarget:self action:@selector(uncomfortableBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        uncomfortableBtn.layer.cornerRadius = [ApplicationStyle control_weight:10];
//        [uncomfortableBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        [backView addSubview:uncomfortableBtn];
    }
    
    for (NSInteger i=0; i<labArr.count; i++) {
        [_addDataArr addObject:@"0"];
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
            btn.backgroundColor = [ApplicationStyle subjectPinkColor];
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
-(void)btnDown:(UIButton *)btn{
    if (btn.tag == BTNTAG) {
        
    }else{
        [self.delegate uncomfortableArr:_addDataArr];
    }   
}
-(void)uncomfortableBtnDown:(UIButton *)btn{
    NSInteger num = [[NSString stringWithFormat:@"%@",_addDataArr[btn.tag - LIFEHABITTAG]] intValue] - 1;
                     
    btn.selected = !btn.selected;
    switch (btn.tag - LIFEHABITTAG) {
        case Uncomfortable_TT:{
            if ([_addDataArr[btn.tag - LIFEHABITTAG] isEqualToString:@"0"]) {
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG +1]];
            }else{
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG - num]];
            }
            
            if (btn.selected) {
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_TT"] forState:UIControlStateNormal];
                [btn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectPinkColor];
                
                return;
            }else{
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_TT_X"] forState:UIControlStateNormal];
                [btn setTitleColor:[@"dedede" hexStringToColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectWithColor];
                return;
            }
            break;
        }
        case Uncomfortable_BD:  {
            if ([_addDataArr[btn.tag - LIFEHABITTAG] isEqualToString:@"0"]) {
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG +1]];
            }else{
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG - num]];
            }
            
            if (btn.selected) {
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_BD"] forState:UIControlStateNormal];
                [btn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectPinkColor];
                return;
            }else{
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_BD_X"] forState:UIControlStateNormal];
                [btn setTitleColor:[@"dedede" hexStringToColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectWithColor];
                return;
            }
            break;
        }
        case Uncomfortable_HELY:{
            if ([_addDataArr[btn.tag - LIFEHABITTAG] isEqualToString:@"0"]) {
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG +1]];
            }else{
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG - num]];
            }
            
            if (btn.selected) {
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_LY"] forState:UIControlStateNormal];
                [btn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectPinkColor];
                return;
            }else{
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_LY_X"] forState:UIControlStateNormal];
                [btn setTitleColor:[@"dedede" hexStringToColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectWithColor];
                return;
            }
            break;
        }
        case Uncomfortable_FX:{
            if ([_addDataArr[btn.tag - LIFEHABITTAG] isEqualToString:@"0"]) {
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG +1]];
            }else{
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG - num]];
            }
            
            if (btn.selected) {
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_BM"] forState:UIControlStateNormal];
                [btn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectPinkColor];
                
                return;
            }else{
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_BM_X"] forState:UIControlStateNormal];
                [btn setTitleColor:[@"dedede" hexStringToColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectWithColor];
                return;
            }
            break;
        }
        case Uncomfortable_XFZT:{
            if ([_addDataArr[btn.tag - LIFEHABITTAG] isEqualToString:@"0"]) {
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG +1]];
            }else{
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG - num]];
            }
            
            if (btn.selected) {
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_XFT"] forState:UIControlStateNormal];
                [btn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectPinkColor];
                
                return;
            }else{
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_XFT_X"] forState:UIControlStateNormal];
                [btn setTitleColor:[@"dedede" hexStringToColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectWithColor];
                return;
            }
            break;
        }
        case Uncomfortable_MSY:{
            if ([_addDataArr[btn.tag - LIFEHABITTAG] isEqualToString:@"0"]) {
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG +1]];
            }else{
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG - num]];
            }
            
            if (btn.selected) {
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_MSY"] forState:UIControlStateNormal];
                [btn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectPinkColor];
                
                return;
            }else{
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_MSY_X"] forState:UIControlStateNormal];
                [btn setTitleColor:[@"dedede" hexStringToColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectWithColor];
                return;
            }
            break;
        }
        case Uncomfortable_YS:{
            if ([_addDataArr[btn.tag - LIFEHABITTAG] isEqualToString:@"0"]) {
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG +1]];
            }else{
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG - num]];
            }
            
            if (btn.selected) {
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_YS"] forState:UIControlStateNormal];
                [btn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectPinkColor];
                
                return;
            }else{
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_YS_X"] forState:UIControlStateNormal];
                [btn setTitleColor:[@"dedede" hexStringToColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectWithColor];
                return;
            }
            break;
        }
        case Uncomfortable_HSST:{
            if ([_addDataArr[btn.tag - LIFEHABITTAG] isEqualToString:@"0"]) {
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG +1]];
            }else{
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG - num]];
            }
            
            if (btn.selected) {
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_HSST"] forState:UIControlStateNormal];
                [btn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectPinkColor];
                
                return;
            }else{
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_HSST_X"] forState:UIControlStateNormal];
                [btn setTitleColor:[@"dedede" hexStringToColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectWithColor];
                return;
            }
            break;
        }
        case Uncomfortable_RFZT:{
            if ([_addDataArr[btn.tag - LIFEHABITTAG] isEqualToString:@"0"]) {
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG +1]];
            }else{
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG - num]];
            }
            
            if (btn.selected) {
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_RFZT"] forState:UIControlStateNormal];
                [btn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectPinkColor];
                
                return;
            }else{
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_RFZT_X"] forState:UIControlStateNormal];
                [btn setTitleColor:[@"dedede" hexStringToColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectWithColor];
                return;
            }
            break;
        }
        case Uncomfortable_RFCT:{
            if ([_addDataArr[btn.tag - LIFEHABITTAG] isEqualToString:@"0"]) {
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG +1]];
            }else{
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG - num]];
            }
            
            if (btn.selected) {
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_RFCT"] forState:UIControlStateNormal];
                [btn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectPinkColor];
                
                return;
            }else{
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_RFCT_X"] forState:UIControlStateNormal];
                [btn setTitleColor:[@"dedede" hexStringToColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectWithColor];
                return;
            }
            break;
        }
        case Uncomfortable_BDYC:{
            if ([_addDataArr[btn.tag - LIFEHABITTAG] isEqualToString:@"0"]) {
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG +1]];
            }else{
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG - num]];
            }
            
            if (btn.selected) {
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_BDYC"] forState:UIControlStateNormal];
                [btn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectPinkColor];
                
                return;
            }else{
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_BDYC_X"] forState:UIControlStateNormal];
                [btn setTitleColor:[@"dedede" hexStringToColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectWithColor];
                return;
            }
            break;
        }
        case Uncomfortable_QT:{
            if ([_addDataArr[btn.tag - LIFEHABITTAG] isEqualToString:@"0"]) {
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG +1]];
            }else{
                [_addDataArr replaceObjectAtIndex:btn.tag - LIFEHABITTAG withObject:[NSString stringWithFormat:@"%ld",btn.tag - LIFEHABITTAG - num]];
            }
            
            if (btn.selected) {
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_QT"] forState:UIControlStateNormal];
                [btn setTitleColor:[ApplicationStyle subjectWithColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ApplicationStyle subjectPinkColor];
                
                return;
            }else{
                [btn setImage:[UIImage imageNamed:@"NLHClen_BSF_QT_X"] forState:UIControlStateNormal];
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
