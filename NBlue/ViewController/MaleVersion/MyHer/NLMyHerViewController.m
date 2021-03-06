//
//  NLMyHerViewController.m
//  NBlue
//
//  Created by LYD on 16/1/6.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLMyHerViewController.h"
#import "NLMyHerPeriodCircle.h"
#import "NLTextImageView.h"
#import "NlRing.h"
#import "NLRingLine.h"
#import "NLSQLData.h"
#import "NLHyHerCell.h"
@interface NLMyHerViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIView *qrcodeBackView;
@property(nonatomic,strong)UITableView *herSleepAndSportTable;
@property(nonatomic,strong)UIButton *liftBtn;
@end

@implementation NLMyHerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [@"fffeeb" hexStringToColor];
    
    
    self.returnBtn.hidden = YES;
    self.titles.text = NSLocalizedString(@"NLMyHer_titls", nil);
    [self bulidUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self delNotification];
    [self addNotification];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self delNotification];
}
#pragma mark 基础UI
-(void)bulidUI{
    
    _herSleepAndSportTable = [[UITableView alloc] initWithFrame:CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:288], [ApplicationStyle control_height:20] + [ApplicationStyle navBarAndStatusBarSize], [ApplicationStyle control_weight:276], [ApplicationStyle control_height:176]) style:UITableViewStylePlain];
    
    _herSleepAndSportTable.delegate = self;
    _herSleepAndSportTable.dataSource = self;
    _herSleepAndSportTable.scrollEnabled = NO;
    _herSleepAndSportTable.hidden = YES;
    _herSleepAndSportTable.backgroundColor = [UIColor blackColor];
    _herSleepAndSportTable.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_herSleepAndSportTable];
    
    UIView *lines = [[UIView alloc] initWithFrame:CGRectMake([ApplicationStyle control_height:40], [ApplicationStyle control_height:87], _herSleepAndSportTable.frame.size.width - [ApplicationStyle control_weight:80], [ApplicationStyle control_height:1])];
    lines.backgroundColor = [UIColor whiteColor];
    [_herSleepAndSportTable addSubview:lines];
    
    
    
    _liftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _liftBtn.frame = CGRectMake(SCREENWIDTH - [ApplicationStyle control_weight:42 + 30], [ApplicationStyle statusBarSize]+([ApplicationStyle navigationBarSize] - [ApplicationStyle control_weight:42])/2, [ApplicationStyle control_weight:42], [ApplicationStyle control_weight:42]);
    _liftBtn.hidden = YES;
    [_liftBtn setImage:[UIImage imageNamed:@"NL_ThreeSpot"] forState:UIControlStateNormal];
    [_liftBtn addTarget:self action:@selector(liftBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_liftBtn];
    
    [self estableSqlite];
    [self loadData];
    
    
    
}
-(void)estableSqlite{
    //循环创建数据库
    [[SMProgressHUD shareInstancetype] showLoadingWithTip:@"恢复数据中，请耐心等待"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NLSQLData canlenderUncomfortable];
        [NLSQLData insterCanlenderData];
        
        [NLSQLData establishSportDataTable];
        [NLSQLData insterSportData:nil isUpdata:0];
        
        
        [NLSQLData sleepDataTable];
        [NLSQLData insterSleepData:nil isUpdata:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:EstablishDataSqliteNotification object:nil];
            [self loadStepData];
            [[SMProgressHUD shareInstancetype] dismiss];
        });
    });
}
-(void)loadData{
    [[NLDatahub sharedInstance] maleJudgeIsHave];
}
-(void)generateQRCode{
    
    _qrcodeBackView = [[UIView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle navBarAndStatusBarSize], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle navBarAndStatusBarSize] - [ApplicationStyle tabBarSize])];
    [self.view addSubview:_qrcodeBackView];
    
    UIView *qrcodeView = [[UIView alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:500])/2,[ApplicationStyle control_height:120], [ApplicationStyle control_weight:500], [ApplicationStyle control_weight:500])];
    qrcodeView.backgroundColor = [UIColor whiteColor];
    qrcodeView.layer.cornerRadius = [ApplicationStyle control_weight:10];
    qrcodeView.layer.borderColor = [@"929178" hexStringToColor].CGColor;
    qrcodeView.layer.borderWidth = [ApplicationStyle control_weight:5];
    [_qrcodeBackView addSubview:qrcodeView];
    
    UIImage *qrcode = [ApplicationStyle createNonInterpolatedUIImageFormCIImage:
                       [ApplicationStyle createQRForString:
                        [kAPPDELEGATE._loacluserinfo GetUser_ID]] withSize:SCREENWIDTH];
    UIImageView *imagex = [[UIImageView alloc] initWithFrame:CGRectMake((qrcodeView.viewWidth - [ApplicationStyle control_weight:360])/2, [ApplicationStyle control_height:70], [ApplicationStyle control_height:360], [ApplicationStyle control_height:360])];
    imagex.image =  qrcode;
    imagex.backgroundColor = [UIColor redColor];
    [qrcodeView addSubview:imagex];
    
    NSString *labTextStr = NSLocalizedString(@"NLMyHer_TitleQocodeText", nil);
    CGSize labTextSize = [ApplicationStyle textSize:labTextStr font:[UIFont systemFontOfSize:[ApplicationStyle control_weight:36]] size:SCREENWIDTH - [ApplicationStyle control_weight:120]];
    
    UILabel *labText = [[UILabel alloc] initWithFrame:CGRectMake((_qrcodeBackView.viewWidth - labTextSize.width)/2, qrcodeView.bottomOffset + [ApplicationStyle control_height:70], labTextSize.width, labTextSize.height)];
    labText.text = labTextStr;
    labText.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:36]];
    labText.textColor = [@"de9124" hexStringToColor];
    labText.textAlignment = NSTextAlignmentCenter;
    labText.numberOfLines = 0;
    [_qrcodeBackView addSubview:labText];
    
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnAdd.frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:166])/2, labText.bottomOffset+[ApplicationStyle control_height:20], [ApplicationStyle control_weight:166], [ApplicationStyle control_height:30]);
    [btnAdd setTitle:NSLocalizedString(@"NLMyHer_BtnAdd", nil) forState:UIControlStateNormal];
    [btnAdd setTitleColor:[@"959595" hexStringToColor] forState:UIControlStateNormal];
    btnAdd.titleLabel.font = [ApplicationStyle textThrityFont];
    [btnAdd addTarget:self action:@selector(btnAddDown) forControlEvents:UIControlEventTouchUpInside];
    [_qrcodeBackView addSubview:btnAdd];
    
}
-(void)periodCircleView{
    NLMyHerPeriodCircle *periodView = [[NLMyHerPeriodCircle alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:400])/2, [ApplicationStyle navBarAndStatusBarSize] + [ApplicationStyle control_height:110], [ApplicationStyle control_weight:400], [ApplicationStyle control_weight:400])];
    [self.view addSubview:periodView];
    
    {
        NSString *str = @"距离大姨妈\n还有12天";
        
        CGSize textPeriodSize = [ApplicationStyle textSize:str font:[UIFont systemFontOfSize:[ApplicationStyle control_weight:42]] size:SCREENWIDTH];
        
        UILabel *periodText = [[UILabel alloc] initWithFrame:CGRectMake((SCREENWIDTH - textPeriodSize.width)/2, [ApplicationStyle navBarAndStatusBarSize] + [ApplicationStyle control_height:260], textPeriodSize.width, textPeriodSize.height)];
        periodText.textAlignment = NSTextAlignmentCenter;
        periodText.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:42]];
        periodText.text = str;
        periodText.textColor = [@"a66d1b" hexStringToColor];
        periodText.numberOfLines = 0;
        [self.view addSubview:periodText];
    }
    
    
    
    {
        UILabel *labtext = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:85], periodView.bottomOffset, [ApplicationStyle control_weight:162], [ApplicationStyle control_height:30])];
        labtext.text = @"今日易孕期";
        labtext.textColor = [@"a66d1b" hexStringToColor];
        labtext.font = [ApplicationStyle textThrityFont];
        [self.view addSubview:labtext];
        
        
        NSArray *arrText = @[NSLocalizedString(@"NLHealthCalender_AQQ", nil),
                             NSLocalizedString(@"NLHealthCalender_YYQ", nil),
                             NSLocalizedString(@"NLHealthCalender_YCQ", nil),
                             NSLocalizedString(@"NLHealthCalender_GQS", nil)];
        NSArray *arrColor = @[[@"b8c752" hexStringToColor],
                              [@"fb961f" hexStringToColor],
                              [@"d14f4f" hexStringToColor],
                              [@"e5e4d3" hexStringToColor]];
        for (NSInteger i=0; i<arrText.count; i++) {
            CGSize textSize = [ApplicationStyle textSize:arrText[i] font:[ApplicationStyle textSuperSmallFont] size:SCREENWIDTH];
            
            
            CGRect frame = CGRectMake([ApplicationStyle control_weight:472], periodView.bottomOffset+i*[ApplicationStyle control_height:34], [ApplicationStyle control_weight:30 + 17 + textSize.width], [ApplicationStyle control_height:20]);
            
            NLTextImageView *textImageView = [[NLTextImageView alloc] initWithFrame:frame
                                                                              color:arrColor[i]
                                                                              image:nil
                                                                               font:[ApplicationStyle textSuperSmallFont]
                                                                          textColor:[@"bf851b" hexStringToColor]
                                                                               text:arrText[i]
                                                                               type:0];
            [self.view addSubview:textImageView];
            
        }
    }
}

