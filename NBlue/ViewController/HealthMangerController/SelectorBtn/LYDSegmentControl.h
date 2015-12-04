//
//  LYDSegmentControl.h
//  分段选择Btn
//
//  Created by 刘亚栋 on 15/11/24.
//  Copyright © 2015年 LiuYaDong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYDSetSegmentControl.h"

@protocol LYDSetSegmentDelegate <NSObject>

-(void)segmentedIndex:(NSInteger)index;

@end

@interface LYDSegmentControl : UIView
@property(nonatomic,assign)id<LYDSetSegmentDelegate>delegate;
- (instancetype)initWithSetSegment:(LYDSetSegmentControl *)setSegment frame:(CGRect)frame;
@end
