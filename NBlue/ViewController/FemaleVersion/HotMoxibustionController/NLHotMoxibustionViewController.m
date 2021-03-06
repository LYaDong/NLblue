         //
//  HotMoxibustionViewController.m
//  NBlue
//
//  Created by LYD on 15/11/23.
//  Copyright © 2015年 LYD. All rights reserved.
//

static const NSInteger TIMELINE = 90;
static const NSInteger NOVICEGUIDETAG = 6000;
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
#import "NLBluetoothAgreementNew.h"
#import "NLRemindMessageViewController.h"

@interface NLHotMoxibustionViewController ()<UIScrollViewDelegate,NLHalfViewDelgate>
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
@property(nonatomic,strong)NLBluetoothAgreementNew *bluetooth;
@property(nonatomic,assign)NSInteger noviceGuideIndex;
@property(nonatomic,strong)UIButton *remindMessageBtn;




@end

@implementation NLHotMoxibustionViewController
////打开温度
//-(void)btnDown{
//    Byte byte[18] = {0x90,0x01,0x55};
//    NSData *data = [NSData dataWithBytes:byte length:20];
//    if (_peripheralArray.count>0) {
//        //       [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
//        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
//        NSLog(@"发送命令==  %@",data);
//    }
//}
////打开关闭
//-(void)btnDown1{
//    Byte byte[18] = {0x90,0x01,0xAA};
//    NSData *data = [NSData dataWithBytes:byte length:20];
//    if (_peripheralArray.count>0) {
//        //       [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
//        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
//        NSLog(@"发送命令==  %@",data);
//    }
//}
////调节温度
//-(void)btnDown2{
//    
//    NSString *str = [NLBluetoothDataAnalytical tenTurnSixTeen:400];
//    
//    unsigned long red = strtoul([[str substringWithRange:NSMakeRange(0, 2)] UTF8String],0,16);
//    Byte b =  (Byte) ((0xff & red) );//( Byte) 0xff&iByte;
//    
//    unsigned long red1 = strtoul([[str substringWithRange:NSMakeRange(2, str.length - 2)] UTF8String],0,16);
//    Byte b1 =  (Byte) ((0xff & red1) );//( Byte) 0xff&iByte;
//
//    
//    Byte byte[20] = {0x90,0x03,b,b1,0x00,0x08,0x00};
//    NSData *data = [NSData dataWithBytes:byte length:20];
//    if (_peripheralArray.count>0) {
//        //       [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
//        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
//        NSLog(@"发送命令==  %@",data);
//    }
//}
////查询温度
//-(void)btnDown3{
//    Byte byte[20] = {0x90,0x02};
//    NSData *data = [NSData dataWithBytes:byte length:20];
//    if (_peripheralArray.count>0) {
//        //       [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
//        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
//        NSLog(@"发送命令==  %@",data);
//    }
//}
//
//
//-(void)sportxx{
//    Byte byte[20] = {0x08,0x01,0x01,0x01};
//    NSData *data = [NSData dataWithBytes:byte length:20];
//    if (_peripheralArray.count>0) {
//        [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
//        NSLog(@"发送命令==  %@",data);
//    }
//}
//
//-(void)sportxx1{
//    Byte byte[20] = {0x08,0x03,0x01};
//    NSData *data = [NSData dataWithBytes:byte length:20];
//    if (_peripheralArray.count>0) {
//        [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
//        //        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
//        NSLog(@"发送命令==  %@",data);
//    }
//}
//
//-(void)sleep1{
//    Byte byte[20] = {0x08,0x04,0x01};
//    NSData *data = [NSData dataWithBytes:byte length:20];
//    if (_peripheralArray.count>0) {
//        [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:_peripheralArray[0] data:data];
//        //        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
//        NSLog(@"发送命令==  %@",data);
//    }
//}
//
//
//
//#pragma mark 测试来电提醒
//-(void)ancsNotification{
//    Byte byte[20] = {0x06,0x30};
//    NSData *data = [NSData dataWithBytes:byte length:20];
//    if (_peripheralArray.count>0) {
//        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
//        //        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
//        NSLog(@"发送命令==  %@",data);
//    }
//}
//-(void)callRemind{
//    Byte byte[20] = {0x03,0x30,0x88,0x55};
//    NSData *data = [NSData dataWithBytes:byte length:20];
//    if (_peripheralArray.count>0) {
//        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
//        //        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
//        NSLog(@"发送命令==  %@",data);
//    }
//}
//
//-(void)theMainSwitch{
//    Byte byte[20] = {0x03,0x30,0x55};
//    NSData *data = [NSData dataWithBytes:byte length:20];
//    if (_peripheralArray.count>0) {
//        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
//        //        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
//        NSLog(@"发送命令==  %@",data);
//    }
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.returnBtn.hidden = YES;
//    self.navBarBack.hidden = YES;
    _timeInt = 0;
    
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    imageView.image = [UIImage imageNamed:@"RootContorllewImage"];
    [self.view addSubview:imageView];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, [ApplicationStyle statusBarSize], SCREENWIDTH, [ApplicationStyle navigationBarSize])];
    titleLab.text = @"热灸";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor whiteColor];
    titleLab.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:36]];
    [self.view addSubview:titleLab];
    
    

    
