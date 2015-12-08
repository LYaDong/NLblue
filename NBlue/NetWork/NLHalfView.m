//
//  NLHalfView.m
//  NBlue
//
//  Created by LYD on 15/12/4.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLHalfView.h"
@interface NLHalfView()
@property(nonatomic,assign)NSInteger num;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)CGFloat redius;
@property(nonatomic,assign)NSInteger width;
@property(nonatomic,strong)UIColor *starColor;
@property(nonatomic,strong)UIColor *endColor;


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
        _num = num;
        _index = index;
        _redius = redius;
        _width = width;
        _starColor = starColor;
        _endColor = endColor;
        

    }
    return self;
}


-(void)drawRect:(CGRect)rect{
    
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
    
    for (int i=0; i<=_index; i++) {
        
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
    
    self.progressCount = 10;
}



-(void)setProgro:(NSUInteger)progressCount{
    self.progressCount = progressCount;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
