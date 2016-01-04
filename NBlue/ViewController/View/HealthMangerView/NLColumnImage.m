//
//  NLColumnImage.m
//  NBlue
//
//  Created by LYD on 15/12/1.
//  Copyright © 2015年 LYD. All rights reserved.
//

static const NSInteger LABTIMETAG = 2000;
static const NSInteger BTNTAB = 3000;

#import "NLColumnImage.h"
static NLColumnImage *cloumnImage = nil;
@interface NLColumnImage()<UIScrollViewDelegate>
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,assign)CGFloat convenImageWeight;
@property(nonatomic,strong)UIColor *strokeColor;
@property(nonatomic,strong)UIColor *withColor;
//@property(nonatomic,assign)NSInteger type;
//@property(nonatomic,strong)NSArray *labTimeArr;
//@property(nonatomic,assign)CGContextRef context;
@property(nonatomic,strong)UIScrollView *mainScrollew;
@end
@implementation NLColumnImage
- (instancetype)initWithFrame:(CGRect)frame DataArr:(NSArray *)arr
                    strokeColor:(UIColor *)strokeColor
                      withColor:(UIColor *)withColor
                           type:(NSInteger)type
                     timeLabArr:(NSArray *)labTimeArr{
    if (self = [super initWithFrame:frame]) {
        _dataArr = arr;
        _strokeColor = strokeColor;
        _withColor = withColor;
//        _type = type;
        
        [self builArrd:arr strokeColor:strokeColor withColor:withColor type:type];
    }
    return self;
}


-(void)builArrd:(NSArray *)arr strokeColor:(UIColor *)strokeColor withColor:(UIColor *)withColor type:(NSInteger)type{
    switch (type) {
        case NLCalendarType_Day:
        {
            _convenImageWeight = [ApplicationStyle control_weight:50];
            
            break;
        }
        case NLCalendarType_Week:
        {
            _convenImageWeight = [ApplicationStyle control_weight:90];
            break;
        }
        case NLCalendarType_Month:
        {
            _convenImageWeight = [ApplicationStyle control_weight:120];
            break;
        }
        default:
            break;
    }
    
    
    
    CGFloat weightSize = arr.count * (_convenImageWeight + [ApplicationStyle control_weight:10]) - _convenImageWeight - [ApplicationStyle control_weight:10];
    CGFloat height = self.frame.size.height;
    
    
    _mainScrollew = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, height)];
    _mainScrollew.delegate = self;
    _mainScrollew.showsVerticalScrollIndicator = FALSE;
    _mainScrollew.showsHorizontalScrollIndicator = FALSE;
    _mainScrollew.contentSize = CGSizeMake(weightSize + SCREENWIDTH, height);
    _mainScrollew.contentOffset = CGPointMake(weightSize, 0);
    [self addSubview:_mainScrollew];
    
    


    UIView *columnarBack = [[UIView alloc] initWithFrame:CGRectMake(((weightSize + SCREENWIDTH) - (weightSize + _convenImageWeight))/2, 0, weightSize + _convenImageWeight, height)];
    [_mainScrollew  addSubview:columnarBack];
    
    UIView *timeLabBack = [[UIView alloc] initWithFrame:CGRectMake(((weightSize + SCREENWIDTH) - (weightSize + _convenImageWeight))/2, height - [ApplicationStyle control_height:60], weightSize + _convenImageWeight, [ApplicationStyle control_height:60])];
    [_mainScrollew addSubview:timeLabBack];
    
  
    NSMutableArray *dataSport = [NSMutableArray array];
    for (NSInteger i=0; i<arr.count; i++) {
        [dataSport addObject:[arr[i] objectForKey:@"stepsAmount"]];
    }
    
    CGFloat num = 0.1;
    for (NSInteger i=0; i<dataSport.count; i++) {
        if ([[NSString stringWithFormat:@"%@",dataSport[i]] intValue] > num) {
            num = [[NSString stringWithFormat:@"%@",dataSport[i]] intValue];
        }
    }
    NSMutableArray *ht = [NSMutableArray array];
    for (NSInteger i=0; i<dataSport.count; i++) {
        NSInteger index = [[NSString stringWithFormat:@"%@",dataSport[i]] integerValue];
        [ht addObject:[NSNumber numberWithInteger:index * (height * 0.8)/num]];
    }
    
    for (NSInteger i =0 ; i<arr.count; i++) {
        
        
        NSInteger num = [[NSString stringWithFormat:@"%@",ht[i]] integerValue];
        
        UIButton *columnarBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        columnarBtn.frame = CGRectMake(columnarBack.viewWidth - _convenImageWeight  - i* (_convenImageWeight + [ApplicationStyle control_weight:10]), (height - [ApplicationStyle control_weight:60]) - num, _convenImageWeight,num);
        columnarBtn.backgroundColor = _withColor;
        if (i==0) {
            columnarBtn.backgroundColor = [@"ffd890" hexStringToColor];
        }
        columnarBtn.tag = BTNTAB + i;
        [columnarBtn addTarget:self action:@selector(columnarBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        [columnarBack addSubview:columnarBtn];


        UILabel *labTime = [[UILabel alloc] initWithFrame:CGRectMake(columnarBack.viewWidth - _convenImageWeight  - i * (_convenImageWeight + [ApplicationStyle control_weight:10]),
                                                                     ([ApplicationStyle control_height:60] - [ApplicationStyle control_height:30])/2,
                                                                     _convenImageWeight,
                                                                     [ApplicationStyle control_height:30])];

        NSString *time = [arr[i] objectForKey:@"sportDate"];
        NSArray *timeArr = [time componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
        labTime.text = [NSString stringWithFormat:@"%@/%@",timeArr[1],timeArr[2]];
        labTime.textColor = [ApplicationStyle subjectWithColor];
//        if (i == 0) {
//            labTime.text = @"今天";
//            labTime.textColor = [UIColor redColor];
//        }
//        if (i == 1) {
//            labTime.text = @"昨天";
//        }

        labTime.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:16]];
        labTime.textAlignment = NSTextAlignmentCenter;
        labTime.tag = LABTIMETAG + i;
        [timeLabBack addSubview:labTime];
        
    }
    
    
}


