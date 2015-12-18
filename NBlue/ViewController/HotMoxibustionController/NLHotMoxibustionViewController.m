//
//  HotMoxibustionViewController.m
//  NBlue
//
//  Created by LYD on 15/11/23.
//  Copyright © 2015年 LYD. All rights reserved.
//

static const NSInteger TIMELINE = 90;

#import "NLHotMoxibustionViewController.h"
#import "NLBluetoothAgreement.h"
#import "NLBluetoothDataAnalytical.h"
#import "LineProgressView.h"
#import "NLAboutImageBtn.h"
#import "NLBluetoothDataAnalytical.h"
#import "NLHalfView.h"
#import "NLSQLData.h"
@interface NLHotMoxibustionViewController ()<UIScrollViewDelegate,NLHalfViewDelgate>
@property(nonatomic,strong)NSArray *peripheralArray;
@property(nonatomic,strong)NSMutableArray *sportDataArr;
@property(nonatomic,strong)UILabel *temperatureLab;
@property(nonatomic,strong)UIScrollView *staffScrollew;
@property(nonatomic,assign)CGFloat lenthWidth;
@property(nonatomic,strong)UIButton *moxibustionBtn;
@property(nonatomic,assign)BOOL isOff;
@property(nonatomic,assign)NSInteger temperatureNUM;
@property(nonatomic,assign)NSInteger blueTime;
@property(nonatomic,assign)BOOL isQuert;
@end

@implementation NLHotMoxibustionViewController
//打开温度
-(void)btnDown{
    Byte byte[18] = {0x90,0x01,0x55};
    NSData *data = [NSData dataWithBytes:byte length:20];
    if (_peripheralArray.count>0) {
        //       [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
        NSLog(@"发送命令==  %@",data);
    }
}
//打开关闭
-(void)btnDown1{
    Byte byte[18] = {0x90,0x01,0xAA};
    NSData *data = [NSData dataWithBytes:byte length:20];
    if (_peripheralArray.count>0) {
        //       [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
        NSLog(@"发送命令==  %@",data);
    }
}
//调节温度
-(void)btnDown2{
    
    NSString *str = [NLBluetoothDataAnalytical tenTurnSixTeen:400];
    
    unsigned long red = strtoul([[str substringWithRange:NSMakeRange(0, 2)] UTF8String],0,16);
    Byte b =  (Byte) ((0xff & red) );//( Byte) 0xff&iByte;
    
    unsigned long red1 = strtoul([[str substringWithRange:NSMakeRange(2, str.length - 2)] UTF8String],0,16);
    Byte b1 =  (Byte) ((0xff & red1) );//( Byte) 0xff&iByte;

    
    Byte byte[20] = {0x90,0x03,b,b1,0x00,0x08,0x00};
    NSData *data = [NSData dataWithBytes:byte length:20];
    if (_peripheralArray.count>0) {
        //       [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
        NSLog(@"发送命令==  %@",data);
    }
}
//查询温度
-(void)btnDown3{
    Byte byte[20] = {0x90,0x02};
    NSData *data = [NSData dataWithBytes:byte length:20];
    if (_peripheralArray.count>0) {
        //       [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
        NSLog(@"发送命令==  %@",data);
    }
}