//    =================================================================================================================================
    

    _temperatureNUM  = 370;         //默认温度 35°
    _blueTime = 30;                 //默认时间 30分钟
    _sportDataArr = [NSMutableArray array];
    _sleepDataArr = [NSMutableArray array];
    NSLog(@"%@",NSHomeDirectory());
    [self backViewUI];
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
 
 
    _blueImage = [[UIImageView alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:42], ([ApplicationStyle navBarAndStatusBarSize] - [ApplicationStyle control_height:44])/2 + [ApplicationStyle control_height:20], [ApplicationStyle control_weight:40], [ApplicationStyle control_height:44])];
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

-(void)backViewUI{
    
    
//    UIView *viewLine = [[UIView   alloc] initWithFrame:CGRectMake(0, [ApplicationStyle navBarAndStatusBarSize], SCREENWIDTH, [ApplicationStyle control_height:1])];
//    viewLine.alpha = 0.4;
//    viewLine.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:viewLine];
    
    
    UIView *lineViewBack = [UIView statusBackView:CGRectMake(0, [ApplicationStyle navBarAndStatusBarSize], SCREENWIDTH, [ApplicationStyle control_height:1])];
    [self.view addSubview:lineViewBack];
    
    
}

-(void)bulidUI{
//    [NLBluetoothDataAnalytical blueSportOrdinArrayData:_sportDataArr];////测试假数据
//    [NLBluetoothDataAnalytical bluesleepOrdinArrayData:_sleepDataArr];//测试睡眠假数据
    _bluetooth = [NLBluetoothAgreementNew shareInstance];
    if ([kAPPDELEGATE._loacluserinfo getBlueToothUUID] ==nil) {
        [self connectBlueTooth];
    }else{
       [self bluetoothConnectOperation]; 
    }

    
    
    
    [self halfCircle];
    [self estableSqlite];
    [self noviceGuideIMG];
    
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
    
    __weak typeof (NLHotMoxibustionViewController) *hotMoxi = self;//防止循环引用，页面释放时释放他
    
    _bluetooth = [NLBluetoothAgreementNew shareInstance];
    [_bluetooth bluetoothInstantiation];//实例化蓝牙
    [_bluetooth dataArrayInstantiation];//实力化数组
//    [_bluetooth searchBluetooth];//搜索蓝牙
    [[NSNotificationCenter defaultCenter] postNotificationName:NLSearchBluetoothNotification object:nil];
    
    _bluetooth.heating = ^(NLBluetoothAgreementNew *heating){
        if (hotMoxi.isOff) {
            [heating setTemperatureAndTime: hotMoxi.temperatureNUM time:hotMoxi.blueTime];
        }
    };
    _bluetooth.queryTempertureStr = ^(NSString *dataStr){
        [hotMoxi isTemperatureOff:dataStr];
    };
    _bluetooth.bluetoothSuccess = ^(NSString *success){
        hotMoxi.blueImage.image = [UIImage imageNamed:@"NL_Blue_Connect"];
    };
 
}
-(void)halfCircle{
    

    
    CGRect frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:446] )/2, [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize] + [ApplicationStyle control_height:76], [ApplicationStyle control_weight:446], [ApplicationStyle control_height:446]);
    
    _temperatureCilcle = [[NLHalfView alloc] initWithFrame:frame
                                                   num:50
                                                 index:0
                                                redius:[ApplicationStyle control_weight:170]
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
    
    
    _remindMessageBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _remindMessageBtn.frame = CGRectMake(0, _staffScrollew.bottomOffset + [ApplicationStyle control_height:86], [ApplicationStyle control_weight:100], [ApplicationStyle control_height:50]);
    [_remindMessageBtn setTitle:@"召唤暖男" forState:UIControlStateNormal];
    [_remindMessageBtn addTarget:self action:@selector(remindMessageDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_remindMessageBtn];
    
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
    NSString *off = [data substringWithRange:NSMakeRange(4, 2)];
    if ([off isEqualToString:@"00"]) {
        NSString *temperStr = [data substringWithRange:NSMakeRange(6, 4)];
        if (![temperStr isEqualToString:@"ffff"]) {
            NSString *temper = [NLBluetoothDataAnalytical reversedPositionStr:temperStr];
            _temperatureNUM = [NLBluetoothDataAnalytical sixTenHexTeen:temper];
           [_bluetooth setTemperatureAndTime: _temperatureNUM time:_blueTime];//设置温度
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

#pragma mark 按钮事件

- (void)moxibustionBtnDown{
    
    
    if ([kAPPDELEGATE._loacluserinfo getBluetoothName] == nil) {
        [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"你还没有连接设备"];
        return;
    }
    
    
    if (_timeInt ==0) {
        _timeInt = 2;
        _timeVer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeVerDown) userInfo:nil repeats:YES];
        if (!_isOff) {
            _staffScrollew.scrollEnabled = NO;//禁止时间设置
            
            [self temperatureSetProhibit:TemperatureSetProhibitNotification];
            
            
            [_moxibustionBtn setImage:[UIImage imageNamed:@"HM_K"] forState:UIControlStateNormal];
            _isOff = !_isOff;
            
            //发送加热
            [_bluetooth setTemperatureStart];
            return;
        }else{
            _staffScrollew.scrollEnabled = YES;
            [self temperatureSetProhibit:TemperatureSetAgreeNotification];
            [_moxibustionBtn setImage:[UIImage imageNamed:@"HM_G"] forState:UIControlStateNormal];
            _isOff = !_isOff;
            //关闭加热
            [_bluetooth setTemperatureEnd];
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
//提醒他的按钮事件
-(void)remindMessageDown{
    NLRemindMessageViewController *vc = [[NLRemindMessageViewController alloc] init];
    vc.backImage = [self imageFromView];
    [vc setHidesBottomBarWhenPushed:YES];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
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
#pragma mark 新手引导
-(void)noviceGuideIMG{
    
    
    if ([[kAPPDELEGATE._loacluserinfo getNoviceGuide] isEqualToString:@"1"]) {
        _noviceGuideIndex = 0;
        UIButton *noviceGuideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        noviceGuideBtn.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle tabBarSize]);
        [noviceGuideBtn addTarget:self action:@selector(noviceGuideDown:) forControlEvents:UIControlEventTouchUpInside];
        noviceGuideBtn.tag = NOVICEGUIDETAG;
        //    noviceGuideBtn.backgroundColor = [UIColor redColor];
        [noviceGuideBtn setImage:[UIImage imageNamed:@"NL_NoviceGuide_6_0"] forState:UIControlStateNormal];
        [self.view addSubview:noviceGuideBtn];
        
        if (SCREENHEIGHT == iPhone5Height) {
            [noviceGuideBtn setImage:[UIImage imageNamed:@"NL_NoviceGuide_0"] forState:UIControlStateNormal];
        }
        _noviceGuideIndex++;
    }
}
-(void)noviceGuideDown:(UIButton *)btn{
    
    switch (_noviceGuideIndex) {
        case 0: {
            [self noviceGuideBtn:btn image_5:[UIImage imageNamed:@"NL_NoviceGuide_0"] image_6:[UIImage imageNamed:@"NL_NoviceGuide_6_0"]];
            _noviceGuideIndex++;
            break;
        }
        case 1: {
            [self noviceGuideBtn:btn image_5:[UIImage imageNamed:@"NL_NoviceGuide_1"] image_6:[UIImage imageNamed:@"NL_NoviceGuide_6_1"]];
            _noviceGuideIndex++;
            break;
        }
        case 2: {
            [self noviceGuideBtn:btn image_5:[UIImage imageNamed:@"NL_NoviceGuide_2"] image_6:[UIImage imageNamed:@"NL_NoviceGuide_6_2"]];
            _noviceGuideIndex++;
            break;
        }
        case 3: {
            [self noviceGuideBtn:btn image_5:[UIImage imageNamed:@"NL_NoviceGuide_3"] image_6:[UIImage imageNamed:@"NL_NoviceGuide_6_3"]];
            _noviceGuideIndex++;
            btn.hidden = YES;
            break;
        }
        default:
            break;
    }
}

- (void)noviceGuideBtn:(UIButton *)btn image_5:(UIImage *)image_5 image_6:(UIImage *)image_6{
    if (SCREENHEIGHT == iPhone5Height) {
        [btn setImage:image_5 forState:UIControlStateNormal];
    }else{
        [btn setImage:image_6 forState:UIControlStateNormal];
    }
}

- (UIImage *)imageFromView {
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
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