#pragma mark 系统Delegate
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    for (NSInteger i=0; i<_dataArr.count; i++) {
//        UILabel *timeLab = (UILabel *)[self viewWithTag:LABTIMETAG + i];
//        timeLab.textColor = [ApplicationStyle subjectWithColor];
//        
//        UIButton *columBtn = (UIButton *)[self viewWithTag:BTNTAB + i];
//        columBtn.backgroundColor = _withColor;
//    }
//    NSInteger change = [[NSString stringWithFormat:@"%0.0f",scrollView.contentOffset.x/(_convenImageWeight + [ApplicationStyle control_weight:10])] integerValue];
//    UILabel *timeLab = (UILabel *)[self viewWithTag:LABTIMETAG + ((_dataArr.count - 1) - change)];
//    
//    UIButton *columBtn = (UIButton *)[self viewWithTag:BTNTAB + ((_dataArr.count - 1) - change)];
//    
//    
//    CGFloat weight = _dataArr.count - 1;//总个数
//    CGFloat scrollX = scrollView.contentOffset.x/(_convenImageWeight + [ApplicationStyle control_weight:10]);//每个平分长度
//    CGFloat startPoint = (NSInteger)(weight - scrollX) + 0.5;//起点位置
//    CGFloat endPoint = weight - scrollX;//结束点位置
//    
//    if (startPoint<=0) {
//        
//        timeLab.textColor = [UIColor redColor];
//        columBtn.backgroundColor = [@"ffd890" hexStringToColor];
//    }else{
//        [UIView animateWithDuration:0.5 animations:^{
//            if (endPoint>=startPoint) {
//                timeLab.textColor = [UIColor redColor];
//                columBtn.backgroundColor = [@"ffd890" hexStringToColor];
//            }else{
//                timeLab.textColor = [UIColor redColor];
//                columBtn.backgroundColor = [@"ffd890" hexStringToColor];
//            }
//        }];
//    }
//}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    for (NSInteger i=0; i<_dataArr.count; i++) {
        UILabel *timeLab = (UILabel *)[self viewWithTag:LABTIMETAG + i];
        timeLab.textColor = [ApplicationStyle subjectWithColor];
        UIButton *columBtn = (UIButton *)[self viewWithTag:BTNTAB + i];
        columBtn.backgroundColor = _withColor;
    }
    
    [self scrollViewAnimation:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewAnimation:scrollView];
}

-(void)scrollViewAnimation:(UIScrollView *)scrollView{
    
    NSString *index = [NSString stringWithFormat:@"%0.0f",scrollView.contentOffset.x/(_convenImageWeight + [ApplicationStyle control_weight:10])];
    [self.delegate sildeIndex:[index integerValue]];
    
    
    
    CGFloat toLength = (_dataArr.count - 1) * (_convenImageWeight + [ApplicationStyle control_weight:10]); //总长度
    CGFloat weight = _dataArr.count - 1;//总个数
    CGFloat scrollX = scrollView.contentOffset.x/(_convenImageWeight + [ApplicationStyle control_weight:10]);//每个平分长度
    CGFloat startPoint = (NSInteger)(weight - scrollX) + 0.5;//起点位置
    CGFloat endPoint = weight - scrollX;//结束点位置
    
    if (startPoint<=0) {
        scrollView.contentOffset = CGPointMake(scrollX, scrollView.contentOffset.y);
    }else{
        NSInteger centPoint = (NSInteger)(endPoint + 0.5);//中间点位置
        [UIView animateWithDuration:0.5 animations:^{
            if (endPoint>=startPoint) {
                [self changeBack:scrollView];
                scrollView.contentOffset = CGPointMake(toLength -(centPoint * (_convenImageWeight + [ApplicationStyle control_weight:10])), scrollView.contentOffset.y);
            }else{
                [self changeBack:scrollView];
                scrollView.contentOffset = CGPointMake(toLength -(centPoint * (_convenImageWeight + [ApplicationStyle control_weight:10])), scrollView.contentOffset.y);
            }
        }];
    }
}

