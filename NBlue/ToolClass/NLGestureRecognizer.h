//
//  RWRotationGestureRecognizer.h
//  转圈滑动
//
//  Created by LYD on 15/12/12.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLGestureRecognizer : UIPanGestureRecognizer

@property(nonatomic,assign)CGFloat touchAngle;
@end
