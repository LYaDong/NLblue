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
#import "NLAboutImageBtn.h"
#import "NLBluetoothDataAnalytical.h"
#import "NLHalfView.h"
#import "NLSQLData.h"
#import "PlistData.h"
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
#import "NLConnectBloothViewController.h"
#import "SMProgressHUD.h"
@interface NLHotMoxibustionViewController ()<UIScrollViewDelegate,NLHalfViewDelgate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NLHalfView *temperatureCilcle;
@property(nonatomic,strong)NSArray *peripheralArray;
@property(nonatomic,strong)NSMutableArray *sportDataArr;
@property(nonatomic,strong)NSMutableArray *sleepDataArr;
@property(nonatomic,strong)UILabel *temperatureLab;
@property(nonatomic,strong)UIScrollView *staffScrollew;
@property(nonatomic,assign)CGFloat lenthWidth;
@property(nonatomic,strong)UIButton *moxibustionBtn;
@property(nonatomic,assign)BOOL isOff;
@property(nonatomic,assign)NSInteger temperatureNUM;
@property(nonatomic,assign)NSInteger blueTime;
@property(nonatomic,assign)BOOL isQuert;
@property(nonatomic,strong)UIImageView *blueImage;
@property(nonatomic,strong)CTCallCenter *callCenter;
@property(nonatomic,assign)NSInteger timeInt;
@property(nonatomic,strong)NSTimer *timeVer;
@property(nonatomic,assign)NSInteger equipmentStatsCount;




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

-(void)sleep1{
    Byte byte[20] = {0x08,0x04,0x01};
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
    
    self.returnBtn.hidden = YES;
    _timeInt = 0;
    self.titles.text = @"热灸";
    
    
    //判断要不要进入搜索页
    if ([[kAPPDELEGATE._loacluserinfo getBlueToothUUID] length]<=0) {
       [self connectBlueTooth]; 
    }

    
//    =================================================================================================================================
    

    _temperatureNUM  = 370;         //默认温度 35°
    _blueTime = 30;                 //默认时间 30分钟
    _sportDataArr = [NSMutableArray array];
    _sleepDataArr = [NSMutableArray array];
    NSLog(@"%@",NSHomeDirectory());
    [self bulidUI];
    


    
//    电话监听
//    _callCenter = [[CTCallCenter alloc] init];
//    _callCenter.callEventHandler = ^(CTCall* call) {
//        if (call.callState == CTCallStateDisconnected){
//            NSLog(@"Call has been disconnected");
//        }else if (call.callState == CTCallStateConnected){
//            NSLog(@"Call has just been connected");
//        }else if(call.callState == CTCallStateIncoming){
//           NSLog(@"Call is incoming");
//        } else if (call.callState ==CTCallStateDialing){
//            NSLog(@"call is dialing");
//        }else{
//            NSLog(@"Nothing is done");   
//        }
//        
//    };
 
 
    _blueImage = [[UIImageView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:24], [ApplicationStyle statusBarSize] + ([ApplicationStyle navigationBarSize] - [ApplicationStyle control_height:40])/2, [ApplicationStyle control_weight:40], [ApplicationStyle control_height:44])];
    _blueImage.image = [UIImage imageNamed:@"NL_Blue_Connect_N"];
    [self.view addSubview:_blueImage];
    
    
    
//    UIButton *btn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
//    btn.frame = CGRectMake(0, 64, 50, 50);
////    btn.backgroundColor = [UIColor redColor];
//    [btn setTitle:@"搜搜" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(btnDownXXX) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
//    UIButton *xxx = [UIButton buttonWithType: UIButtonTypeRoundedRect];
//    xxx.frame = CGRectMake(110, 64, 50, 50);
//    [xxx setTitle:@"重启" forState:UIControlStateNormal];
//    [xxx addTarget:self action:@selector(xxxxxxxx) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:xxx];
//    
//    UIButton *xvfvf = [UIButton buttonWithType: UIButtonTypeRoundedRect];
//    xvfvf.frame = CGRectMake(110, 224, 50, 50);
//    [xvfvf setTitle:@"查时间" forState:UIControlStateNormal];
//    [xvfvf addTarget:self action:@selector(xvfvf) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:xvfvf];
    
}
-(void)xxxxxxxx{
    Byte byte[20] = {0xF0,0x01};
    NSData *data = [NSData dataWithBytes:byte length:20];
    if (_peripheralArray.count>0) {
        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
    }
}
-(void)xvfvf{
    Byte byte[20] = {0x02,0x03};
    NSData *data = [NSData dataWithBytes:byte length:20];
    if (_peripheralArray.count>0) {
        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
    }
}


