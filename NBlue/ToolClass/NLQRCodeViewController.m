//
//  NLQRCodeViewController.m
//  NBlue
//
//  Created by LYD on 16/1/12.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLQRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface NLQRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (strong, nonatomic) UIImageView *imageviewLine;
@property (assign, nonatomic) BOOL is_AnmotionFinished;
@end

@implementation NLQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    {
        self.navBarBack.hidden = YES;
        self.navBarPushBack.hidden = NO;
        self.controllerBack.hidden = YES;
    }
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [ApplicationStyle subjectBackViewColor];
    
    self.titles.text = NSLocalizedString(@"NLProfileView_SweepMale", nil);
    [self bulidUI];
    [self viewBack];
    [self imageLine];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark 基础UI
-(void)bulidUI{
    // 1. 摄像头设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2. 设置输入
    // 因为模拟器是没有摄像头的，因此在此最好做一个判断
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if (error) {
        NSLog(@"没有摄像头-%@", error.localizedDescription);
        
        return;
    }
    
    // 3. 设置输出(Metadata元数据)
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    // 3.1 设置输出的代理
    // 说明：使用主线程队列，相应比较同步，使用其他队列，相应不同步，容易让用户产生不好的体验
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //    [output setMetadataObjectsDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
    // 4. 拍摄会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    // 添加session的输入和输出
    [session addInput:input];
    
    // 4.1 设置输出的格式
    // 提示：一定要先设置会话的输出为output之后，再指定输出的元数据类型！
    if (output) {
        [session addOutput:output];
        NSMutableArray *a = [[NSMutableArray alloc] init];
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
            [a addObject:AVMetadataObjectTypeQRCode];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN13Code]) {
            [a addObject:AVMetadataObjectTypeEAN13Code];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN8Code]) {
            [a addObject:AVMetadataObjectTypeEAN8Code];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode128Code]) {
            [a addObject:AVMetadataObjectTypeCode128Code];
        }
        output.metadataObjectTypes=a;
    }
//    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
//    
//    [output  setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode, nil]];
    
    // 5. 设置预览图层（用来让用户能够看到扫描情况）
    AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession:session];
    // 5.1 设置preview图层的属性
    [preview setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    // 5.2 设置preview图层的大小
    [preview setFrame:self.view.bounds];
    // 5.3 将图层添加到视图的图层
    [self.view.layer insertSublayer:preview atIndex:0];
    self.previewLayer = preview;
    
    // 6. 启动会话
    [session startRunning];
    
    self.session = session;
}
-(void)viewBack{
    
    
    CGFloat w = [ApplicationStyle control_weight:440],h = [ApplicationStyle control_height:440];
    
    UIImageView *qrEdge = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - w)/2,
                                                                        [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize]+((SCREENHEIGHT - [ApplicationStyle navigationBarSize] - [ApplicationStyle statusBarSize]) - h)/2,
                                                                        w,
                                                                        h)];
    qrEdge.image = [UIImage imageNamed:@"NL_QR_Edge"];
    [self.view addSubview:qrEdge];

    
    UIView *liftView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize]+((SCREENHEIGHT - [ApplicationStyle navigationBarSize] - [ApplicationStyle statusBarSize]) - [ApplicationStyle control_height:440])/2,
                                                                (SCREENWIDTH - w)/2,
                                                                h)];
    liftView.backgroundColor = [self backViewColor];
    liftView.alpha = 0.4;
    [self.view addSubview:liftView];
    
    UIView *upView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize],
                                                                SCREENWIDTH,
                                                                ((SCREENHEIGHT - [ApplicationStyle navigationBarSize] - [ApplicationStyle statusBarSize]) - h)/2)];
    upView.backgroundColor = [self backViewColor];
    upView.alpha = 0.4;
    [self.view addSubview:upView];
    
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake((SCREENWIDTH - w)/2+w,
                                                                [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize]+((SCREENHEIGHT - [ApplicationStyle navigationBarSize] - [ApplicationStyle statusBarSize]) - [ApplicationStyle control_height:440])/2,
                                                                (SCREENWIDTH - w)/2,
                                                                h)];
    rightView.backgroundColor = [self backViewColor];
    rightView.alpha = 0.4;
    [self.view addSubview:rightView];
    
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize] + ((SCREENHEIGHT - [ApplicationStyle navigationBarSize] - [ApplicationStyle statusBarSize]) - h)/2 + h,
                                                              SCREENWIDTH,
                                                              SCREENHEIGHT - [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize] + ((SCREENHEIGHT - [ApplicationStyle navigationBarSize] - [ApplicationStyle statusBarSize]) - h)/2 + h)];
    downView.backgroundColor = [self backViewColor];
    downView.alpha = 0.4;
    [self.view addSubview:downView];
    
    
    CGSize labTextSize = [ApplicationStyle textSize:NSLocalizedString(@"NLProfileView_QRMaleText", nil) font:[ApplicationStyle textThrityFont] size:SCREENWIDTH];
    
    UILabel *labText = [[UILabel alloc] initWithFrame:CGRectMake(0, qrEdge.bottomOffset + [ApplicationStyle control_height:16], SCREENWIDTH, labTextSize.height)];
    labText.text = NSLocalizedString(@"NLProfileView_QRMaleText", nil);
    labText.textColor = [ApplicationStyle subjectWithColor];
    labText.numberOfLines = 0;
    labText.textAlignment = NSTextAlignmentCenter;
    labText.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:24]];
    [self.view addSubview:labText];
    
    
}

-(void)imageLine{
    _is_AnmotionFinished = NO;
    CGFloat w = [ApplicationStyle control_weight:440],h = [ApplicationStyle control_height:440];
    _imageviewLine = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - w)/2,
                                                                   [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize]+((SCREENHEIGHT - [ApplicationStyle navigationBarSize] - [ApplicationStyle statusBarSize]) - h)/2,
                                                                   w,
                                                                   [ApplicationStyle control_height:8])];
    _imageviewLine.image = [UIImage imageNamed:@"NL_QR_Line"];
    [self.view addSubview:_imageviewLine];
    
    
    
    [UIView animateWithDuration:2 animations:^{
        _imageviewLine.frame = CGRectMake((SCREENWIDTH - w)/2,
                                          [ApplicationStyle navigationBarSize] + [ApplicationStyle statusBarSize] + ((SCREENHEIGHT - [ApplicationStyle navigationBarSize] - [ApplicationStyle statusBarSize]) - h)/2 + h - [ApplicationStyle control_height:8],
                                          w,
                                          [ApplicationStyle control_height:8]);
    } completion:^(BOOL finished) {
        [_imageviewLine removeFromSuperview];
        [self imageLine];
    }];
}

#pragma mark 系统Delegate

// 此方法是在识别到QRCode，并且完成转换
// 如果QRCode的内容越大，转换需要的时间就越长
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    // 会频繁的扫描，调用代理方法
    // 1. 如果扫描完成，停止会话
    [self.session stopRunning];
    // 2. 删除预览图层
    [self.previewLayer removeFromSuperlayer];
    AVMetadataMachineReadableCodeObject *str = metadataObjects[0];
    
    if (self.qrCount) {
        self.qrCount(str.stringValue);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 自己的Delegate
#pragma mark 自己的按钮事件
-(UIColor *)backViewColor{
    UIColor *color = [ApplicationStyle subjectBlackColor];
    return color;
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