-(void)sportxx{
    Byte byte[20] = {0x08,0x01,0x01,0x01};
    NSData *data = [NSData dataWithBytes:byte length:20];
    if (_peripheralArray.count>0) {
        [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
//        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
        NSLog(@"发送命令==  %@",data);
    }
}

-(void)sportxx1{
    Byte byte[20] = {0x08,0x03,0x01};
    NSData *data = [NSData dataWithBytes:byte length:20];
    if (_peripheralArray.count>0) {
        [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
        //        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
        NSLog(@"发送命令==  %@",data);
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _temperatureNUM  = 350;         //默认温度 35°
    _blueTime = 30;                 //默认时间 30分钟
    
    self.returnBtn.hidden = YES;
    self.titles.text = @"热灸";
//    self.returnBtn.hidden = YES;
    [self bulidUI];
    
    _sportDataArr = [NSMutableArray array];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(40, 100, 40, 40);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnDown3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
//
//    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn1.frame = CGRectMake(100, 100, 100, 100);
//    btn1.backgroundColor = [UIColor yellowColor];
//    [btn1 addTarget:self action:@selector(btnDown1) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn1];
//    
//    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn2.frame = CGRectMake(100, 400, 100, 100);
//    btn2.backgroundColor = [UIColor orangeColor];
//    [btn2 addTarget:self action:@selector(btnDown2) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn2];
//////
//    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn3.frame = CGRectMake(200, 200, 100, 100);
//    btn3.backgroundColor = [UIColor greenColor];
//    [btn3 addTarget:self action:@selector(sportxx1) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn3];
////
////    
//    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn4.frame = CGRectMake(100, 200, 100, 100);
//    btn4.backgroundColor = [UIColor greenColor];
//    [btn4 addTarget:self action:@selector(sportxx) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn4];
    
    
    
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
    
    
    
    
//    [NLBluetoothDataAnalytical blueSportOrdinArrayData:_sportDataArr];////测试假数据
    
    
    NLBluetoothAgreement *blues = [NLBluetoothAgreement shareInstance];
    [blues bluetoothAllocInit];
    blues.getConnectData = ^(NSString *blueData){
        //获得设备信息
        [NLBluetoothDataAnalytical bluetoothCommandReturnData:blueData];
        //调温
        [self temperaturetOFF:blueData];
        //记步
        [self sportData:blueData];
        //判断温度
        [self isTemperatureOff:blueData];
        
        NSLog(@"%@",blueData);
        
    };
    blues.perheral = ^(NSArray *perpheral){
        _peripheralArray = perpheral;//获得当前的外围设备
    };
    blues.getConnectionSuccess = ^(NSString *connectionSuccess){
        if ([connectionSuccess isEqualToString:EquiomentConnectionSuccess]) {
            if (!_isQuert) {
                [self judgmentTemperatureQuery];
            }
            
        }
    };
    
    [self loadStepData];
    [self halfCircle];
}



-(void)halfCircle{
    

    
    CGRect frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:446] )/2, [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize] + [ApplicationStyle control_height:76], [ApplicationStyle control_weight:446], [ApplicationStyle control_height:446]);
    
    NLHalfView *vc = [[NLHalfView alloc] initWithFrame:frame
                                                   num:50
                                                 index:0
                                                redius:[ApplicationStyle control_weight:190]
                                                 width:[ApplicationStyle control_weight:40]
                                             starColor:[@"f7f3ff" hexStringToColor]
                                              endColor:[@"ffde6a" hexStringToColor]];
    vc.delegate = self;
    
    vc.backgroundColor = [UIColor clearColor];
    [self.view addSubview:vc];
    
    
    
    _temperatureLab = [[UILabel alloc] initWithFrame:CGRectMake(0, [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize] +[ApplicationStyle control_height:255], SCREENWIDTH, [ApplicationStyle control_height:70])];
    _temperatureLab.textColor = [ApplicationStyle subjectWithColor];
    _temperatureLab.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:90]];
    _temperatureLab.text = [NSString stringWithFormat:@"%d°C",35];
    _temperatureLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_temperatureLab];
    
    
    UIImageView *sj= [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:24])/2, [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize] + [ApplicationStyle control_height:530], [ApplicationStyle control_weight:24], [ApplicationStyle control_height:24])];
    sj.image = [UIImage imageNamed:@"HM_SJ"];
    [self.view addSubview:sj];
    
    
    
    
    NSInteger width = (SCREENWIDTH - [ApplicationStyle control_weight:68 * 2]);
    
    _staffScrollew = [[UIScrollView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:68], [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize] + [ApplicationStyle control_height:566], width, [ApplicationStyle control_height:96])];
    _staffScrollew.delegate = self;
    _staffScrollew.bounces = NO;
    _staffScrollew.showsVerticalScrollIndicator = FALSE;
    _staffScrollew.showsHorizontalScrollIndicator = FALSE;
    _staffScrollew.userInteractionEnabled = YES;
    _staffScrollew.contentSize = CGSizeMake(TIMELINE * [ApplicationStyle control_weight:16] + width, [ApplicationStyle control_height:96]);
    [self.view addSubview:_staffScrollew];
    
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:68], [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize] + [ApplicationStyle control_height:566], width, [ApplicationStyle control_height:96])];
    image.backgroundColor = [UIColor clearColor];
    [self.view addSubview:image];
    
    NSInteger num = 0;
    for (NSInteger i=0; i<=TIMELINE; i++) {
        
        UIView *timeLine = [[UIView alloc] initWithFrame:CGRectMake(width/2 + i * [ApplicationStyle control_weight:16], [ApplicationStyle control_height:15], [ApplicationStyle control_weight:4], [ApplicationStyle control_height:36])];
        
        
        timeLine.backgroundColor = [ApplicationStyle subjectWithColor];
        [_staffScrollew addSubview:timeLine];
        num +=5;
        
        UILabel *labTime = [[UILabel alloc] initWithFrame:CGRectMake((width/2 - [ApplicationStyle control_weight:23]) + i * [ApplicationStyle control_weight:16], [ApplicationStyle control_height:60], [ApplicationStyle control_weight:67], [ApplicationStyle control_height:23])];
        labTime.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:20]];
        labTime.textColor = [ApplicationStyle subjectWithColor];
        [_staffScrollew addSubview:labTime];
        if (i%10 == 0) {
            timeLine.frame = CGRectMake(width/2 + i * [ApplicationStyle control_weight:16], 0, [ApplicationStyle control_weight:4], [ApplicationStyle control_height:60]);
            labTime.text = [NSString stringWithFormat:@"%ld分钟",(long)i];
        }
    }
    
    
    _moxibustionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moxibustionBtn.frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:80])/2, _staffScrollew.bottomOffset + [ApplicationStyle control_height:86], [ApplicationStyle control_weight:80], [ApplicationStyle control_height:80]);
    [_moxibustionBtn setImage:[UIImage imageNamed:@"HM_G"] forState:UIControlStateNormal];
    [_moxibustionBtn addTarget:self action:@selector(moxibustionBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_moxibustionBtn];
    
}





