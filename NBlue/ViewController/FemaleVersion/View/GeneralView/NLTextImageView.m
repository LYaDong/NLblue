//
//  NLTextImageView.m
//  NBlue
//
//  Created by LYD on 16/1/20.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLTextImageView.h"

@implementation NLTextImageView

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color image:(UIImage *)image font:(UIFont *)font textColor:(UIColor *)textColor text:(NSString *)text type:(NSInteger)type{
    if (self = [super initWithFrame:frame]) {
        [self buildUIColor:color image:image font:font textColor:textColor text:text type:type];
    }
    return self;
}

- (void)buildUIColor:(UIColor *)color image:(UIImage *)image font:(UIFont *)font textColor:(UIColor *)textColor  text:(NSString *)text type:(NSInteger)type{

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [ApplicationStyle control_weight:30], [ApplicationStyle control_height:20])];
    imageView.image = image;
    imageView.backgroundColor = color;
    [self addSubview:imageView];
    
    CGSize textSize = [ApplicationStyle textSize:text font:font size:SCREENWIDTH];
    
    UILabel *textLab = [[UILabel alloc] initWithFrame:CGRectMake(imageView.rightSideOffset + [ApplicationStyle control_weight:17], 0, textSize.width, [ApplicationStyle control_height:20])];
    textLab.text = text;
    textLab.font = font;
    textLab.textColor = textColor;
    textLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:textLab];
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
