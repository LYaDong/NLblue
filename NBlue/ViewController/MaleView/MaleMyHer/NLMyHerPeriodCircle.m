//
//  NLMyHerPeriodCircle.m
//  NBlue
//
//  Created by LYD on 16/1/18.
//  Copyright © 2016年 LYD. All rights reserved.
//
#define DEGREES_2_RADIANS(x) (0.0174532925 * (x))
#import "NLMyHerPeriodCircle.h"

@implementation NLMyHerPeriodCircle
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    NSInteger counts = 30.0f;//周期
    NSInteger surplus = counts-5;//剩余时间
    
    CGPoint centerPoint = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    CGFloat radius = MIN(rect.size.width, rect.size.height) / 2;
    CGFloat pathWidth = radius * 0.2f;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(contextRef, 3.0f);
    
    
    
    CGFloat sliceangle = (2 * M_PI)/counts;
    //        一个圈
    {
        for (int i=0; i<counts; i++) {
            CGFloat startValue = sliceangle * i;
            CGFloat starAngle ,endAngle;
            starAngle = -(M_PI-M_PI_2)-startValue;
            endAngle = starAngle - sliceangle-0.01 ;
            CGContextBeginPath(contextRef);
            CGContextMoveToPoint(contextRef, centerPoint.x, centerPoint.y);
            CGContextAddArc(contextRef, centerPoint.x, centerPoint.y, centerPoint.x, starAngle, endAngle, 1);
            CGContextSetFillColorWithColor(contextRef, [self pastTimeColor].CGColor);
            CGContextFillPath(contextRef);
            
        }
    }
    
    for (NSInteger i=0; i<3; i++) {
        
        CGFloat intevalue = 0.0f;
        CGFloat stars = 0.0f;
        
        if (surplus==0) {
            CGContextSetFillColorWithColor(contextRef, [self forecastPeriodColor].CGColor);
        }else{
            switch (i) {
                case 0:{
                    //安全期
                    intevalue = surplus;
                    CGContextSetFillColorWithColor(contextRef, [self safetyPeriodColor].CGColor);
                    break;
                }
                case 1:{
                    //预测期
                    if (surplus<=5) {
                        intevalue = surplus;
                    }else{
                        intevalue = 5.0f;
                    }
                    CGContextSetFillColorWithColor(contextRef, [self forecastPeriodColor].CGColor);
                    break;
                }
                case 2:{
                    //易孕期
                    if (surplus>19) {
                        stars = 9.0f;
                        intevalue = stars + 10.0f;
                    }else if (surplus>9&&surplus<=19){
                        stars = 9.0f;
                        intevalue = surplus;
                    }else{
                        stars = 0;
                        intevalue = 0;
                    }
                    CGContextSetFillColorWithColor(contextRef, [self easyPregnancyPeriodColor].CGColor);
                    break;
                }
                default:
                    break;
            }
        }
        
        
        
        for (NSInteger j=stars; j<intevalue; j++) {
            
            CGFloat startValue = sliceangle * j;
            CGFloat starAngle ,endAngle;
            starAngle = -(M_PI-M_PI_2)-startValue;
            endAngle = starAngle - sliceangle - 0.01 ;
            CGContextBeginPath(contextRef);
            CGContextMoveToPoint(contextRef, centerPoint.x, centerPoint.y);
            CGContextAddArc(contextRef, centerPoint.x, centerPoint.y, centerPoint.x, starAngle, endAngle, 1);
            
            
            CGContextFillPath(contextRef);
        }
        
        
        
        float stindexs = stars/counts;
        
        float indexs = intevalue/counts;
        
        //开始圆
        CGFloat radiansStar = DEGREES_2_RADIANS((-(stindexs)*360)-90);
        CGFloat xOffsetStar = radius*(1 + 0.9*cosf(radiansStar));
        CGFloat yOffsetStar = radius*(1 + 0.9*sinf(radiansStar));
        CGPoint starPoint = CGPointMake(xOffsetStar, yOffsetStar);
        
        //结束园
        CGFloat radiansEnd = DEGREES_2_RADIANS((-(indexs)*360)-90);
        CGFloat xOffsetEnd = radius*(1 + 0.9*cosf(radiansEnd));
        CGFloat yOffsetEnd = radius*(1 + 0.9*sinf(radiansEnd));
        CGPoint endPoint = CGPointMake(xOffsetEnd, yOffsetEnd);
        
        if (i==2) {
            if (surplus>19) {
                stars = 9.0f;
                intevalue = stars + 10.0f;
                CGContextSetFillColorWithColor(contextRef, [self easyPregnancyPeriodColor].CGColor);
            }else if (surplus>9&&surplus<=19){
                stars = 9.0f;
                intevalue = surplus;
                CGContextSetFillColorWithColor(contextRef, [self easyPregnancyPeriodColor].CGColor);
            }else{
                stars = 0;
                intevalue = 0;
                CGContextSetFillColorWithColor(contextRef, [self forecastPeriodColor].CGColor);
            }
            
        }
        
        CGContextAddEllipseInRect(contextRef, CGRectMake(endPoint.x - pathWidth/2, endPoint.y - pathWidth/2, pathWidth, pathWidth));
        CGContextFillPath(contextRef);
        
        
        
        if (i==2) {
            
            if (surplus>19) {
                stars = 9.0f;
                intevalue = stars + 10.0f;
                CGContextSetFillColorWithColor(contextRef, [self safetyPeriodColor].CGColor);
            }else if (surplus>9&&surplus<=19){
                stars = 9.0f;
                intevalue = surplus;
                CGContextSetFillColorWithColor(contextRef, [self safetyPeriodColor].CGColor);
            }else{
                stars = 0;
                intevalue = 0;
                CGContextSetFillColorWithColor(contextRef, [self forecastPeriodColor].CGColor);
            }
            
            
        }
        
        CGContextAddEllipseInRect(contextRef, CGRectMake(starPoint.x- pathWidth/2, starPoint.y - pathWidth/2, pathWidth, pathWidth));
        CGContextFillPath(contextRef);
    }
    

    //    遮罩图层
    {
        CGContextSetBlendMode(contextRef, kCGBlendModeClear);;
        CGFloat innerRadius = radius * 0.8;
        CGPoint newCenterPoint = CGPointMake(centerPoint.x - innerRadius, centerPoint.y - innerRadius);
        CGContextAddEllipseInRect(contextRef, CGRectMake(newCenterPoint.x, newCenterPoint.y, innerRadius*2, innerRadius*2));
        CGContextFillPath(contextRef);
    }
}

-(UIColor *)forecastPeriodColor{return [@"d14f4f" hexStringToColor];}//预测期
-(UIColor *)safetyPeriodColor{return [@"b8c752" hexStringToColor];}//安全期
-(UIColor *)easyPregnancyPeriodColor{return [@"fb961f" hexStringToColor];}//易孕期
-(UIColor *)pastTimeColor{return [@"e5e4d3" hexStringToColor];}//过去时

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