-(void)loadStepData{
    
//    NSDate *date = [ApplicationStyle whatMonth:[NSDate date] timeDay:0];
    /*
     下面是真数据
     */
//    NSString *starDate = [ApplicationStyle datePickerTransformationCorss:date];
//    NSString *endDate = [ApplicationStyle datePickerTransformationCorss:[NSDate date]];
    
    
    //测试
    [[NLDatahub sharedInstance] userStepNumberToken:[kAPPDELEGATE._loacluserinfo GetAccessToken]
                                         consumerId:[kAPPDELEGATE._loacluserinfo GetUser_ID]
                                          startDate:@"2015-10-01"
                                            endDate:@"2015-10-30"];
    
    //此为真实
//    [[NLDatahub sharedInstance] userStepNumberToken:[kAPPDELEGATE._loacluserinfo GetAccessToken]
//                                         consumerId:[kAPPDELEGATE._loacluserinfo GetUser_ID]
//                                          startDate:starDate
//                                            endDate:endDate];
}
#pragma mark 系统Delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self scrollViewAnimation:scrollView];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewAnimation:scrollView];
}
-(void)scrollViewAnimation:(UIScrollView *)scrollView{
    CGFloat width = scrollView.contentOffset.x/[ApplicationStyle control_weight:16];
    
    NSString *time = [NSString stringWithFormat:@"%0.0f",width];
    _blueTime = [time integerValue];

    CGFloat startPoint = (NSInteger)width + 0.5;
    CGFloat endPoint = width;
    NSInteger centPoint = (NSInteger)(endPoint + 0.5);
    if (endPoint >= startPoint) {
        scrollView.contentOffset = CGPointMake(centPoint * [ApplicationStyle control_weight:16], scrollView.contentOffset.y);
    }else{
        scrollView.contentOffset = CGPointMake(centPoint * [ApplicationStyle control_weight:16], scrollView.contentOffset.y);
    }
}
#pragma mark 自己的Delegate
-(void)index:(NSInteger)index{
    _temperatureLab.text = [NSString stringWithFormat:@"%ld°C",(long)35 + index/10];
}
-(void)gestureRecognizerStateEnded:(NSInteger)index{
    
    NSInteger ture = 35 + index/10;
    _temperatureNUM = ture * 10;
    
    if (_isOff) {
       
        NSLog(@"%ld",(long)_temperatureNUM);
        [self controlTemperaturet];
    }
}

#pragma makr 蓝牙方法
//查询温度开关
-(void)judgmentTemperatureQuery{
    Byte byte[20] = {0x90,0x02};
    NSData *data = [NSData dataWithBytes:byte length:20];
    if (_peripheralArray.count>0) {
        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
    }
    _isQuert = !_isQuert;
}
-(void)isTemperatureOff:(NSString *)data{
    NSString *to = [data substringWithRange:NSMakeRange(0, 4)];
    if ([to isEqualToString:EquiomentCommand_9002]) {
        NSString *off = [data substringWithRange:NSMakeRange(4, 2)];
        if ([off isEqualToString:@"00"]) {
            NSString *temperStr = [data substringWithRange:NSMakeRange(6, 4)];
            NSString *temper = [NLBluetoothDataAnalytical reversedPositionStr:temperStr];
            _temperatureNUM = [NLBluetoothDataAnalytical sixTenHexTeen:temper];
        }
    }
}

