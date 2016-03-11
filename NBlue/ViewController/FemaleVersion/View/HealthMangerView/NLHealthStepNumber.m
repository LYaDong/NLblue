//
//  NLHealthStepNumber.m
//  NBlue
//
//  Created by LYD on 15/11/24.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLHealthStepNumber.h"
#import "NLColumnImage.h"
#import "NLStepImageLabView.h"
#import "NLStepColumnImage.h"
#import "NLSQLData.h"
#import "NLHealthStepNumberCell.h"
#import "NLBluetoothAgreement.h"
#import "NLBluetoothAgreementNew.h"
@interface NLHealthStepNumber()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIButton *stepNumber;
@property(nonatomic,strong)UILabel *maxStepNumber;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *sportData;
@property(nonatomic,strong)NLBluetoothAgreementNew *bluetooth;

@end

@implementation NLHealthStepNumber
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self bulidUI];
        [self notification];
    }
    return self;
}
-(void)bulidUI{
    
    [self loadData];
    
    _bluetooth = [NLBluetoothAgreementNew shareInstance];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.backgroundColor = [@"fffff8" hexStringToColor];
    [self addSubview:_tableView];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
}
-(void)notification{
    NSNotificationCenter *notifi= [NSNotificationCenter defaultCenter];
    [notifi addObserver:self selector:@selector(refishData) name:RefrefhStopDataNotification object:nil];
}
-(void)timeDown{
    [_tableView reloadData];
}

-(void)loadData{
    _sportData = [NSMutableArray array];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *array = [NSMutableArray array];
//        unsigned units  = NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSSecondCalendarUnit|NSMinuteCalendarUnit;
//        NSCalendar *myCal = [NSCalendar currentCalendar];
//        NSDateComponents *comp1 = [myCal components:units fromDate:[NSDate date]];
//        comp1.year = 2016;
//        comp1.month = 1;
//        comp1.day = 7;
//        comp1.hour = 0;
//        comp1.minute = 0;
//        comp1.second = 0;
//        NSDate *dayDime = [myCal dateFromComponents:comp1];
        
        NSDate *dayDime = [NSDate date];
        
        
        NSLog(@"%@",[ApplicationStyle datePickerTransformationCorss:dayDime]);
        
        array = [NLSQLData sportDataObtainTimeStr:[ApplicationStyle datePickerTransformationCorss:dayDime]];

        NSLog(@"%@",array);
        dispatch_async(dispatch_get_main_queue(), ^{
            [_sportData removeAllObjects];
            [_sportData addObjectsFromArray:array];
            [_tableView reloadData];
        });
    });
}

#pragma mark 系统代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.frame.size.height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"LYD";
    NLHealthStepNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[NLHealthStepNumberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
 
    }
    
    NSMutableArray *sportData = [NSMutableArray array];
    for (UIView *subView in cell.contentView.subviews)
    {
        [subView removeFromSuperview];
    }
    
    NSMutableArray *stepFragments = [NSMutableArray array];
    
    
    NSInteger count = 0;
    if (_sportData.count != 0) {
        [stepFragments addObjectsFromArray: [_sportData[0] objectForKey:@"stepFragments"]];
        
        NSMutableArray *serisArray = [NSMutableArray array];
        NSMutableArray *dataSerisArray = [NSMutableArray array];
        for (NSInteger i=0; i<stepFragments.count; i++) {
            NSString * seris = [stepFragments[i] objectForKey:@"seris"];
            NSArray *arrseris = [ApplicationStyle interceptText:seris interceptCharacter:@"-"];
            [serisArray addObject:arrseris[3]];
        }
        
        
        for (NSInteger i=0; i<96; i++) {
            [dataSerisArray addObject:@"0"];
        }
        for (NSInteger i=0; i<dataSerisArray.count; i++) {
            for (NSInteger j=0; j<serisArray.count; j++) {
                if (i == [serisArray[j] integerValue]) {
                    NSString *step = [stepFragments[j] objectForKey:@"steps"];
                    [dataSerisArray replaceObjectAtIndex:i withObject:step];
                }
            }
        }
        for (int i=0; i<dataSerisArray.count; i++) {
            count = count + [dataSerisArray[i] integerValue];
            if (i%4 ==0) {
                [sportData addObject:[NSNumber numberWithInteger:count]];
                count = 0;
            }
        }
    }
    
    
    
    
    [cell histogram:sportData
          sportData:_sportData 
             target:4000];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}



-(void)loadNewData{
    
    if ([kAPPDELEGATE._loacluserinfo getBluetoothName] == nil) {
        [_tableView.mj_header endRefreshing];
        [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"你还没有连接设备"];
        return;
    }
    
    [_bluetooth sportDataQuery];
    
//    NSMutableArray *dataArr = [NSMutableArray array];
//    NLBluetoothAgreement *blues = [NLBluetoothAgreement shareInstance];
//    dataArr  = blues.arrPeripheral;
//    {
//        Byte byte[20] = {0x08,0x01,0x01,0x01};
//        NSData *data = [NSData dataWithBytes:byte length:20];
//        if (dataArr.count>0) {
//            [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:dataArr[0] data:data];
//            NSLog(@"发送命令==  %@",data);
//        }
//    }
//    {
//        Byte byte[20] = {0x08,0x03,0x01};
//        NSData *data = [NSData dataWithBytes:byte length:20];
//        if (dataArr.count>0) {
//            [[NLBluetoothAgreement shareInstance] writeCharacteristicF1:dataArr[0] data:data];
//            //        [[NLBluetoothAgreement shareInstance] writeCharacteristicF6:_peripheralArray[0] data:data];
//            NSLog(@"发送命令==  %@",data);
//        }
//    }
}
-(void)refishData{
    [_tableView.mj_header endRefreshing];
    [self loadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
