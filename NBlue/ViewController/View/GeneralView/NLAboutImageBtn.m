//
//  AboutImageBtn.m
//  NBlue
//
//  Created by LYD on 15/11/24.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLAboutImageBtn.h"

@implementation NLAboutImageBtn
-(instancetype)initWithFrame:(CGRect)frame type:(int64_t)type font:(UIFont *)font color:(UIColor *)color image:(UIImage *)image text:(NSString *)text{
    if (self = [super initWithFrame:frame]) {
        
        
        
        if (type == About_Left_Image) {
            CGSize labSize = [ApplicationStyle textSize:text font:font size:[ApplicationStyle screenWidth]];
            
            
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - (image.size.width + labSize.width) + [ApplicationStyle control_weight:10])/2, (frame.size.height - image.size.height)/2, image.size.width, image.size.height)];
            imageV.image = image;
            [self addSubview:imageV];
            
            UILabel *textLab = [[UILabel alloc] initWithFrame:CGRectMake(imageV.rightSideOffset + [ApplicationStyle control_weight:10] , (frame.size.height - labSize.height)/2, labSize.width, labSize.height)];
            textLab.text = text;
            textLab.font = font;
            textLab.textColor = color;
            [self addSubview:textLab];
            
            
        }else{
            CGSize labSize = [ApplicationStyle textSize:text font:font size:[ApplicationStyle screenWidth]];
            
            UILabel *textLab = [[UILabel alloc] initWithFrame:CGRectMake((frame.size.width - labSize.width - image.size.width)/2 , (frame.size.height - labSize.height)/2, labSize.width, labSize.height)];
            textLab.text = text;
            textLab.font = font;
            textLab.textColor = color;
            [self addSubview:textLab];
            
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(textLab.rightSideOffset + [ApplicationStyle control_weight:10], (frame.size.height - image.size.height)/2, image.size.width, image.size.height)];
            imageV.image = image;
            [self addSubview:imageV];
        }
        
        
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
