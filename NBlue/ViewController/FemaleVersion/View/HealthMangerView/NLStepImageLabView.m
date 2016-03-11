//
//  NLStepImageLab.m
//  NBlue
//
//  Created by LYD on 15/12/1.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLStepImageLabView.h"

@implementation NLStepImageLabView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)images
                     textFont:(UIFont *)textFont
                    textColor:(UIColor *)textColor
                   textRemark:(NSString *)textRemark
                      textNum:(NSString *)textNum
                        frame:(CGRect)frame{
    if (self = [super init]) {
        
        
        

        CGSize textNumSize = [ApplicationStyle textSize:textNum font:textFont size:SCREENWIDTH];
        CGSize textRemarkSize = [ApplicationStyle textSize:textRemark font:textFont size:SCREENWIDTH];
        
        
        
        UILabel *labNum = [[UILabel alloc] initWithFrame:CGRectMake(0,(frame.size.height - (textNumSize.height + textRemarkSize.height + images.size.height))/2, frame.size.width, textNumSize.height)];
        labNum.text = textNum;
        labNum.font = textFont;
        labNum.textColor = textColor;
        labNum.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labNum];
        
        
        
        
        UILabel *labRemark = [[UILabel alloc] initWithFrame:CGRectMake(0, labNum.bottomOffset + [ApplicationStyle control_height:24], frame.size.width, textRemarkSize.height)];
        labRemark.textAlignment = NSTextAlignmentCenter;
        labRemark.font = [ApplicationStyle textSuperSmallFont];
        labRemark.text = textRemark;
        labRemark.textColor = textColor;
        [self addSubview:labRemark];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - images.size.width)/2, labRemark.bottomOffset + [ApplicationStyle control_height:44], images.size.width, images.size.height)];
        image.image = images;
        image.contentMode = UIViewContentModeCenter;
        [self addSubview:image];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
