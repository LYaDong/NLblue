//
//  NLPickView.m
//  NBlue
//
//  Created by LYD on 15/11/26.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLPickView.h"
static const NSInteger SelectionBtn = 1000;                                 //pickerView上的Btn 按钮Tag
static const NSInteger PICKERTAG = 3000;                                    //pickerView的Tag
static const NSInteger LBLTAG = 2000;                                       //pickerView 上的Lab Tag
static const NSInteger DATEPICKERTAGBTN = 4000;                             //时间控件商的Btn 按钮Tag
@interface NLPickView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIView *viewBackTime;
@property(nonatomic,strong)NSString *data;
@property(nonatomic,assign)NSInteger picktype;
@property(nonatomic,assign)NSInteger datePickerType;
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)UIDatePicker *datePicker;
@property(nonatomic,assign)NSInteger pickerNum;
@end
@implementation NLPickView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _dataArray = [NSMutableArray array];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
}
-(void)viewWillDisappear:(BOOL)animated{
    _pickerView.delegate = nil;
}
- (instancetype)initWithDateStyleType:(NSInteger)dateStyleType useDatePicker:(NSInteger)useDatePicker{
    if (self = [super init]) {
        _datePickerType = useDatePicker;
        [self dateYearMothDayDateSytleType:dateStyleType];
    }
    return self;
}

- (instancetype)initWithPickTye:(NSInteger)picktype{
    if (self = [super init]) {
        _picktype = picktype;
        switch (picktype) {
            case PickerType_Age:
            {
                for (NSInteger i = 10; i <= 55; i++) {
                    [self.dataArray addObject:[NSString stringWithFormat:@"%ld",(long)i]];
                }
                break;
            }
            case PickerType_Height:
            {
                for (NSInteger i = 120; i <= 200; i++) {
                    [self.dataArray addObject:[NSString stringWithFormat:@"%ld",(long)i]];
                }
                break;
            }
            case PickerType_Width:
            {
                for (NSInteger i = 25; i <= 100; i++) {
                    [self.dataArray addObject:[NSString stringWithFormat:@"%ld",(long)i]];
                }
                break;
            }
            case PickerType_Cycle:
            {
                for (NSInteger i = 5; i <= 50; i++) {
                    [self.dataArray addObject:[NSString stringWithFormat:@"%ld",(long)i]];
                }
                break;
            }
            case PickerType_Period:
            {
                for (NSInteger i = 1; i <= 50; i++) {
                    [self.dataArray addObject:[NSString stringWithFormat:@"%ld",(long)i]];
                }
                break;
            }
            default:
                break;
        }
        
        
        _viewBackTime = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:560])];
        _viewBackTime.backgroundColor = [UIColor whiteColor];
        [self addSubview:_viewBackTime];
        
        UIView *viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:80])];
        viewBack.backgroundColor = [ApplicationStyle subJectNavBarColor];
        [self.viewBackTime addSubview:viewBack];
        
        NSArray *arr = @[NSLocalizedString(@"GeneralText_Cancel", nil),NSLocalizedString(@"GeneralText_OK", nil)];
        for (NSInteger i=0; i<arr.count; i++)
        {
            UIButton *selectionPickerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            selectionPickerBtn.frame = CGRectMake([ApplicationStyle control_weight:60]+i*(SCREENWIDTH-[ApplicationStyle control_weight:200]), [ApplicationStyle control_height:10], [ApplicationStyle control_weight:80], [ApplicationStyle control_height:60]);
            [selectionPickerBtn setTitle:arr[i] forState:UIControlStateNormal];
            [selectionPickerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            selectionPickerBtn.layer.borderColor= [UIColor whiteColor].CGColor;
            selectionPickerBtn.tag = SelectionBtn+i;
            selectionPickerBtn.layer.cornerRadius=5;
            selectionPickerBtn.layer.borderWidth=1;
            [selectionPickerBtn addTarget:self action:@selector(selectionPickerBtnDown:) forControlEvents:UIControlEventTouchUpInside];
            [_viewBackTime addSubview:selectionPickerBtn];
        }
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle control_height:160], SCREENWIDTH, [ApplicationStyle control_height:400])];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.tag = PICKERTAG;
        _pickerView.clipsToBounds = YES;
        _pickerView.showsSelectionIndicator = YES;
        [_viewBackTime addSubview:_pickerView];
        
        switch (picktype) {
            case PickerType_Age:
            {
                [_pickerView selectRow:20 - 10 inComponent:0 animated:YES];
                _data = @"20";
                break;
            }
            case PickerType_Height:
            {
                [_pickerView selectRow:165 - 120 inComponent:0 animated:YES];
                _data = @"165";
                break;
            }
            case PickerType_Width:
            {
                [_pickerView selectRow:45 - 25 inComponent:0 animated:YES];
                _data = @"45";
                break;
            }
            case PickerType_Cycle:{
                [_pickerView selectRow:0 inComponent:0 animated:YES];
                _data = @"5";
                break;
            }
            case PickerType_Period:{
                [_pickerView selectRow:0 inComponent:0 animated:YES];
                _data = @"1";
                break;
            }
            default:
                break;
        }
    }
    return self;
}


