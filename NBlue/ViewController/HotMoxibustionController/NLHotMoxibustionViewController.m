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
@interface NLHotMoxibustionViewController ()
@property(nonatomic,strong)NSArray *peripheralArray;
@property(nonatomic,strong)UILabel *setTemperatureLab;
@property(nonatomic,strong)UILabel *timesLab;
@property(nonatomic,strong)UIButton *addTimesBtn;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.controllerBack.hidden = YES;
//    
//    self.view.backgroundColor = [@"f44c6d" hexStringToColor];
    
    
    self.titles.text = @"热灸";
//    self.returnBtn.hidden = YES;
    [self bulidUI];
    
    
    
//    for (int i =0; i < strtest.length; i+=2) {
//        NSString *strByte = [strtest substringWithRange:NSMakeRange(i,2)];
//        unsigned long red = strtoul([strByte UTF8String],0,16);
//        Byte b =  (Byte) ((0xff & red) );//( Byte) 0xff&iByte;
//        bt[i/2+0] = b;
//        
//        NSLog(@"%hhu",b);
//    }
    unsigned long red = strtoul([@"28" UTF8String],0,16);
    Byte b =  (Byte) ((0xff & red) );//( Byte) 0xff&iByte;
    

    Byte byte[20] = {0x90,0x03,b,0x00,0x08,0x00};
    
    NSData *data = [NSData dataWithBytes:byte length:20];
    NSLog(@"%@",data);
    
    
    
    
//
//
//    unsigned long red = strtoul([@"28" UTF8String],0,16);
//    Byte by = {(0xff) & red};
//    
//    NSLog(@"%lu",(0xff) & red);
//    Byte bytex[20] = {0x90,0x03,0x28,0x00,0x08,0x00};
//    NSLog(@"%s",bytex);
    
    
    
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
//    
//    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn3.frame = CGRectMake(100, 200, 100, 100);
//    btn3.backgroundColor = [UIColor greenColor];
//    [btn3 addTarget:self action:@selector(btnDown3) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn3];
    
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark 基础UI
-(void)bulidUI{
    NLBluetoothAgreement *blues = [NLBluetoothAgreement shareInstance];
    [blues bluetoothAllocInit];
    blues.getConnectData = ^(NSString *blueData){
        NSLog(@"%@",blueData);//获得数据
//        0201 db07 02 01 00 38 01 00
        [NLBluetoothDataAnalytical bluetoothCommandReturnData:blueData];
    };
    blues.perheral = ^(NSArray *perpheral){
        _peripheralArray = perpheral;//获得当前的外围设备
    };
    

    [self halfCircle];
    [self corcleCount];
    [self downBtns];
}
-(void)halfCircle{
    LineProgressView *lineProgressView = [[LineProgressView alloc] initWithFrame:CGRectMake((SCREENWIDTH-[ApplicationStyle control_weight:235*2])/2.0, [ApplicationStyle control_height:200], [ApplicationStyle control_weight:235*2], [ApplicationStyle control_weight:235*2])];
//    lineProgressView.backgroundColor = [UIColor whiteColor];
    lineProgressView.delegate = self;
    lineProgressView.total = 51;
    lineProgressView.color = [@"f7f3ff" hexStringToColor];
    lineProgressView.radius = [ApplicationStyle control_weight:235*2]/2;
//    lineProgressView.innerRadius = [ApplicationStyle control_weight:400]/2;
    lineProgressView.startAngle = M_PI * 0.78;
    lineProgressView.endAngle = M_PI * 2.3;
    lineProgressView.completedColor = [@"ffde6a" hexStringToColor];
    //    lineProgressView.animationDuration = 2.0;
    lineProgressView.layer.shouldRasterize = YES;
    [self.view addSubview:lineProgressView];
    [lineProgressView setCompleted:30 animated:YES];
    
    
    
    UIImageView *images = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:200*2])/2, [ApplicationStyle control_height:240], [ApplicationStyle control_weight:200 *2], [ApplicationStyle control_height:200 *2])];
    images.image = [UIImage imageNamed:@"000"];
    [self.view addSubview:images];
    
    
    
}
-(void)corcleCount{
    _setTemperatureLab = [[UILabel alloc] initWithFrame:CGRectMake(0, [ApplicationStyle control_height:400], SCREENWIDTH, [ApplicationStyle control_height:40])];
    _setTemperatureLab.text = @"36°C温度设置";
    _setTemperatureLab.textAlignment = NSTextAlignmentCenter;
    _setTemperatureLab.textColor = [UIColor whiteColor];
    _setTemperatureLab.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:20]];
    [self.view addSubview:_setTemperatureLab];
    [self heartReatlab:_setTemperatureLab andRang:NSMakeRange(0, 4)];
    
    NSString *strs = @"热灸时间 01:30";
    CGSize timesLabSize = [ApplicationStyle textSize:strs font:[UIFont systemFontOfSize:[ApplicationStyle control_weight:20]] size:SCREENWIDTH];
    _timesLab = [[UILabel  alloc] initWithFrame:CGRectMake(130, _setTemperatureLab.bottomOffset + [ApplicationStyle control_height:34], timesLabSize.width, timesLabSize.height)];
    _timesLab.text = strs;
    _timesLab.textColor = [UIColor whiteColor];
    _timesLab.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:20]];
    [self.view addSubview:_timesLab];
    
    _addTimesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addTimesBtn.frame = CGRectMake(_timesLab.rightSideOffset + [ApplicationStyle control_weight:20], _setTemperatureLab.bottomOffset + [ApplicationStyle control_height:34], 20, 20);
    _addTimesBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:_addTimesBtn];
    
    UIButton *offBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    offBtn.frame = CGRectMake((SCREENWIDTH - 20 )/2, _addTimesBtn.bottomOffset + [ApplicationStyle control_height:55], 20, 20);
    offBtn.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:offBtn];
    
   
}

-(void)downBtns{
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle control_height:561] + [ApplicationStyle statusBarSize]+[ApplicationStyle navigationBarSize], SCREENWIDTH, [ApplicationStyle control_height:2])];
    viewLine.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewLine];
    
    
    NSArray *effectBtnTextArr = @[NSLocalizedString(@"HotMoxibustion_Effect", nil),NSLocalizedString(@"HotMoxibustion_Comfort", nil)];
    int64_t type = 0;
    for (int i=0; i<effectBtnTextArr.count; i++) {
        if (i==0) {
            type = 0;
        }else{
            type = 1;
        }
        
        NLAboutImageBtn *imageBtn = [[NLAboutImageBtn alloc] initWithFrame:CGRectMake(0 + i*(SCREENWIDTH/2 + [ApplicationStyle control_weight:2]), viewLine.bottomOffset + [ApplicationStyle control_height:8], SCREENWIDTH/2 - [ApplicationStyle control_height:4], [ApplicationStyle control_height:89])
                                                                  type:type
                                                                  font:[ApplicationStyle textSuperSmallFont]
                                                                 color:[UIColor blackColor]
                                                                 image:[UIImage imageNamed:@"Health_Manger_X"]
                                                                  text:effectBtnTextArr[i]];
        imageBtn.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:imageBtn];

    }
    
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
