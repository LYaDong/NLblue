//
//  NLCalenderPicker.m
//  NBlue
//
//  Created by LYD on 15/12/15.
//  Copyright © 2015年 LYD. All rights reserved.
//
static const NSInteger PICKERTAG = 1000;
static const NSInteger IMAGETAG = 2000;
static const NSInteger TITLETAG = 3000;
static const NSInteger BTNTAG = 4000;

#import "NLCalenderPicker.h"
@interface NLCalenderPicker()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)NSArray *imageArr;
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,assign)NSInteger choicePickerIndex;
@end
@implementation NLCalenderPicker
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}
-(void)buildUI{
    
    _imageArr = @[@"NLHClen_AA_I_XX",
                  @"NLHClen_AA_I_BYT",
                  @"NLHClen_AA_I_BYY",
                  @"NLHClen_AA_I_BYT_NO"];
    _titleArr = @[NSLocalizedString(@"NLHealthCalender_Picker_MYZ", nil),
                  NSLocalizedString(@"NLHealthCalender_Picker_DTZ", nil),
                  NSLocalizedString(@"NLHealthCalender_Picker_CLSHY", nil),
                  NSLocalizedString(@"NLHealthCalender_Picker_WBHCS", nil),];

    
    
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:40], 0, SCREENWIDTH - [ApplicationStyle control_weight:80], [ApplicationStyle control_height:500])];
    backView.backgroundColor = [ApplicationStyle subjectWithColor];
    backView.layer.cornerRadius = [ApplicationStyle control_weight:10];
    [self addSubview:backView];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, backView.viewWidth, [ApplicationStyle  control_height:80])];
    titleLab.text = NSLocalizedString(@"NLHealthCalender_Picker_Title", nil);
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [ApplicationStyle textThrityFont];
    titleLab.textColor = [ApplicationStyle subjectPinkColor];
    [backView addSubview:titleLab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:10], [ApplicationStyle control_height:80], backView.viewWidth - [ApplicationStyle control_weight:20], [ApplicationStyle control_height:1])];
    line.backgroundColor = [@"f5d6d6" hexStringToColor];
    [backView addSubview:line];
    
    _pickerView = [[UIPickerView  alloc] initWithFrame:CGRectMake(0, titleLab.bottomOffset, backView.viewWidth,backView.viewHeight - [ApplicationStyle control_height:160])];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.tag = PICKERTAG;
    _pickerView.clipsToBounds = YES;
    _pickerView.showsSelectionIndicator = YES;
    [backView addSubview:_pickerView];
    
    
    
    
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

#pragma mark 系统代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _titleArr.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 1;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return [ApplicationStyle control_height:60];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (view == nil) {
        view = [[UIView alloc] init];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-[ApplicationStyle control_weight:100], ([ApplicationStyle control_height:60] - [ApplicationStyle control_height:40])/2, [ApplicationStyle control_weight:40], [ApplicationStyle control_height:40])];
        imageView.tag = IMAGETAG;
        [view addSubview:imageView];
        
        UILabel *labCount = [[UILabel alloc] initWithFrame:CGRectMake(-[ApplicationStyle control_weight:50], 0, [ApplicationStyle control_weight:180], [ApplicationStyle control_height:60])];
        labCount.tag = TITLETAG;
        labCount.font = [ApplicationStyle textThrityFont];
        labCount.textAlignment = NSTextAlignmentCenter;
        labCount.textColor = [ApplicationStyle subjectPinkColor];
//        labCount.backgroundColor = [UIColor redColor];
        [view addSubview:labCount];
    }
    
    UILabel *labCount = (UILabel*)[view viewWithTag:TITLETAG];
    labCount.text = [_titleArr objectAtIndex:row];
    UIImageView *image = (UIImageView *)[view viewWithTag:IMAGETAG];
    image.image = [UIImage imageNamed:_imageArr[row]];
    return view;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _choicePickerIndex = row;
}
#pragma mark 自己的代理
#pragma mark 按钮事件

-(void)btnDown:(UIButton *)btn{
    if (btn.tag == BTNTAG) {
        [self.delegate pickerIndex:10];
    }else{
        [self.delegate pickerIndex:_choicePickerIndex];
    }
    
    
//    isMenstruation : @"menstruation,"
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
