//
//  LHRatingView.h
//  TestStoryboard
//
//  Created by bosheng on 15/11/4.
//  Copyright © 2015年 bosheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NLLHRatingView;

@protocol NLLHRatingViewDelegate <NSObject>

@optional
- (void)ratingView:(NLLHRatingView *)view score:(CGFloat)score;
//- (void)returnScore:(CGFloat)score;
@end


typedef NS_ENUM(NSUInteger, RatingType) {
    INTEGER_TYPE,
    FLOAT_TYPE
};;

@interface NLLHRatingView : UIView

@property (nonatomic,assign)RatingType ratingType;//评分类型，整颗星或半颗星
@property (nonatomic,assign)CGFloat score;//当前分数

@property (nonatomic,assign)id<NLLHRatingViewDelegate> delegate;

@end
