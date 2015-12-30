//
//  NLIndividuaFormatViewController.m
//  NBlue
//
//  Created by LYD on 15/11/25.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLIndividuaFormatViewController.h"
#import "NLIndividuaFormaCell.h"
#import "NLIndividuaEditingViewController.h"
#import "UIImageView+WebCache.h"
#import "NLPickView.h"
static const NSInteger BTNPHOTO = 4000;

@interface NLIndividuaFormatViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,NLPickViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableDictionary *individuaDataDic;
@property(nonatomic,strong)NSMutableDictionary *userCountDataDic;
@property(nonatomic,strong)UIView *viewPhoto;
@property(nonatomic,strong)UIImagePickerController *picker;
@property(nonatomic,strong)UIButton *blackView;
@property(nonatomic,strong)NLIndividuaFormaCell *cell;
@property(nonatomic,strong)UIImageView *userHeadImage;
@property(nonatomic,strong)NLPickView *pickerView;
@property(nonatomic,strong)NSMutableArray *headArray;
@property(nonatomic,strong)NSMutableArray *measArray;
@property(nonatomic,strong)NSMutableArray *periodArray;
@property(nonatomic,strong)NSMutableDictionary *userDataDic;



@end

@implementation NLIndividuaFormatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    {
        self.navBarBack.hidden = YES;
        self.navBarPushBack.hidden = NO;
        self.controllerBack.hidden = YES;
    }
    
    _headArray = [NSMutableArray array];
    _measArray = [NSMutableArray array];
    _periodArray = [NSMutableArray array];
    
    
    
    self.titles.text = NSLocalizedString(@"NLIndividuaFormat_Title", nil);
    [self buildData];
    [self bulidUI];
    [self imagePicker];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark 基础数据
-(void)buildData{
    
    {
        NSArray *headNameArr = @[NSLocalizedString(@"NLIndividuaFormat_HeadImage", nil),
                                 NSLocalizedString(@"NLIndividuaFormat_UserName", nil)];
        NSArray *measUrements = @[NSLocalizedString(@"NLIndividuaFormat_UserAge", nil),
                                  NSLocalizedString(@"NLIndividuaFormat_UserHeight", nil),
                                  NSLocalizedString(@"NLIndividuaFormat_UserWidth", nil)];
        NSArray *period = @[NSLocalizedString(@"NLIndividuaFormat_UserPeriod", nil),
                            NSLocalizedString(@"NLIndividuaFormat_UserCycle", nil)];
        _individuaDataDic = [NSMutableDictionary dictionary];
        [_individuaDataDic setValue:headNameArr forKey:@"headNameArr"];
        [_individuaDataDic setValue:measUrements forKey:@"measUrements"];
        [_individuaDataDic setValue:period forKey:@"period"];
    }
    
    {
        
        
        
        
        _userCountDataDic = [NSMutableDictionary dictionary];
        
        _userCountDataDic = [PlistData getIndividuaData];
//        [_userCountDataDic setValue:@"www.baidu.com" forKey:@"imageUrl"];
//        [_userCountDataDic setValue:@"小丑" forKey:@"userName"];
//        [_userCountDataDic setValue:@"22" forKey:@"age"];
//        [_userCountDataDic setValue:@"178" forKey:@"height"];
//        [_userCountDataDic setValue:@"23" forKey:@"width"];
//        [_userCountDataDic setValue:@"无" forKey:@"periodTime"];
//        [_userCountDataDic setValue:@"无" forKey:@"cycleTime"];
    }
    
}
#pragma mark 基础UI
-(void)bulidUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize], SCREENWIDTH, SCREENHEIGHT - ([ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize])) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [ApplicationStyle subjectBackViewColor];
    [self.view addSubview:_tableView];
}