-(void)btnDownXXX{
    
    
    NLConnectBloothViewController *vc = [[NLConnectBloothViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupBackgroundHandler{
    
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

#pragma mark 连接蓝牙
-(void)connectBlueTooth{
    NLConnectBloothViewController *vc = [[NLConnectBloothViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 基础UI
-(void)bulidUI{
//    [NLBluetoothDataAnalytical blueSportOrdinArrayData:_sportDataArr];////测试假数据
//    [NLBluetoothDataAnalytical bluesleepOrdinArrayData:_sleepDataArr];//测试睡眠假数据
    

    [self bluetoothConnectOperation];
    
    
    [self halfCircle];
    [self estableSqlite];
    
    
//    [self loadStepData];
    
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

-(void)bluetoothConnectOperation{
    
    _equipmentStatsCount = 0;
    
    NLBluetoothAgreement *blues = [NLBluetoothAgreement shareInstance];
    [blues bluetoothAllocInit];
    blues.getConnectData = ^(NSString *blueData){
        NSLog(@"蓝牙反馈数据：%@",blueData);
        
        if ([blueData isEqualToString:EquiomentCommandEndSportBlue]) {
            _equipmentStatsCount = 1;
            [_sleepDataArr removeAllObjects];
            [self sleepDataQuery];//获取睡眠数据
        }
        
        if (_equipmentStatsCount == 1) {
            if ([blueData isEqualToString:EquiomentCommandEndSleepBlue]) {
                [[SMProgressHUD shareInstancetype] dismiss];
            }
        }
        
        
        //刷新页面数据
        if ([blueData isEqualToString:EquiomentCommandEndSleepBlue]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:RefrefhSleepDataNotification object:nil];
        }
        if ([blueData isEqualToString:EquiomentCommandEndSportBlue]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:RefrefhStopDataNotification object:nil];
        }
        
        
        //获得设备信息
        [NLBluetoothDataAnalytical bluetoothCommandReturnData:blueData];
        //调温
        [self temperaturetOFF:blueData];
        //记步
        [self sportData:blueData];
        //        //判断温度
        [self isTemperatureOff:blueData];
        //睡眠数据
        [self sleepDatas:blueData];
    };
    blues.perheral = ^(NSArray *perpheral){
        _peripheralArray = perpheral;//获得当前的外围设备
        
    };
    blues.getConnectionSuccess = ^(NSString *connectionSuccess){
        if ([connectionSuccess isEqualToString:EquiomentConnectionSuccess]) {
            
            _blueImage.image = [UIImage imageNamed:@"NL_Blue_Connect"];
            
            if (!_isQuert) {
                [[SMProgressHUD shareInstancetype] showLoadingWithTip:@"恢复数据中，请耐心等待"];
                if (![[kAPPDELEGATE._loacluserinfo getBlueToothTime] isEqualToString:@"1"]) {
                    [kAPPDELEGATE._loacluserinfo bluetoothSetTime:@"1"];
                    [self setTimeEquipment];//设置设备时间
                }
                [self judgmentTemperatureQuery];//查询温度
                [self sportDataQuery];//获得运动数据
                _isQuert = !_isQuert;
            }
        }
        if ([connectionSuccess isEqualToString:EquiomentConnectionFiale]) {
            _blueImage.image = [UIImage imageNamed:@"NL_Blue_Connect_N"];
        }
    };
}
-(void)halfCircle{
    

    
    CGRect frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:446] )/2, [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize] + [ApplicationStyle control_height:76], [ApplicationStyle control_weight:446], [ApplicationStyle control_height:446]);
    
    _temperatureCilcle = [[NLHalfView alloc] initWithFrame:frame
                                                   num:50
                                                 index:0
                                                redius:[ApplicationStyle control_weight:190]
                                                 width:[ApplicationStyle control_weight:40]
                                             starColor:[@"f7f3ff" hexStringToColor]
                                              endColor:[@"ffde6a" hexStringToColor]];
    _temperatureCilcle.delegate = self;
    
    _temperatureCilcle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_temperatureCilcle];
    
    
    
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
    _staffScrollew.contentOffset = CGPointMake(30 * [ApplicationStyle control_weight:16], 0);
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
//滑动设置显示文字
-(void)indexNum:(NSInteger)index{
    if (!_isOff) {
        _temperatureLab.text = [NSString stringWithFormat:@"%ld°C",(long)35 + index/5];
    }
    
    
}
//滑动结束后设置温度
-(void)gestureRecognizerStateEnded:(NSInteger)index{
    if (!_isOff) {
        NSInteger ture = 35 + index/5;
        _temperatureNUM = ture * 10;
    }
//    NSInteger ture = 35 + index/5;
//    _temperatureNUM = ture * 10;
//    if (_isOff) {
//        [self controlTemperaturet];
//    }
}

#pragma makr 蓝牙方法
//查询温度开关
-(void)judgmentTemperatureQuery{
    Byte byte[20] = {0x90,0x02};
    NSData *data = [NSData dataWithBytes:byte length:20];
    if (_peripheralArray.count>0) {
        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
    }
}
-(void)isTemperatureOff:(NSString *)data{
    if (data.length<=4) {
        return;
    }
    NSString *to = [data substringWithRange:NSMakeRange(0, 4)];
    if ([to isEqualToString:EquiomentCommand_9002]) {
        NSString *off = [data substringWithRange:NSMakeRange(4, 2)];
        if ([off isEqualToString:@"00"]) {
            NSString *temperStr = [data substringWithRange:NSMakeRange(6, 4)];
            if (![temperStr isEqualToString:@"ffff"]) {
                NSString *temper = [NLBluetoothDataAnalytical reversedPositionStr:temperStr];
                _temperatureNUM = [NLBluetoothDataAnalytical sixTenHexTeen:temper];
                [self controlTemperaturet];
                [_moxibustionBtn setImage:[UIImage imageNamed:@"HM_K"] forState:UIControlStateNormal];
                _isOff = !_isOff;
                _temperatureLab.text = [NSString stringWithFormat:@"%ld°C",(long)_temperatureNUM/10];

                NSInteger num = _temperatureNUM/10;
                
                if (num>=44&&num<45) {
                    _temperatureCilcle.indexTemp = 47;
                }else if (num>=43&& num<44){
                    _temperatureCilcle.indexTemp = 43;
                }else if (num>=42&& num<43){
                    _temperatureCilcle.indexTemp = 38;
                }else if (num>=41&& num<42){
                    _temperatureCilcle.indexTemp = 35;
                }else if (num>=40&& num<41){
                    _temperatureCilcle.indexTemp = 27;
                }else if (num>=39&& num<40) {
                    _temperatureCilcle.indexTemp = 24;
                }else if (num>=38 && num<39){
                    _temperatureCilcle.indexTemp = 18;
                }else if (num>=37 && num<38){
                    _temperatureCilcle.indexTemp = 14;
                }else if (num>=36 && num<37){
                    _temperatureCilcle.indexTemp = 9;
                }else if (num>=35 && num<36){
                    _temperatureCilcle.indexTemp = 4;
                }else{
                    _temperatureCilcle.indexTemp = 0;
                }
            }
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
#pragma mark 获取运动数据
-(void)sportDataQuery{
    {
        Byte byte[20] = {0x08,0x01,0x01,0x01};
        NSData *data = [NSData dataWithBytes:byte length:20];
        if (_peripheralArray.count>0) {
            [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
            NSLog(@"发送命令==  %@",data);
        }
    }
    {
        Byte byte[20] = {0x08,0x03,0x01};
        NSData *data = [NSData dataWithBytes:byte length:20];
        if (_peripheralArray.count>0) {
            [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
            //        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
            NSLog(@"发送命令==  %@",data);
        }
    }
}
-(void)sleepDataQuery{
    
    {
        Byte byte[20] = {0x08,0x01,0x01,0x01};
        NSData *data = [NSData dataWithBytes:byte length:20];
        if (_peripheralArray.count>0) {
            [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
        }
    }
    
    {
        Byte byte[20] = {0x08,0x04,0x01};
        NSData *data = [NSData dataWithBytes:byte length:20];
        if (_peripheralArray.count>0) {
            [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
        }
    }
    
    
}

//设置温度
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
        NSLog(@"发送命令==  %@",data);
    }
}


-(void)sportData:(NSString *)sportData{
    if (sportData.length<=4) {
        return;
    }
    NSString *format = [sportData substringWithRange:NSMakeRange(0, 4)];
    if ([format isEqualToString:EquiomentCommand_0803]) {
        [_sportDataArr addObject:sportData];
        if (_sportDataArr.count==34) {
            [NLBluetoothDataAnalytical blueSportOrdinArrayData:_sportDataArr];
        }
    }
}
#pragma mark 睡眠数据
-(void)sleepDatas:(NSString *)sleepDatas{
    if (sleepDatas.length<=4) {
        return;
    }
    
    NSString *format = [sleepDatas substringWithRange:NSMakeRange(0, 4)];
    if ([format isEqualToString:EquiomentCommand_0804]) {

        [_sleepDataArr addObject:sleepDatas];
        
        
        NSLog(@"%@",sleepDatas);

//        NSLog(@"%@",[NLBluetoothDataAnalytical tenturnSinTenNew:[[sleepDatas substringWithRange:NSMakeRange(sleepDatas.length-2, 2)] integerValue]]);
        
        
        NSString *count = [NLBluetoothDataAnalytical tenturnSinTenNew:[[sleepDatas substringWithRange:NSMakeRange(sleepDatas.length-2, 2)] integerValue]];
        if (_sleepDataArr.count>=[count integerValue]) {
            [NLBluetoothDataAnalytical bluesleepOrdinArrayData:_sleepDataArr];
        }
    }
}

-(void)setTimeEquipment{
    NSString *dateTime = [ApplicationStyle datePickerTransformationYearDate:[NSDate date]];
    NSArray *arrText = [ApplicationStyle interceptText:dateTime interceptCharacter:@"-"];
    
    NSString *yeatTime = arrText[0];
    NSString *str = [NLBluetoothDataAnalytical tenTurnSixTeen:[yeatTime integerValue]];
    unsigned long red = strtoul([[str substringWithRange:NSMakeRange(0, 2)] UTF8String],0,16);
    Byte b =  (Byte) ((0xff & red) );//( Byte) 0xff&iByte;
    
    unsigned long red1 = strtoul([[str substringWithRange:NSMakeRange(2, str.length - 2)] UTF8String],0,16);
    Byte b1 =  (Byte) ((0xff & red1) );//( Byte) 0xff&iByte;
    Byte month = [ApplicationStyle byteTransformationTextSixteenByteStr:[NLBluetoothDataAnalytical tenturnSinTenNew:[arrText[1] integerValue]]];
    Byte day = [ApplicationStyle byteTransformationTextSixteenByteStr:[NLBluetoothDataAnalytical tenturnSinTenNew:[arrText[2] integerValue]]];
    Byte dayTime = [ApplicationStyle byteTransformationTextSixteenByteStr:[NLBluetoothDataAnalytical tenturnSinTenNew:[arrText[3] integerValue]]];
    Byte branch = [ApplicationStyle byteTransformationTextSixteenByteStr:[NLBluetoothDataAnalytical tenturnSinTenNew:[arrText[4] integerValue]]];
    Byte second = [ApplicationStyle byteTransformationTextSixteenByteStr:[NLBluetoothDataAnalytical tenturnSinTenNew:[arrText[5] integerValue]]];
    Byte weekDay = [ApplicationStyle byteTransformationTextSixteenByteStr:[NLBluetoothDataAnalytical tenturnSinTenNew:[[NSString stringWithFormat:@"0%ld",(long)[ApplicationStyle currentDayWeek:[NSDate date]]] integerValue]]];
    
    NSLog(@"%hhu %hhu",b,b1);
    
    Byte byte[20] = {0x03,0x01,b,b1,month,day,dayTime,branch,second,weekDay};
    
    NSData *data = [NSData dataWithBytes:byte length:20];
    if (_peripheralArray.count>0) {
        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
    }

}
#pragma mark 按钮事件

- (void)moxibustionBtnDown{
    
    if (_timeInt ==0) {
        _timeInt = 2;
        _timeVer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeVerDown) userInfo:nil repeats:YES];
        if (!_isOff) {
            _staffScrollew.scrollEnabled = NO;//禁止时间设置
            
            [self temperatureSetProhibit:TemperatureSetProhibitNotification];
            
            
            [_moxibustionBtn setImage:[UIImage imageNamed:@"HM_K"] forState:UIControlStateNormal];
            _isOff = !_isOff;
            
            //发送加热
            Byte byte[18] = {0x90,0x01,0x55};
            NSData *data = [NSData dataWithBytes:byte length:20];
            if (_peripheralArray.count>0) {
                //       [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
                [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
                NSLog(@"发送命令==  %@",data);
            }
            return;
        }else{
            _staffScrollew.scrollEnabled = YES;
            [self temperatureSetProhibit:TemperatureSetAgreeNotification];
            [_moxibustionBtn setImage:[UIImage imageNamed:@"HM_G"] forState:UIControlStateNormal];
            _isOff = !_isOff;
            //关闭加热
            Byte byte[18] = {0x90,0x01,0xAA};
            NSData *data = [NSData dataWithBytes:byte length:20];
            if (_peripheralArray.count>0) {
                //       [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
                [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
                NSLog(@"发送命令==  %@",data);
            }
            return;
        }
    }else{
        [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"亲~请不要频繁操作!!!"];
    }
}

-(void)timeVerDown{
    _timeInt -=1;
    if (_timeInt == 0) {
        [_timeVer invalidate];
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
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NLSQLData establishSportDataTable];
        [NLSQLData upDataSport:[dic objectForKey:@"records"] isUpdata:0];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"XXX");
            
        
        });
    });
    
    
//    [NLSQLData sportRecordCreateData:[dic objectForKey:@"records"] isDeposit:0];
    
    
}
-(void)logInFicaled:(NSNotification *)notifi{
    NSLog(@"%@",notifi);
}
-(void)delNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark 温度滑动禁止
-(void)temperatureSetProhibit:(NSString *)sliding{
    [[NSNotificationCenter defaultCenter] postNotificationName:TemperatureSetNotification object:sliding];
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
