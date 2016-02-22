//
//  LHRatingView.m
//  TestStoryboard
//
//  Created by bosheng on 15/11/4.
//  Copyright © 2015年 bosheng. All rights reserved.
//

#import "NLLHRatingView.h"

#define maxScore 5.0f
#define starNumber 5.0f
static NSInteger countNum = 5;

@interface NLLHRatingView()
{
    CGFloat eachWidth;
}

@property (nonatomic,assign)CGFloat widDistance;//星星之间的左右间隔
@property (nonatomic,assign)CGFloat heiDistance;//星星之间的上下间隔

@property (nonatomic,strong)UIView * grayStarView;//灰色星星
@property (nonatomic,strong)UIView * foreStarView;//表示分数星星

@property (nonatomic,assign)CGFloat lowestScore;//最低分数

@end

@implementation NLLHRatingView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _ratingType = FLOAT_TYPE;
        self.widDistance = 5.0f;
        self.heiDistance = 5.0f;
        self.lowestScore = 1.0f;
        
        
        self.grayStarView = [[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:self.grayStarView];
        self.foreStarView = [[UIView alloc]initWithFrame:self.bounds];
        self.foreStarView.clipsToBounds = YES;
        [self addSubview:self.foreStarView];
        
        CGFloat width = self.frame.size.width;
        
        eachWidth = self.frame.size.width/5;
        
        
        NSLog(@"%f",self.frame.size.width/5);
        
        
        CGFloat imgWidth = [ApplicationStyle control_weight:40],imgHeight = [ApplicationStyle control_height:40.0f],interval = [ApplicationStyle control_weight:10.0f];

        for (int i = 0; i < starNumber; i++) {
            UIImage * grayImg = [UIImage imageNamed:@"NLHClen_DYM_TJ_K"];
            UIImageView * grayImgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*(imgWidth+interval),0, imgWidth, imgHeight)];
            grayImgView.image = grayImg;
            [self.grayStarView addSubview:grayImgView];
            
            UIImage * foreImg = [UIImage imageNamed:@"NLHClen_DYM_TJ_X"];
            UIImageView *foreImgView = [[UIImageView alloc] initWithFrame:CGRectMake(width - i*(imgWidth+interval)-imgWidth, 0, imgWidth, imgHeight)];
            foreImgView.image = foreImg;
            [self.foreStarView addSubview:foreImgView];
        }
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureEvent:)];
        UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureEvent:)];
        
        [self addGestureRecognizer:tapGesture];
        [self addGestureRecognizer:panGesture];
        
        self.score = self.lowestScore;
    }
    
    return self;
}

#pragma mark - 设置当前分数
- (void)setScore:(CGFloat)score
{
    _score = score;
    
    if (_ratingType == INTEGER_TYPE) {
        _score = (int)score;
    }

    CGPoint p = CGPointMake((eachWidth+self.widDistance)*_score, self.heiDistance);
    [self changeStarForeViewWithPoint:p];
}

#pragma mark - 设置当前类型
- (void)setRatingType:(RatingType)ratingType
{
    _ratingType = ratingType;
    
    [self setScore:_score];
}

#pragma mark - 点击
- (void)tapGestureEvent:(UITapGestureRecognizer *)tap_
{
    CGPoint point = [tap_ locationInView:self];

    if(_ratingType == INTEGER_TYPE){
        NSInteger count = countNum - ((NSInteger)(point.x/(self.frame.size.width/5)));
        
        
        
        point.x = count*(eachWidth+self.widDistance);
        NSLog(@"%f",point.x/(eachWidth+self.widDistance));
    }
    
    [self changeStarForeViewWithPoint:point];
}


#pragma mark - 滑动
- (void)panGestureEvent:(UIPanGestureRecognizer *)pan_
{
    
    
    NSLog(@"%@",pan_);
    
    CGPoint point = [pan_ locationInView:self];

    if (point.x < 0) {
        return;
    }
    if(_ratingType == INTEGER_TYPE){
        NSInteger count = countNum -((NSInteger)(point.x/(eachWidth+self.widDistance)));
        point.x = count*(eachWidth+self.widDistance);
    }
    
    [self changeStarForeViewWithPoint:point];
}

#pragma mark - 设置显示的星星
- (void)changeStarForeViewWithPoint:(CGPoint)point
{
    CGFloat width = self.frame.size.width;
    
    CGFloat num = point.x/(eachWidth+self.widDistance);
    CGFloat imgHeight = [ApplicationStyle control_height:40.0f],imgWidht = [ApplicationStyle control_weight:50];
    
    
    self.foreStarView.frame = CGRectMake(width+[ApplicationStyle control_weight:10] - (imgWidht*num) , 0, width, imgHeight);
    
    
//    CGPoint p = point;
//    
//    if (p.x < 0) {
//        return;
//    }
//    
//    
//    NSLog(@"px==%f",p.x);
//    
//    
//    
//    if (p.x < self.lowestScore)
//    {
//        p.x = self.lowestScore;
//    }
//    else if (p.x > self.frame.size.width)
//    {
//        p.x = self.frame.size.width;
//    }
//    
//    
//    NSLog(@"%f",p.x/CGRectGetWidth(self.frame));
//    
//    
//    
////    NSString * str = [NSString stringWithFormat:@"%0.2f",p.x / self.frame.size.width];
//    float sc = p.x/CGRectGetWidth(self.frame);
////    p.x = sc * self.frame.size.width;
//    
//    
//    CGRect fRect = self.foreStarView.frame;
//    fRect.size.width =  p.x;
//    self.foreStarView.frame = fRect;
//    
//    _score = sc*maxScore;
//    
//    if(_ratingType == INTEGER_TYPE){
//        NSLog(@"a");
//        _score = (int)_score;
//    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(ratingView:score:)])
    {
        [self.delegate ratingView:self score:self.score];
    }
}


@end