- (void)dateYearMothDayDateSytleType:(NSInteger)dateSytleType{
    
    _viewBackTime = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:560])];
    _viewBackTime.backgroundColor = [UIColor whiteColor];
    [self addSubview:_viewBackTime];
    
    UIView *viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:80])];
    viewBack.backgroundColor = [ApplicationStyle subJectNavBarColor];
    [_viewBackTime addSubview:viewBack];
    
    NSArray *arr = @[NSLocalizedString(@"GeneralText_Cancel", nil),NSLocalizedString(@"GeneralText_OK", nil)];
    for (NSInteger i=0; i<arr.count; i++)
    {
        UIButton *selectionDateBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        selectionDateBtn.frame = CGRectMake([ApplicationStyle control_weight:60]+i*(SCREENWIDTH-[ApplicationStyle control_weight:200]), [ApplicationStyle control_height:10], [ApplicationStyle control_weight:80], [ApplicationStyle control_height:60]);
        [selectionDateBtn setTitle:arr[i] forState:UIControlStateNormal];
        [selectionDateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        selectionDateBtn.layer.borderColor= [UIColor whiteColor].CGColor;
        selectionDateBtn.tag = DATEPICKERTAGBTN+i;
        selectionDateBtn.layer.cornerRadius=5;
        selectionDateBtn.layer.borderWidth=1;
        [selectionDateBtn addTarget:self action:@selector(selectionDateBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        [_viewBackTime addSubview:selectionDateBtn];
    }
    
    switch (dateSytleType) {
        case DatePickerType_YearMothDay:
        {
            UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, [ApplicationStyle control_height:80], SCREENWIDTH, [ApplicationStyle control_height:400])];
            datePicker.datePickerMode = UIDatePickerModeDate;
            datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
            _datePicker = datePicker;
            [_viewBackTime addSubview:datePicker];
            break;
        }
        case DatePickerType_WhenBranchSeconds:
        {
            UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, [ApplicationStyle control_height:80], SCREENWIDTH, [ApplicationStyle control_height:400])];
            datePicker.datePickerMode = UIDatePickerModeDateAndTime;
            datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
            _datePicker = datePicker;
            [_viewBackTime addSubview:datePicker];
            
            break;
        }
        default:
            break;
    }
}
- (instancetype)initWithMultiplePickerDateArray:(NSArray *)array num:(NSUInteger)num type:(NSInteger)pickerDateType{
    if (self = [super init]) {
        [self multiplePickerDateArray:array num:num type:pickerDateType];
    }
    return self;
}

