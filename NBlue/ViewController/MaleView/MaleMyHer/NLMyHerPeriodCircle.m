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
@synthesize trackTintColor = _trackTintColor;
@synthesize progressTintColor =_progressTintColor;
- (id)init
{
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    
    CGPoint centerPoint = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    CGFloat radius = MIN(rect.size.width, rect.size.height) / 2;
    
    CGFloat pathWidth = radius * 0.3f;
    
    CGFloat radians = DEGREES_2_RADIANS((0.1*360)-90);
    CGFloat xOffset = radius*(1 + 0.85*cosf(radians));
    CGFloat yOffset = radius*(1 + 0.85*sinf(radians));
    CGPoint endPoint = CGPointMake(xOffset, yOffset);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    

    
    
    
    {
        CGContextAddEllipseInRect(context, CGRectMake(centerPoint.x - pathWidth/2, 0, pathWidth, pathWidth));
        CGContextFillPath(context);
        
        CGContextAddEllipseInRect(context, CGRectMake(endPoint.x - pathWidth/2, endPoint.y - pathWidth/2, pathWidth, pathWidth));
        CGContextFillPath(context);
        
        CGContextSetBlendMode(context, kCGBlendModeClear);;
        CGFloat innerRadius = radius * 0.7;
        CGPoint newCenterPoint = CGPointMake(centerPoint.x - innerRadius, centerPoint.y - innerRadius);
        CGContextAddEllipseInRect(context, CGRectMake(newCenterPoint.x, newCenterPoint.y, innerRadius*2, innerRadius*2));
        CGContextFillPath(context);
    }


    
    
}

- (UIColor *)trackTintColor
{
    if (!_trackTintColor)
    {
        _trackTintColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1];
    }
    return _trackTintColor;
}

- (UIColor *)progressTintColor
{
    if (!_progressTintColor)
    {
        _progressTintColor = [UIColor whiteColor];
    }
    return _progressTintColor;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