-(void)changeBack:(UIScrollView *)scrollView{
    NSInteger change = [[NSString stringWithFormat:@"%0.0f",scrollView.contentOffset.x/(_convenImageWeight + [ApplicationStyle control_weight:10])] integerValue];
    UIButton *columBtn = (UIButton *)[self viewWithTag:BTNTAB + ((_dataArr.count - 1) - change)];
    UILabel *lab = (UILabel *)[self viewWithTag:LABTIMETAG + ((_dataArr.count - 1) - change)];
    lab.textColor = [UIColor redColor];
    columBtn.backgroundColor = [@"ffd890" hexStringToColor];
}


-(void)columnarBtnDown:(UIButton *)btn{
    CGFloat toLength = (_dataArr.count - 1) * (_convenImageWeight + [ApplicationStyle control_weight:10]); //总长度
    NSInteger centPoint = (NSInteger)((btn.tag - BTNTAB) + 0.5);//中间点位置
    
    [UIView animateWithDuration:0.5 animations:^{
       _mainScrollew.contentOffset = CGPointMake(toLength -(centPoint * (_convenImageWeight + [ApplicationStyle control_weight:10])), _mainScrollew.contentOffset.y);
    }];
}

//- (void)drawRect:(CGRect)rect{
//    
//    _context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(_context, 1);
//
//    
//    
//    
//    
//    
//    //    CGContextSetStrokeColorWithColor(context, _strokeColor.CGColor);
//    //    CGContextSetFillColorWithColor(context, _strokeColor.CGColor);
//    //    CGContextMoveToPoint(context, [ApplicationStyle control_weight:40], [ApplicationStyle control_height:480]);
//    //    for (NSInteger i=0; i<_arr.count; i++) {
//    //        NSInteger num = [[NSString stringWithFormat:@"%@",_arr[i]] integerValue];
//    //        CGContextAddRect(context, CGRectMake([ApplicationStyle control_weight:38]+ i * (SCREENWIDTH - [ApplicationStyle control_weight:80])/_arr.count, [ApplicationStyle control_height:480] - num + [ApplicationStyle control_height:5],  (SCREENWIDTH - [ApplicationStyle control_weight:80])/_arr.count - [ApplicationStyle control_weight:10], num - [ApplicationStyle control_height:5]));
//    //    }
//    
//    
//    CGContextDrawPath(_context, kCGPathFillStroke);
//    CGContextSetStrokeColorWithColor(_context, _withColor.CGColor);
//    CGContextSetFillColorWithColor(_context, _withColor.CGColor);
//
//    
//    //    CGContextMoveToPoint(context, self.frame.size.width, [ApplicationStyle control_height:480]);
//    //    CGContextAddRect(context,
//    //                     CGRectMake(self.frame.size.width - [ApplicationStyle control_weight:90], 0, [ApplicationStyle control_weight:90], 100))
//    //    ;
//    
//    
//    NSInteger ToPointW = 0;
//    CGFloat weidh = 0.0f;
//
//    switch (_type) {
//        case NLCalendarType_Ordinary:
//        {
//            ToPointW = [ApplicationStyle control_weight:40];
//            
//            CGContextMoveToPoint(_context, ToPointW, [ApplicationStyle control_height:480]);
//            for (NSInteger i=0; i<_arr.count; i++) {
//                NSInteger num = [[NSString stringWithFormat:@"%@",_arr[i]] integerValue];
//                CGContextAddRect(_context,
//                                 CGRectMake([ApplicationStyle control_weight:40]+ i * (SCREENWIDTH - [ApplicationStyle control_weight:80])/_arr.count,
//                                            [ApplicationStyle control_height:480] - num ,
//                                            (SCREENWIDTH - [ApplicationStyle control_weight:80])/_arr.count - [ApplicationStyle control_weight:10],
//                                            num));
//            }
//
//            
//            
//            //            [self labTimeToPointW:<#(CGFloat)#> weight:<#(CGFloat)#> height:<#(CGFloat)#> arr:<#(NSArray *)#> context:<#(CGContextRef)#>]
//            break;
//        }
//        case NLCalendarType_Day:
//        {
//            ToPointW = self.frame.size.width;
//            weidh = [ApplicationStyle control_weight:50];
//            [self labTimeToPointW:ToPointW weight:weidh height:[ApplicationStyle control_height:480] arr:_arr context:_context];
//            
//            break;
//        }
//        case NLCalendarType_Week:
//        {
//            ToPointW = self.frame.size.width;
//            weidh = [ApplicationStyle control_weight:90];
//            [self labTimeToPointW:ToPointW weight:weidh height:[ApplicationStyle control_height:480] arr:_arr context:_context];
//            break;
//        }
//        case NLCalendarType_Month:
//        {
//            ToPointW = self.frame.size.width;
//            weidh = [ApplicationStyle control_weight:120];
//            [self labTimeToPointW:ToPointW weight:weidh height:[ApplicationStyle control_height:480] arr:_arr context:_context];
//            break;
//        }
//        default:
//            break;
//    }
//    
//    
//    CGContextDrawPath(_context, kCGPathFillStroke);
//}
//#pragma mark 从右到左
//-(void)labTimeToPointW:(CGFloat)toPointW weight:(CGFloat)weight height:(CGFloat)height arr:(NSArray *)arr context:(CGContextRef)context{
//    
//    for (NSInteger i=0; i<arr.count; i++) {
//        
//        NSInteger num = [[NSString stringWithFormat:@"%@",_arr[i]] integerValue];
//        CGContextAddRect(context,
//                         CGRectMake(toPointW -  weight - i * (weight + [ApplicationStyle control_weight:10]),
//                                    height - num ,
//                                    weight,
//                                    num));
//        
////        UILabel *labTime = [[UILabel alloc] initWithFrame:CGRectMake(toPointW - weight - i * (weight + [ApplicationStyle control_weight:10]),
////                                                                     height + ([ApplicationStyle control_height:60] - [ApplicationStyle control_height:30])/2,
////                                                                     weight,
////                                                                     [ApplicationStyle control_height:30])];
////        labTime.text = @"11/11";
////        if (i == 0) {
////            labTime.text = @"今天";
////        }
////        if (i == 1) {
////            labTime.text = @"昨天";
////        }
////        labTime.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:18]];
////        labTime.textColor = [ApplicationStyle subjectWithColor];
////        labTime.textAlignment = NSTextAlignmentCenter;
////        labTime.tag = LABTIMETAG + i;
////        [self addSubview:labTime];
////        
////        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        btn.frame = CGRectMake(toPointW -  weight - i * (weight + [ApplicationStyle control_weight:10]),
//                               height - num ,
//                               weight,
//                               num);
////        btn.backgroundColor = [UIColor redColor];
//        btn.tag = BTNTAB + i;
//        [btn addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btn];
//
//    }
//    
//    
//    
//    
//}
//
//
//
//
//
//-(void)btnDown:(UIButton *)btn{
//    NSLog(@"点击了第%ld个",btn.tag - BTNTAB + 1);
//    UILabel *labTime = (UILabel *)[self viewWithTag:LABTIMETAG + (btn.tag - BTNTAB)];
//    labTime.textColor = [UIColor redColor];
//}
//
//- (void)slideChangearr:(NSArray *)arr intx:(NSInteger)uin{
//    
//    
//    
//   
//    
//    
//    
//    NSInteger toPointW = 0;
//    CGFloat weight = 0.0f;
//    CGFloat height = [ApplicationStyle control_height:480];
//    
//    toPointW = self.frame.size.width;
//    weight = [ApplicationStyle control_weight:50];
//    
//    
//    for (NSInteger i =0 ; i<arr.count; i++) {
//        UILabel *labTime = [[UILabel alloc] initWithFrame:CGRectMake(toPointW - weight - i * (weight + [ApplicationStyle control_weight:10]),
//                                                                     height + ([ApplicationStyle control_height:60] - [ApplicationStyle control_height:30])/2,
//                                                                     weight,
//                                                                     [ApplicationStyle control_height:30])];
//        labTime.text = @"11/11";
//        labTime.textColor = [ApplicationStyle subjectWithColor];
//        if (i == 0) {
//            labTime.text = @"今天";
//        }
//        if (i == 1) {
//            labTime.text = @"昨天";
//        }
//        if (i == uin) {
//            labTime.text = @"cccc";
//        }
//        
//        labTime.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:18]];
//        labTime.textAlignment = NSTextAlignmentCenter;
//        labTime.tag = LABTIMETAG + i;
//        [self addSubview:labTime];
// 
//    }
//}
//
//-(void)vvvvv{
//     [self removeFromSuperview];
//}




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
