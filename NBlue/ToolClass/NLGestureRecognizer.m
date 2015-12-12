//
//  RWRotationGestureRecognizer.m
//  转圈滑动
//
//  Created by LYD on 15/12/12.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
@implementation NLGestureRecognizer

- (instancetype)initWithTarget:(id)target action:(SEL)action{
    if (self = [super initWithTarget:target action:action]) {
        self.maximumNumberOfTouches = 1;
        self.minimumNumberOfTouches = 1;
    }
    return self;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self updateTouchAnngleWithTouches:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    [self updateTouchAnngleWithTouches:touches];
}

-(void)updateTouchAnngleWithTouches:(NSSet *)touches{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    self.touchAngle = [self calculateAngleToPoint:touchPoint];
}
- (CGFloat)calculateAngleToPoint:(CGPoint)point{
    CGPoint centerOffset = CGPointMake(point.x - CGRectGetMidX(self.view.bounds),
                                       point.y - CGRectGetMidY(self.view.bounds));
    return atan2(centerOffset.y, centerOffset.x);
}
@end
