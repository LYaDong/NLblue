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

@interface NLMyHerViewController ()

@end

@implementation NLMyHerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [ApplicationStyle subjectBackViewColor];
    
    
    self.returnBtn.hidden = YES;
    self.titles.text = NSLocalizedString(@"NLMyHer_titls", nil);
    [self bulidUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark 基础UI
-(void)bulidUI{
    [self generateQRCode];
//    [self periodCircleView];
//    [self pregnancyIndex];
}
-(void)generateQRCode{
    UIImage *qrcode = [ApplicationStyle createNonInterpolatedUIImageFormCIImage:
                       [ApplicationStyle createQRForString:
                        [kAPPDELEGATE._loacluserinfo GetUser_ID]] withSize:SCREENWIDTH];
    UIImageView *imagex = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    imagex.image =  qrcode;
    imagex.backgroundColor = [UIColor redColor];
    [self.view addSubview:imagex];
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
#pragma mark 自己的Delegate
#pragma mark 自己的按钮事件

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
