//
//  HotMoxibustionViewController.m
//  NBlue
//
//  Created by LYD on 15/11/23.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLHotMoxibustionViewController.h"
#import "NLBluetoothAgreement.h"
#import "NLBluetoothDataAnalytical.h"
#import "LineProgressView.h"
#import "NLAboutImageBtn.h"
#import "NLBluetoothDataAnalytical.h"
#import "NLHalfView.h"
#import "NLSQLData.h"
@interface NLHotMoxibustionViewController ()
@property(nonatomic,strong)NSArray *peripheralArray;
@property(nonatomic,strong)NSMutableArray *sportDataArr;
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
//    self.controllerBack.hidden = YES;
//    
//    self.view.backgroundColor = [@"f44c6d" hexStringToColor];
    
    self.returnBtn.hidden = YES;
    self.titles.text = @"热灸";
//    self.returnBtn.hidden = YES;
    [self bulidUI];
    
    _sportDataArr = [NSMutableArray array];
    

    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn.frame = CGRectMake(40, 100, 40, 40);
//    btn.backgroundColor = [UIColor redColor];
//    [btn addTarget:self action:@selector(btnDown) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//    
//    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn1.frame = CGRectMake(100, 100, 100, 100);
//    btn1.backgroundColor = [UIColor yellowColor];
//    [btn1 addTarget:self action:@selector(btnDown1) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn1];
//    
//    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn2.frame = CGRectMake(100, 400, 100, 100);
//    btn2.backgroundColor = [UIColor yellowColor];
//    [btn2 addTarget:self action:@selector(btnDown2) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn2];
////
//    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn3.frame = CGRectMake(200, 200, 100, 100);
//    btn3.backgroundColor = [UIColor greenColor];
//    [btn3 addTarget:self action:@selector(sportxx1) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn3];
//    
//    
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
    
    [NLBluetoothDataAnalytical blueSportOrdinArrayData:_sportDataArr];////测试假数据
    
    
    NLBluetoothAgreement *blues = [NLBluetoothAgreement shareInstance];
    [blues bluetoothAllocInit];
    blues.getConnectData = ^(NSString *blueData){
        [NLBluetoothDataAnalytical bluetoothCommandReturnData:blueData];
        
        NSString *format = [blueData substringWithRange:NSMakeRange(0, 4)];
        if ([format isEqualToString:EquiomentCommand_0803]) {
            [_sportDataArr addObject:blueData];
            
            NSLog(@"%lu",(unsigned long)_sportDataArr.count);
            
            
            if (_sportDataArr.count==34) {
                [NLBluetoothDataAnalytical blueSportOrdinArrayData:_sportDataArr];
            }
        }
    };
    blues.perheral = ^(NSArray *perpheral){
        _peripheralArray = perpheral;//获得当前的外围设备
    };
    
    [self loadStepData];
    [self halfCircle];
}
-(void)halfCircle{
    

    
    CGRect frame = CGRectMake((SCREENWIDTH - 270 )/2, 100, 270, 250);
    
    NLHalfView *vc = [[NLHalfView alloc] initWithFrame:frame
                                                   num:50
                                                 index:0
                                                redius:[ApplicationStyle control_weight:190]
                                                 width:[ApplicationStyle control_weight:40]
                                             starColor:[@"f7f3ff" hexStringToColor]
                                              endColor:[@"ffde6a" hexStringToColor]];
    
    vc.progressCount = 11;
    
    vc.backgroundColor = [UIColor clearColor];
    [self.view addSubview:vc];
    
    
    
    

    
    
//    LineProgressView *lineProgressView = [[LineProgressView alloc] initWithFrame:CGRectMake((SCREENWIDTH-[ApplicationStyle control_weight:235*2])/2.0, [ApplicationStyle control_height:200], [ApplicationStyle control_weight:235*2], [ApplicationStyle control_weight:235*2])];
////    lineProgressView.backgroundColor = [UIColor whiteColor];
//    lineProgressView.delegate = self;
//    lineProgressView.total = 51;
//    lineProgressView.color = [@"f7f3ff" hexStringToColor];
//    lineProgressView.radius = [ApplicationStyle control_weight:235*2]/2;
////    lineProgressView.innerRadius = [ApplicationStyle control_weight:400]/2;
//    lineProgressView.startAngle = M_PI * 0.78;
//    lineProgressView.endAngle = M_PI * 2.3;
//    lineProgressView.completedColor = [@"ffde6a" hexStringToColor];
//    //    lineProgressView.animationDuration = 2.0;
//    lineProgressView.layer.shouldRasterize = YES;
//    [self.view addSubview:lineProgressView];
//    [lineProgressView setCompleted:30 animated:YES];

    
    
//    UIImageView *images = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:200*2])/2, [ApplicationStyle control_height:240], [ApplicationStyle control_weight:200 *2], [ApplicationStyle control_height:200 *2])];
//    images.image = [UIImage imageNamed:@"000"];
//    [self.view addSubview:images];
    
    
    
}





-(void)loadStepData{
    
    NSDate *date = [ApplicationStyle whatMonth:[NSDate date] timeDay:0];
    NSString *starDate = [ApplicationStyle datePickerTransformationCorss:date];
    NSString *endDate = [ApplicationStyle datePickerTransformationCorss:[NSDate date]];
    
    
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
#pragma mark 自己的Delegate



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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