-(void)imagePicker{
    _blackView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    _blackView.backgroundColor = [UIColor blackColor];
    _blackView.alpha = 0.5;
    _blackView.hidden = YES;
    [_blackView addTarget:self action:@selector(blackViewDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_blackView];
    
    
    
    _viewPhoto = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT + [ApplicationStyle control_height:110 * 3], SCREENWIDTH, [ApplicationStyle control_height:110 * 3] + [ApplicationStyle control_height:8])];
    _viewPhoto.layer.borderColor = [ApplicationStyle SubjectCustomLineColor].CGColor;
    _viewPhoto.layer.borderWidth = 0.5;
    _viewPhoto.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_viewPhoto];
    
    NSArray *arrLab = @[@"拍照",@"从相册选取",@"取消"];
    for (NSInteger i=0; i<arrLab.count; i++) {
        UIButton *btnPhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnPhoto.frame = CGRectMake(0, 0+i*[ApplicationStyle control_height:110], SCREENWIDTH, [ApplicationStyle control_height:110]);
        if (i==2) {
            btnPhoto.frame = CGRectMake(0, [ApplicationStyle control_height:8]+i*[ApplicationStyle control_height:110], SCREENWIDTH, [ApplicationStyle control_height:110]);
        }
        [btnPhoto setTitle:arrLab[i] forState:UIControlStateNormal];
        [btnPhoto setTitleColor:[@"353535" hexStringToColor] forState:UIControlStateNormal];
        btnPhoto.titleLabel.font = [UIFont systemFontOfSize:14];
        btnPhoto.tag = BTNPHOTO+i;
        [btnPhoto addTarget:self action:@selector(btnPhotoDown:) forControlEvents:UIControlEventTouchUpInside];
        [_viewPhoto addSubview:btnPhoto];
    }
    
    for (NSInteger i=0; i<2; i++) {
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle control_height:110]+i*[ApplicationStyle control_height:110], SCREENWIDTH, 1)];
        if (i==1) {
            viewLine.frame = CGRectMake(0, [ApplicationStyle control_height:110]+i*[ApplicationStyle control_height:110], SCREENWIDTH, 4);
        }
        viewLine.backgroundColor = [ApplicationStyle SubjectCustomLineColor];
        [_viewPhoto addSubview:viewLine];
    }
}