-(void)pregnancyIndex{
    UIView  *pregnancyBackView = [[UIView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle navBarAndStatusBarSize] + [ApplicationStyle control_height:510] + [ApplicationStyle control_height:146], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle navBarAndStatusBarSize] + [ApplicationStyle control_height:510] + [ApplicationStyle control_height:146] - [ApplicationStyle tabBarSize])];
    pregnancyBackView.backgroundColor = [@"fdfbdc" hexStringToColor];
    [self.view addSubview:pregnancyBackView];
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:4])];
    viewLine.backgroundColor = [@"e5e084" hexStringToColor];
    [pregnancyBackView addSubview:viewLine];
    
    UILabel *dayPregnancy = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:60], [ApplicationStyle control_height:70], [ApplicationStyle control_weight:302], [ApplicationStyle control_height:50])];
    dayPregnancy.textAlignment = NSTextAlignmentCenter;
    dayPregnancy.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:48]];
    dayPregnancy.text = NSLocalizedString(@"NLMyHer_DayPregnancy", nil);
    dayPregnancy.textColor = [@"a66d1b" hexStringToColor];
    [pregnancyBackView addSubview:dayPregnancy];
    
    UILabel *nextPeriod = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:60], dayPregnancy.bottomOffset + [ApplicationStyle control_height:24], [ApplicationStyle control_weight:290], [ApplicationStyle control_height:34])];
    nextPeriod.text = @"下次大姨妈2月26日";
    nextPeriod.font = [ApplicationStyle textThrityFont];
    nextPeriod.textColor = [@"de9124" hexStringToColor];
    [pregnancyBackView addSubview:nextPeriod];
    
    CGRect frame = CGRectMake([ApplicationStyle control_weight:470],[ApplicationStyle control_height:60], [ApplicationStyle control_weight:120], [ApplicationStyle control_height:120]);
    
    NLRing *ring = [[NLRing alloc] init];
    ring = [[NLRing alloc] init];
    ring.lineWidth = [ApplicationStyle control_weight:15];
    ring.lineIndex = 10;
    ring.progressCounter = 5;
    ring.radius = [ApplicationStyle control_weight:50];
    ring.backColors = [@"e4e1c6" hexStringToColor];
    ring.coverColor = [@"f46464" hexStringToColor];
    ring.types = NLRingType_SimpleCircle;
    
    NLRingLine *ringLine = [[NLRingLine alloc] initWithRing:ring frame:frame];
    ringLine.backgroundColor = [UIColor clearColor];
    [pregnancyBackView addSubview:ringLine];
    
    NSString *str = @"80%";
    
    CGSize labSignSize = [ApplicationStyle textSize:str font:[UIFont systemFontOfSize:[ApplicationStyle control_weight:36]] size:SCREENWIDTH];
    
    UILabel *labSign = [[UILabel alloc] initWithFrame:CGRectMake((ringLine.viewWidth - labSignSize.width)/2, (ringLine.viewHeight - labSignSize.height)/2, labSignSize.width, labSignSize.height)];
    labSign.text = str;
    labSign.textAlignment = NSTextAlignmentCenter;
    labSign.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:36]];
    labSign.textColor = [@"a66d1b" hexStringToColor];
    [ringLine addSubview:labSign];
    
    
    
}
#pragma mark 系统Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ApplicationStyle control_height:88];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"LYD";
    
    NLHyHerCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[NLHyHerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
        
        
    }
    
    NSArray *imgArr = @[@"NL_MaleSleep",@"NL_MaleSport"];

    cell.imageViews.image = [UIImage imageNamed:imgArr[indexPath.row]];
    cell.titleLabs.text = @"她的睡眠";
    cell.backgroundColor = [@"49484b" hexStringToColor];
    
    
    UIView *viewB = [[UIView alloc] initWithFrame:cell.bounds];
    viewB.backgroundColor = [@"3b3b3b" hexStringToColor];
    cell.selectedBackgroundView = viewB;
    

    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _herSleepAndSportTable.hidden = YES;
    
}
#pragma mark 自己的Delegate
#pragma mark 接口
-(void)loadStepData{
    
    NSDate *date = [ApplicationStyle whatMonth:[NSDate date] timeDay:0];
    /*
     下面是真数据
     */
    NSString *starDate = [ApplicationStyle datePickerTransformationCorss:date];
    NSString *endDate = [ApplicationStyle datePickerTransformationCorss:[NSDate date]];
    
    
    NSLog(@"%@  %@",[kAPPDELEGATE._loacluserinfo GetAccessToken],[kAPPDELEGATE._loacluserinfo GetUser_ID]);
    
    
    //测试
    //    [[NLDatahub sharedInstance] userStepNumberToken:[kAPPDELEGATE._loacluserinfo GetAccessToken]
    //                                         consumerId:[kAPPDELEGATE._loacluserinfo GetUser_ID]
    //                                          startDate:@"2015-6-01"
    //                                            endDate:@"2016-10-30"];
    
    //此为真实
    [[NLDatahub sharedInstance] userStepNumberToken:[kAPPDELEGATE._loacluserinfo GetAccessToken]
                                         consumerId:[kAPPDELEGATE._loacluserinfo GetUser_ID]
                                          startDate:starDate
                                            endDate:endDate];
}
#pragma mark 自己的按钮事件
-(void)btnAddDown{
    
}
-(void)liftBtnDown{
    _herSleepAndSportTable.hidden = NO;
}

-(void)addNotification{
    NSNotificationCenter *notifi= [NSNotificationCenter defaultCenter];
    [notifi addObserver:self selector:@selector(folksSuccess:) name:NLFolkSuccessNotification object:nil];
    [notifi addObserver:self selector:@selector(folksFicaled) name:NLFolkFicaledNotification object:nil];
}
-(void)folksSuccess:(NSNotification *)notifi{
    if (notifi.object==nil) {
        [self generateQRCode];
    }else{
        _liftBtn.hidden = NO;
        [self periodCircleView];
        [self pregnancyIndex];
    }
}
-(void)folksFicaled{
    
}

-(void)delNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
