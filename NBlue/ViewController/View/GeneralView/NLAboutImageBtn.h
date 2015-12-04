//
//  AboutImageBtn.h
//  NBlue
//
//  Created by LYD on 15/11/24.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int64_t , About) {
    About_Left_Image = 0,//图片在左边
    About_Right_Image = 1,//图片在右边
};

@interface NLAboutImageBtn : UIButton
-(instancetype)initWithFrame:(CGRect)frame type:(int64_t)type font:(UIFont *)font color:(UIColor *)color image:(UIImage *)image text:(NSString *)text;
@end