#pragma mark 系统Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _individuaDataDic.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [ApplicationStyle control_height:30];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return [ApplicationStyle control_height:170];
        }else{
            return [ApplicationStyle control_height:88];
        }
    }else if (indexPath.section == 1){
        return [ApplicationStyle control_height:88];
    }else{
        return [ApplicationStyle control_height:88];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return [[_individuaDataDic objectForKey:@"headNameArr"] count];
    }else if (section == 1){
        return [[_individuaDataDic objectForKey:@"measUrements"] count];
    }else {
        return [[_individuaDataDic objectForKey:@"period"] count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"LYD";
    _cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!_cell) {
        _cell = [[NLIndividuaFormaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        UIView *viewLineOn = [[UIView alloc] init];
        viewLineOn.backgroundColor = [ApplicationStyle subjectLineViewColor];
        viewLineOn.tag = 100;
        [_cell addSubview:viewLineOn];
        
        UIView *viewLineUnder = [[UIView alloc] init];
        viewLineUnder.backgroundColor = [ApplicationStyle subjectLineViewColor];
        viewLineUnder.tag = 200;
        [_cell addSubview:viewLineUnder];
    }
    UILabel *viewLineOn = (UILabel *)[_cell viewWithTag:100];
    UILabel *viewLineUnder = (UILabel *)[_cell viewWithTag:200];
    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            _cell.cellHeadTitleLab.frame = CGRectMake([ApplicationStyle control_weight:36], 0, [ApplicationStyle control_weight:300], [ApplicationStyle control_height:170]);
            _cell.imageArrow.frame = CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:24] - [ApplicationStyle control_weight:16], ([ApplicationStyle control_height:170] - [ApplicationStyle control_height:24])/2, [ApplicationStyle control_weight:16], [ApplicationStyle control_height:24]);
            _userHeadImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:54] - [ApplicationStyle control_weight:120], ([ApplicationStyle control_height:170] - [ApplicationStyle control_height:120])/2, [ApplicationStyle control_weight:120], [ApplicationStyle control_height:120])];
            
            
            
            [_cell addSubview:_userHeadImage];
            _cell.cellimageUrl.hidden = YES;

        }
        _cell.cellHeadTitleLab.text = [[_individuaDataDic objectForKey:@"headNameArr"] objectAtIndex:indexPath.row];
        
        
        if (indexPath.row==0) {
            [_cell.imageArrow sd_setImageWithURL:[NSURL URLWithString:[_userCountDataDic objectForKey:@"imageUrl"]] placeholderImage:nil];
        }else{
            _cell.cellimageUrl.text = [_userCountDataDic objectForKey:@"userName"];
        }

        
    }else if (indexPath.section == 1){
        
        _cell.cellHeadTitleLab.text = [[_individuaDataDic objectForKey:@"measUrements"] objectAtIndex:indexPath.row];
        
        if (indexPath.row==0) {
           _cell.cellimageUrl.text = [_userCountDataDic objectForKey:@"age"];
        }else if (indexPath.row == 1){
            _cell.cellimageUrl.text = [_userCountDataDic objectForKey:@"height"];
        }else{
            _cell.cellimageUrl.text = [_userCountDataDic objectForKey:@"width"];
        }
    }else{
        _cell.cellHeadTitleLab.text = [[_individuaDataDic objectForKey:@"period"] objectAtIndex:indexPath.row];
        
        if (indexPath.row==0) {
            _cell.cellimageUrl.text = [_userCountDataDic objectForKey:@"periodTime"];
        }else{
            _cell.cellimageUrl.text = [_userCountDataDic objectForKey:@"cycleTime"];
        }
    }
    
    [self cellLineView:indexPath viewLineOn:viewLineOn viewLineUnder:viewLineUnder cell:_cell];
    
    
    return _cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                _blackView.hidden = NO;
                [UIView animateWithDuration:0.5 animations:^{
                    _viewPhoto.frame = CGRectMake(0, SCREENHEIGHT-([ApplicationStyle control_height:110 * 3] + [ApplicationStyle control_height:8]), SCREENWIDTH,[ApplicationStyle control_height:110 * 3] + [ApplicationStyle control_height:8]);
                }];
                break;
            }
            case 1:
            {
                NLIndividuaEditingViewController *vc = [[NLIndividuaEditingViewController alloc] init];
                vc.editionName = ^(NSString * userName){
//                    [_headArray replaceObjectAtIndex:indexPath.row withObject:userName];
                    [_userCountDataDic setValue:userName forKey:@"userName"];
                    [_tableView reloadData];
                };
                [self presentViewController:vc animated:YES completion:^{
                    
                }];
                break;
            }
            default:
                break;
        }
    }else if (indexPath.section == 1){
        _blackView.hidden = NO;
        switch (indexPath.row) {
            case 0:
            {
                [self pickerView:PickerType_Age];

                break;
            }
            case 1:
            {
                [self pickerView:PickerType_Height];
                break;
            }
            case 2:
            {
                [self pickerView:PickerType_Width];
                break;
            }
            default:
                break;
        }
    }else{
        _blackView.hidden = NO;
        switch (indexPath.row) {
            case 0:
            {
                [self datePickView:UseDatePicker_Period];
                break;
            }
            case 1:
            {
                [self datePickView:UseDatePicker_Cycle];
                break;
            }
            default:
                break;
        }
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_picker dismissViewControllerAnimated:YES completion:nil];
    
    
    _userHeadImage.image = image;
    _blackView.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        _viewPhoto.frame = CGRectMake(0, SCREENHEIGHT+([ApplicationStyle control_height:110 * 3] + [ApplicationStyle control_height:8]), SCREENWIDTH, [ApplicationStyle control_height:110 * 3] + [ApplicationStyle control_height:8]);
    }];
}