- (void)temperaturetOFF:(NSString *)command{
    if ([command isEqualToString:EquiomentCommand_9001]) {
        
        if (_isOff) {
            [self controlTemperaturet];
        }
    }
}

#warning   调节温度了

-(void)controlTemperaturet{

    NSString *str = [NLBluetoothDataAnalytical tenTurnSixTeen:_temperatureNUM];
    
    unsigned long red = strtoul([[str substringWithRange:NSMakeRange(0, 2)] UTF8String],0,16);
    Byte b =  (Byte) ((0xff & red) );//( Byte) 0xff&iByte;
    
    unsigned long red1 = strtoul([[str substringWithRange:NSMakeRange(2, str.length - 2)] UTF8String],0,16);
    Byte b1 =  (Byte) ((0xff & red1) );//( Byte) 0xff&iByte;
    
    
    
    unsigned long time = strtoul([[NSString stringWithFormat:@"%lx",(long)_blueTime] UTF8String], 0, 16);
    Byte timeByty =  (Byte) ((0xff & time) );//( Byte) 0xff&iByte;
    
    Byte byte[20] = {0x90,0x03,b,b1,0x00,timeByty,0x00};
    NSData *data = [NSData dataWithBytes:byte length:20];
    if (_peripheralArray.count>0) {
        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
    }
}


-(void)sportData:(NSString *)sportData{
    NSString *format = [sportData substringWithRange:NSMakeRange(0, 4)];
    if ([format isEqualToString:EquiomentCommand_0803]) {
        [_sportDataArr addObject:sportData];
        if (_sportDataArr.count==34) {
            [NLBluetoothDataAnalytical blueSportOrdinArrayData:_sportDataArr];
        }
    }
}

#pragma mark 按钮事件

- (void)moxibustionBtnDown{
    if (!_isOff) {
        [_moxibustionBtn setImage:[UIImage imageNamed:@"HM_K"] forState:UIControlStateNormal];
        _isOff = !_isOff;
        Byte byte[18] = {0x90,0x01,0x55};
        NSData *data = [NSData dataWithBytes:byte length:20];
        if (_peripheralArray.count>0) {
            //       [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
            [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
            NSLog(@"发送命令==  %@",data);
        }
        return;
    }else{
        [_moxibustionBtn setImage:[UIImage imageNamed:@"HM_G"] forState:UIControlStateNormal];
        _isOff = !_isOff;
        Byte byte[18] = {0x90,0x01,0xAA};
        NSData *data = [NSData dataWithBytes:byte length:20];
        if (_peripheralArray.count>0) {
            //       [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
            [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
            NSLog(@"发送命令==  %@",data);
        }
        return;
    }
}


#pragma makr 字体大小
-(void)heartReatlab:(UILabel *)lab andRang:(NSRange)rang{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:lab.text];
    //设置大小
    [str addAttribute:NSFontAttributeName value:[UIFont  systemFontOfSize:50] range:rang];
    //设置颜色
//    [str addAttribute:NSForegroundColorAttributeName value:UIColorFromHEX(0x949799) range:rang2];
    lab.attributedText = str;
}

#pragma mark Notification
-(void)addNotification{
    NSNotificationCenter *notifi= [NSNotificationCenter defaultCenter];
    [notifi addObserver:self selector:@selector(logInSuccess:) name:NLGetSoortRecordDataSuccessNotification object:nil];
    [notifi addObserver:self selector:@selector(logInFicaled:) name:NLGetSoortRecordDataFicaledNotification object:nil];
}
-(void)logInSuccess:(NSNotification *)notifi{
    NSDictionary *dic = notifi.object;
    [NLSQLData sportRecordCreateData:[dic objectForKey:@"records"] isDeposit:0];
    
}
-(void)logInFicaled:(NSNotification *)notifi{
    
}
-(void)delNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 NSMutableSet *seenObjects = [NSMutableSet set];
 NSPredicate *dupPred = [NSPredicate predicateWithBlock: ^BOOL(id obj, NSDictionary *bind) {
 HistoryObject *hObj = (HistoryObject*)obj;
 BOOL seen = [seenObjects containsObject:hObj.title];
 if (!seen) {
 [seenObjects addObject:hObj.title];
 }
 return !seen;
 }];
 
 
 */


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
