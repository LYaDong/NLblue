//
//  NLHalfView.m
//  NBlue
//
//  Created by LYD on 15/12/4.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLHalfView.h"
#import "NLGestureRecognizer.h"
@interface NLHalfView()
@property(nonatomic,strong)NLGestureRecognizer *gestureRecognizer;
@property(nonatomic,assign)CGFloat startAngle;
@property(nonatomic,assign)CGFloat endAngle;

@property(nonatomic,assign)NSInteger num;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)CGFloat redius;
@property(nonatomic,assign)NSInteger width;
@property(nonatomic,strong)UIColor *starColor;
@property(nonatomic,strong)UIColor *endColor;
@property(nonatomic,assign)BOOL temperatureBOOL;


@end

@implementation NLHalfView


-(instancetype)initWithFrame:(CGRect)frame
                         num:(NSInteger)num
                       index:(NSInteger) index
                      redius:(CGFloat)redius
                       width:(NSInteger)width
                   starColor:(UIColor *)starColor
                    endColor:(UIColor *)endColor{
    if (self = [super initWithFrame:frame]) {
        _temperatureBOOL = NO;//判断让不让禁止滑动
        _num = num;
        _index = index;
        _redius = redius;
        _width = width;
        _starColor = starColor;
        _endColor = endColor;
        _gestureRecognizer = [[NLGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [self addGestureRecognizer:_gestureRecognizer];
        [self temperatureNotification];

    }
    return self;
}


-(void)drawRect:(CGRect)rect{
    
    _startAngle = -(M_PI + M_PI_4);
    _endAngle = M_PI - (M_PI_4 + M_PI_2);
    
    [_starColor set];
    CGFloat sl = (2 * M_PI_2 - M_PI_4)/(_num + 5);
    
    for (int i=0; i<=_num; i++) {
        
        CGFloat startValue = (sl * i) + sl * i + (sl * i)/[ApplicationStyle control_weight:300];
        CGFloat startAngle, endAngle;
        startAngle =  -(M_PI + M_PI_4 - M_PI_4/4) + startValue ;
        endAngle = startAngle + sl;

        CGFloat redius = _redius;
        NSInteger width = _width;
        
        if (i==0 || i == 10 || i == 20 || i == 30|| i == 40|| i == 50) {
            redius = redius + [ApplicationStyle control_weight:10];
            width = width + [ApplicationStyle control_weight:20];
        }

        
        CGFloat x = self.frame.size.width/2,y = self.frame.size.height/2;

        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(x ,y)
                                                            radius:redius
                                                        startAngle:startAngle
                                                          endAngle:endAngle
                                                         clockwise:YES];
        
        path.lineWidth = width;
        [path stroke];
    }
    
    
    [_endColor set];
    
    for (int i=0; i<_index; i++) {
        
        CGFloat startValue = (sl * i) + sl * i + (sl * i)/[ApplicationStyle control_weight:300];
        CGFloat startAngle, endAngle;
        startAngle =  -(M_PI + M_PI_4 - M_PI_4/4) + startValue ;
        endAngle = startAngle + sl;
        
        CGFloat redius = _redius;
        NSInteger width = _width;
        
        if (i==0 || i == 10 || i == 20 || i == 30|| i == 40|| i == 50) {
            redius = redius + [ApplicationStyle control_weight:10];
            width = width + [ApplicationStyle control_weight:20];
        }
        
        
        CGFloat x = self.frame.size.width/2,y = self.frame.size.height/2;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(x ,y)
                                                            radius:redius
                                                        startAngle:startAngle
                                                          endAngle:endAngle
                                                         clockwise:YES];
        
        path.lineWidth = width;
        [path stroke];
    }

    
    
    
    
    
    //标准版本
//    for (int i=0; i<=yyyy; i++) {
//        
//        CGFloat startValue = (sl * i) + sl * i;
//        CGFloat startAngle, endAngle;
//        startAngle =  -(M_PI + M_PI_4) + startValue ;
//        endAngle = startAngle + sl;
//        
//        CGFloat redius = [ApplicationStyle control_weight:198];
//        NSInteger width = 20;
//        
//        if (i==0 || i == 10 || i == 20 || i == 30|| i == 40|| i == 50) {
//            redius = [ApplicationStyle control_weight:198] + [ApplicationStyle control_weight:10];
//            width = 30;
//        }
//        
//        
//        CGFloat x = self.frame.size.width/2,y = self.frame.size.height/2;
//        
//        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(x ,y)
//                                                            radius:redius
//                                                        startAngle:startAngle
//                                                          endAngle:endAngle
//                                                         clockwise:YES];
//        
//        path.lineWidth = width;
//        [path stroke];
//    }
}

#pragma mark 处理滑动收拾
- (void)handleGesture:(NLGestureRecognizer *)gesture{
    if (_temperatureBOOL==NO) {
        //    //    1 . 中点角
        CGFloat midPointAngle = (2 * M_PI + _startAngle - _endAngle) / 2 + _endAngle;
        //    2 . 确保角在一个合适的范围内
        CGFloat boundedAngle = gesture.touchAngle;
        if (boundedAngle > midPointAngle) {
            boundedAngle -= 2*M_PI;
            
        }else if(boundedAngle<(midPointAngle - 2 *M_PI)){
            boundedAngle +=2 *M_PI;
        }
        //    3 . 在适当范围内约束角度
        boundedAngle = MIN(_endAngle, MAX(_startAngle, boundedAngle));     //???
        //    4 . 将角度转为值
        CGFloat angleRange = _endAngle - _startAngle;
        CGFloat valueRange = 1 - 0;
        CGFloat valueForAngle = (boundedAngle - _startAngle)/angleRange * valueRange + 0;
        //要滑动的值 - 起点值  / 角度值  *  差值  + 最小值     =   最终角度值
        
        _index = valueForAngle * 51;
        [self.delegate indexNum:_index];
        
        
        if (gesture.state == UIGestureRecognizerStateEnded) {
            [self.delegate gestureRecognizerStateEnded:_index];
        }
        [self setNeedsDisplay];
    }
}
- (void)setIndexTemp:(NSInteger)indexTemp{
    _index = indexTemp;
    [self setNeedsDisplay];
}

-(void)temperatureNotification{
    NSNotificationCenter *notifi= [NSNotificationCenter defaultCenter];
    [notifi addObserver:self selector:@selector(temperatureNotifi:) name:TemperatureSetNotification object:nil];
}
-(void)temperatureNotifi:(NSNotification *)notifi{
    if ([notifi.object isEqualToString:TemperatureSetAgreeNotification]) {
       _temperatureBOOL = NO;
    }else{
        _temperatureBOOL = YES;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