#pragma mark 自己的Delegate
-(void)pickerCount:(NSString *)count seleType:(NSInteger)type pickerType:(NSInteger)pickType{
    [self pickerViewFramkeHide];
    switch (type) {
        case SeleType_Cancel:
        {
            _blackView.hidden = YES;
            break;
        }
        case SeleType_OK:
        {
            switch (pickType) {
                case PickerType_Age:
                {
//                    [_measArray replaceObjectAtIndex:pickType withObject:count];
                    [_userCountDataDic setValue:count forKey:@"age"];
                    break;
                }
                case PickerType_Height:
                {
//                    [_measArray replaceObjectAtIndex:pickType withObject:count];
                    [_userCountDataDic setValue:count forKey:@"height"];
                    break;
                }
                case PickerType_Width:
                {
//                    [_measArray replaceObjectAtIndex:pickType withObject:count];
                    [_userCountDataDic setValue:count forKey:@"width"];
                    break;
                }
                default:
                    break;
            }
            _blackView.hidden = YES;
            break;
        }
        default:
            break;
    }
    
    [_tableView reloadSections:[[NSIndexSet alloc] initWithIndex:1] withRowAnimation:NO];
    
}

-(void)datePicker:(NSDate *)date cancel:(NSInteger)cancelType useDatePicker:(NSInteger)useDatePicker{
    [self pickerViewFramkeHide];
    switch (cancelType) {
        case SeleType_Cancel:
        {
            _blackView.hidden = YES;
            break;
        }
        case SeleType_OK:
        {
            switch (useDatePicker) {
                case UseDatePicker_Period:
                {
//                    [_periodArray replaceObjectAtIndex:useDatePicker withObject:[ApplicationStyle datePickerTransformationCorss:date]];
                    
                    [_userCountDataDic setValue:[ApplicationStyle datePickerTransformationCorss:date] forKey:@"periodTime"];
                    
                    break;
                }
                case UseDatePicker_Cycle:
                {
//                    [_periodArray replaceObjectAtIndex:useDatePicker withObject:[ApplicationStyle datePickerTransformationCorss:date]];
                    [_userCountDataDic setValue:[ApplicationStyle datePickerTransformationCorss:date] forKey:@"cycleTime"];
                    break;
                }
                default:
                    break;
            }
            _blackView.hidden = YES;
            break;
        }
        default:
            break;
    }
    [_tableView reloadSections:[[NSIndexSet alloc] initWithIndex:2] withRowAnimation:NO];
}
#pragma mark 自己的按钮事件
-(void)btnPhotoDown:(UIButton *)btn{
    switch (btn.tag) {
        case BTNPHOTO:
        {
            _picker = [[UIImagePickerController alloc] init];
            _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            _picker.allowsEditing = NO;
            _picker.delegate = self;
            [self presentViewController:_picker animated:YES completion:nil];
            
            break;
        }
        case BTNPHOTO + 1:
        {
            _picker = [[UIImagePickerController alloc] init];
            _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            _picker.allowsEditing = YES;
            _picker.delegate = self;
            [self presentViewController:_picker animated:YES completion:nil];
            
            break;
        }
        case BTNPHOTO + 2:
        {
            _blackView.hidden = YES;
            [UIView animateWithDuration:0.5 animations:^{
                _viewPhoto.frame = CGRectMake(0, SCREENHEIGHT+([ApplicationStyle control_height:110 * 3] + [ApplicationStyle control_height:8]), SCREENWIDTH, [ApplicationStyle control_height:110 * 3] + [ApplicationStyle control_height:8]);
            }];
            
            break;
        }
        default:
            break;
    }
}
#pragma mark Cell线
-(void)cellLineView:(NSIndexPath *)indexPath
         viewLineOn:(UIView *)viewLineOn
      viewLineUnder:(UIView *)viewLineUnder
               cell:(NLIndividuaFormaCell *)cell{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            viewLineOn.frame = CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:2]);
        }else if (indexPath.row == [[_individuaDataDic objectForKey:@"headNameArr"] count] -1){
            viewLineOn.frame = CGRectMake([ApplicationStyle control_weight:20], 0, SCREENWIDTH - [ApplicationStyle control_weight:20], [ApplicationStyle control_height:2]);
            viewLineUnder.frame = CGRectMake(0, cell.frame.size.height - [ApplicationStyle control_height:2], SCREENWIDTH, [ApplicationStyle control_height:2]);
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            viewLineOn.frame = CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:2]);
        }else if (indexPath.row == [[_individuaDataDic objectForKey:@"measUrements"] count] -1){
            viewLineOn.frame = CGRectMake([ApplicationStyle control_weight:20], 0, SCREENWIDTH - [ApplicationStyle control_weight:20], [ApplicationStyle control_height:2]);
            viewLineUnder.frame = CGRectMake(0, cell.frame.size.height - [ApplicationStyle control_height:2], SCREENWIDTH, [ApplicationStyle control_height:2]);
        }else{
            viewLineOn.frame = CGRectMake([ApplicationStyle control_weight:20], 0, SCREENWIDTH - [ApplicationStyle control_weight:20], [ApplicationStyle control_height:2]);
        }
    }else{
        if (indexPath.row == 0) {
            viewLineOn.frame = CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:2]);
        }else if (indexPath.row == [[_individuaDataDic objectForKey:@"period"] count] -1){
            viewLineOn.frame = CGRectMake([ApplicationStyle control_weight:20], 0, SCREENWIDTH - [ApplicationStyle control_weight:20], [ApplicationStyle control_height:2]);
            viewLineUnder.frame = CGRectMake(0, [ApplicationStyle control_height:88] - [ApplicationStyle control_height:2], SCREENWIDTH, [ApplicationStyle control_height:2]);
        }
    }
}
#pragma mark pickerView出现
-(void)pickerView:(NSInteger)index{
    _pickerView = [[NLPickView alloc] initWithPickTye:index];
    _pickerView.frame = CGRectMake(0, SCREENHEIGHT + [ApplicationStyle control_height:560], SCREENWIDTH, [ApplicationStyle control_height:560]);
    _pickerView.delegate = self;
    [UIView animateWithDuration:0.5 animations:^{
        _pickerView.frame = CGRectMake(0, SCREENHEIGHT-[ApplicationStyle control_height:560], SCREENWIDTH, [ApplicationStyle control_height:560]);
    }];
    [self.view addSubview:_pickerView];
}

