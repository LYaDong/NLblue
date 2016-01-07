//
//  NLRingLine.m
//  NBlue
//
//  Created by LYD on 15/12/1.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLRingLine.h"

@interface NLRingLine()
@property(nonatomic,strong)UIColor *colors;
@property(nonatomic,strong)NLRing *ring;
@end
@implementation NLRingLine


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(instancetype)initWithRing:(NLRing *)ring frame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _ring = ring;
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    
    UIColor *color = _ring.backColors;
    [color set];

    NSInteger slicesCount = _ring.lineIndex;
    CGFloat sliceAngle = (2 * M_PI_2 ) / slicesCount;
    for (int i = 0; i < slicesCount; i++) {
        CGFloat startValue = (sliceAngle * i)+sliceAngle * i ;
        CGFloat startAngle, endAngle;
        startAngle =  - M_PI_2 + startValue;
        endAngle = startAngle + sliceAngle;
        UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2,self.frame.size.height/2)
                                                             radius:_ring.radius
                                                         startAngle:startAngle
                                                           endAngle:endAngle
                                                          clockwise:YES];
        
        path1.lineWidth = _ring.lineWidth;
        [path1 stroke];
        
        
    }
    
    
    UIColor *color1 = _ring.coverColor;
    [color1 set];
    
    
    for (int i = 0; i < _ring.progressCounter; i++) {
        CGFloat startValue = (sliceAngle * i)+sliceAngle * i ;
        CGFloat startAngle, endAngle;
        startAngle =  - M_PI_2 + startValue;
        endAngle = startAngle + sliceAngle;
        UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2,self.frame.size.height/2)
                                                             radius:_ring.radius
                                                         startAngle:startAngle
                                                           endAngle:endAngle
                                                          clockwise:YES];
        path1.lineWidth = _ring.lineWidth;
        [path1 stroke];
        
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
