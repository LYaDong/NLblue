//
//  NLColumnImage.m
//  NBlue
//
//  Created by LYD on 15/12/1.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLColumnImage.h"
@interface NLColumnImage()
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)UIColor *strokeColor;
@property(nonatomic,strong)UIColor *withColor;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)NSArray *labTimeArr;
@end
@implementation NLColumnImage
- (instancetype)initWithDataArr:(NSArray *)arr
                    strokeColor:(UIColor *)strokeColor
                      withColor:(UIColor *)withColor
                           type:(NSInteger)type
                     timeLabArr:(NSArray *)labTimeArr{
    if (self = [super init]) {
        _arr = arr;
        _strokeColor = strokeColor;
        _withColor = withColor;
        _type = type;
        _labTimeArr = labTimeArr;
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    
    
    
    
    
    
    //    CGContextSetStrokeColorWithColor(context, _strokeColor.CGColor);
    //    CGContextSetFillColorWithColor(context, _strokeColor.CGColor);
    //    CGContextMoveToPoint(context, [ApplicationStyle control_weight:40], [ApplicationStyle control_height:480]);
    //    for (NSInteger i=0; i<_arr.count; i++) {
    //        NSInteger num = [[NSString stringWithFormat:@"%@",_arr[i]] integerValue];
    //        CGContextAddRect(context, CGRectMake([ApplicationStyle control_weight:38]+ i * (SCREENWIDTH - [ApplicationStyle control_weight:80])/_arr.count, [ApplicationStyle control_height:480] - num + [ApplicationStyle control_height:5],  (SCREENWIDTH - [ApplicationStyle control_weight:80])/_arr.count - [ApplicationStyle control_weight:10], num - [ApplicationStyle control_height:5]));
    //    }
    
    
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextSetStrokeColorWithColor(context, _withColor.CGColor);
    CGContextSetFillColorWithColor(context, _withColor.CGColor);
    
    
    //    CGContextMoveToPoint(context, self.frame.size.width, [ApplicationStyle control_height:480]);
    //    CGContextAddRect(context,
    //                     CGRectMake(self.frame.size.width - [ApplicationStyle control_weight:90], 0, [ApplicationStyle control_weight:90], 100))
    //    ;
    
    
    NSInteger ToPointW = 0;
    CGFloat weidh = 0.0f;
    
    switch (_type) {
        case NLCalendarType_Ordinary:
        {
            ToPointW = [ApplicationStyle control_weight:40];
            
                        CGContextMoveToPoint(context, ToPointW, [ApplicationStyle control_height:480]);
                        for (NSInteger i=0; i<_arr.count; i++) {
                            NSInteger num = [[NSString stringWithFormat:@"%@",_arr[i]] integerValue];
                            CGContextAddRect(context,
                                             CGRectMake([ApplicationStyle control_weight:40]+ i * (SCREENWIDTH - [ApplicationStyle control_weight:80])/_arr.count,
                                                        [ApplicationStyle control_height:480] - num ,
                                                        (SCREENWIDTH - [ApplicationStyle control_weight:80])/_arr.count - [ApplicationStyle control_weight:10],
                                                        num));
                        }
            
            
            
//            [self labTimeToPointW:<#(CGFloat)#> weight:<#(CGFloat)#> height:<#(CGFloat)#> arr:<#(NSArray *)#> context:<#(CGContextRef)#>]
            break;
        }
        case NLCalendarType_Day:
        {
            ToPointW = self.frame.size.width;
            weidh = [ApplicationStyle control_weight:50];
            [self labTimeToPointW:ToPointW weight:weidh height:[ApplicationStyle control_height:480] arr:_arr context:context];
            
            break;
        }
        case NLCalendarType_Week:
        {
            ToPointW = self.frame.size.width;
            weidh = [ApplicationStyle control_weight:90];
            [self labTimeToPointW:ToPointW weight:weidh height:[ApplicationStyle control_height:480] arr:_arr context:context];
            break;
        }
        case NLCalendarType_Month:
        {
            ToPointW = self.frame.size.width;
            weidh = [ApplicationStyle control_weight:120];
            [self labTimeToPointW:ToPointW weight:weidh height:[ApplicationStyle control_height:480] arr:_arr context:context];
            break;
        }
        default:
            break;
    }
    
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
}
#pragma mark 从右到左
-(void)labTimeToPointW:(CGFloat)toPointW weight:(CGFloat)weight height:(CGFloat)height arr:(NSArray *)arr context:(CGContextRef)context{
    
    
    

    
    
    for (NSInteger i=0; i<arr.count; i++) {
        
        NSInteger num = [[NSString stringWithFormat:@"%@",_arr[i]] integerValue];
        CGContextAddRect(context,
                         CGRectMake(toPointW -  weight - i * (weight + [ApplicationStyle control_weight:10]),
                                    height - num ,
                                    weight,
                                    num));
        
        UILabel *labTime = [[UILabel alloc] initWithFrame:CGRectMake(toPointW - weight - i * (weight + [ApplicationStyle control_weight:10]), height + ([ApplicationStyle control_height:60] - [ApplicationStyle control_height:30])/2, weight, [ApplicationStyle control_height:30])];
        labTime.text = @"11/11";
        if (i == 0) {
            labTime.text = @"今天";
        }
        if (i == 1) {
            labTime.text = @"昨天";
        }

        labTime.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:18]];
        labTime.textColor = [ApplicationStyle subjectWithColor];
        labTime.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labTime];
        
    }
}
#pragma mark 左到右


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