#pragma mark datePick出现
-(void)datePickView:(NSInteger)index{
    _pickerView = [[NLPickView alloc] initWithDateStyleType:DatePickerType_YearMothDay useDatePicker:index];
    _pickerView.frame = CGRectMake(0, SCREENHEIGHT + [ApplicationStyle control_height:560], SCREENWIDTH, [ApplicationStyle control_height:560]);
    _pickerView.delegate = self;
    [UIView animateWithDuration:0.5 animations:^{
        _pickerView.frame = CGRectMake(0, SCREENHEIGHT-[ApplicationStyle control_height:560], SCREENWIDTH, [ApplicationStyle control_height:560]);
    }];
    [self.view addSubview:_pickerView];
}


#pragma mark 黑色背景
-(void)blackViewDown{
    _blackView.hidden = YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        _viewPhoto.frame = CGRectMake(0, SCREENHEIGHT+([ApplicationStyle control_height:110 * 3] + [ApplicationStyle control_height:8]), SCREENWIDTH,[ApplicationStyle control_height:110 * 3] + [ApplicationStyle control_height:8]);
    }];
    
    [self pickerViewFramkeHide];
}

-(void)pickerViewFramkeHide{
    [UIView animateWithDuration:0.5 animations:^{
        _pickerView.frame = CGRectMake(0, SCREENHEIGHT + [ApplicationStyle control_height:560], SCREENWIDTH, [ApplicationStyle control_height:560]);
    }];
}
-(void)returnBtnDown{
    

    

    
    
    [PlistData individuaData:_userCountDataDic];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