- (void)multiplePickerDateArray:(NSArray *)array num:(NSUInteger)num type:(NSInteger)pickerDateType{
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:array];
    
    _picktype = pickerDateType;
    _pickerNum = num;
    _viewBackTime = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:560])];
    _viewBackTime.backgroundColor = [UIColor whiteColor];
    [self addSubview:_viewBackTime];
    
    UIView *viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:80])];
    viewBack.backgroundColor = [ApplicationStyle subJectNavBarColor];
    [_viewBackTime addSubview:viewBack];
    
    NSArray *arr = @[NSLocalizedString(@"GeneralText_Cancel", nil),NSLocalizedString(@"GeneralText_OK", nil)];
    for (NSInteger i=0; i<arr.count; i++)
    {
        UIButton *selectionDateBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        selectionDateBtn.frame = CGRectMake([ApplicationStyle control_weight:60]+i*(SCREENWIDTH-[ApplicationStyle control_weight:200]), [ApplicationStyle control_height:10], [ApplicationStyle control_weight:80], [ApplicationStyle control_height:60]);
        [selectionDateBtn setTitle:arr[i] forState:UIControlStateNormal];
        [selectionDateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        selectionDateBtn.layer.borderColor= [UIColor whiteColor].CGColor;
        selectionDateBtn.tag = DATEPICKERTAGBTN+i;
        selectionDateBtn.layer.cornerRadius=5;
        selectionDateBtn.layer.borderWidth=1;
        [selectionDateBtn addTarget:self action:@selector(selectionDateBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        [_viewBackTime addSubview:selectionDateBtn];
    }
    
    
    CGFloat w = SCREENWIDTH/num,h = [ApplicationStyle control_height:400];
    //    (SCREENWIDTH/num - w)/2 + i* (SCREENWIDTH/num - w)/2
    for (NSInteger i=0; i<num; i++) {
        UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0 + i * w, [ApplicationStyle control_height:160], w, h)];
        picker.delegate = self;
        picker.dataSource = self;
        picker.clipsToBounds = YES;
        picker.shouldGroupAccessibilityChildren = YES;
        [_viewBackTime addSubview:picker];
    }
    
}
#pragma mark 系统代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _dataArray.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (_picktype == PickerType_RemindSection) {
        return SCREENWIDTH/_pickerNum;
    }else{
        return 1;
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return [ApplicationStyle control_height:80];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (view == nil) {
        view = [[UIView alloc] init];
        
        UILabel *lbl = [[UILabel alloc] init];
        if (_picktype == PickerType_RemindSection) {
            lbl.frame = CGRectMake(0, 0, SCREENWIDTH/_pickerNum, [ApplicationStyle control_height:80]);
            lbl.textAlignment = NSTextAlignmentCenter;
        }else{
            lbl.frame = CGRectMake(0, 0, [ApplicationStyle control_weight:160], [ApplicationStyle control_height:80]);
            lbl.textAlignment = NSTextAlignmentLeft;
        }
        
        lbl.backgroundColor = [UIColor clearColor];
        
        lbl.textColor = [UIColor redColor];
        lbl.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:36]];
        lbl.tag = LBLTAG;
        [view addSubview:lbl];
    }
    UILabel *lbl = (UILabel*)[view viewWithTag:LBLTAG];
    
    NSLog(@"%@",_dataArray);
    lbl.text = [NSString stringWithFormat:@"%@",[_dataArray objectAtIndex:row]];
    return view;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *str = [_dataArray objectAtIndex:row];
    _data = str;
}

#pragma mark 事件按钮
-(void)selectionPickerBtnDown:(UIButton *)pickerBtn{
    switch (pickerBtn.tag) {
        case SelectionBtn:
        {
            [self.delegate pickerCount:_data seleType:pickerBtn.tag - SelectionBtn pickerType:_picktype];
            break;
        }
        case SelectionBtn + 1:
        {
            NSLog(@"%@",_data);
            
            [self.delegate pickerCount:_data seleType:pickerBtn.tag - SelectionBtn pickerType:_picktype];
            break;
        }
        default:
            break;
    }
}

-(void)selectionDateBtnDown:(UIButton *)datePickerBtn{
    switch (datePickerBtn.tag) {
        case DATEPICKERTAGBTN:
        {
            [self.delegate datePicker:nil cancel:datePickerBtn.tag - DATEPICKERTAGBTN useDatePicker:_datePickerType];
            break;
        }
        case DATEPICKERTAGBTN + 1:
        {
            NSDate *date = [_datePicker date];
            [self.delegate datePicker:date cancel:datePickerBtn.tag - DATEPICKERTAGBTN useDatePicker:_datePickerType];
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
