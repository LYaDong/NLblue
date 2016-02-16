//
//  NLStepColumnImage.m
//  NBlue
//
//  Created by LYD on 15/12/10.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLStepColumnImage.h"
@interface NLStepColumnImage()
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)UIColor *strokeColor;
@property(nonatomic,strong)UIColor *withColor;
@end
@implementation NLStepColumnImage
- (instancetype)initWithFrame:(CGRect)frame DataArr:(NSArray *)arr
                  strokeColor:(UIColor *)strokeColor
                    withColor:(UIColor *)withColor{
    if (self = [super initWithFrame:frame]) {
        _dataArr = arr;
        _strokeColor = strokeColor;
        _withColor = withColor;
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
                               
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextSetStrokeColorWithColor(context, _withColor.CGColor);
    CGContextSetFillColorWithColor(context, _withColor.CGColor);
    NSInteger ToPointW = 0;
    
    ToPointW = [ApplicationStyle control_weight:40];
    
    CGContextMoveToPoint(context, ToPointW, [ApplicationStyle control_height:480]);
    
    
    
    
    for (NSInteger i=0; i<_dataArr.count; i++) {
        NSInteger num = [[NSString stringWithFormat:@"%@",_dataArr[i]] integerValue];

        CGContextAddRect(context,
                         CGRectMake([ApplicationStyle control_weight:40]+ i * (SCREENWIDTH - [ApplicationStyle control_weight:80])/_dataArr.count,
                                    [ApplicationStyle control_height:480] - num ,
                                    (SCREENWIDTH - [ApplicationStyle control_weight:80])/_dataArr.count - [ApplicationStyle control_weight:10],
                                    num));
    }
    
    CGContextDrawPath(context, kCGPathFillStroke);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
