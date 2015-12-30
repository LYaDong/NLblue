//
//  LYDSegmentControl.m
//  分段选择Btn
//
//  Created by 刘亚栋 on 15/11/24.
//  Copyright © 2015年 LiuYaDong. All rights reserved.
//

#import "LYDSegmentControl.h"
#import "LYDSetSegmentControl.h"
static const NSInteger BTNTAG = 10000;
@interface LYDSegmentControl()

@property(nonatomic,strong)UIButton *seleBtn;
@property(nonatomic,weak)UIButton *currentItem;
@property(nonatomic,strong)LYDSetSegmentControl *setSegment;
@end

@implementation LYDSegmentControl


- (instancetype)initWithSetSegment:(LYDSetSegmentControl *)setSegment frame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _setSegment = setSegment;
        [self layerFrame];
        [self segmentCount];
    }
    return self;
}

- (void)layerFrame{
    self.layer.cornerRadius = _setSegment.cornerRedius;
    self.layer.borderColor = _setSegment.borderColors.CGColor;
    self.layer.borderWidth = _setSegment.borderWidth;
    self.clipsToBounds = _setSegment.clipsBounds;
}
-(void)segmentCount{

    for (NSInteger i=0; i<_setSegment.titleArray.count; i++) {
        UIButton *item = [self segmentedBtn:i];
        [item setTitle:_setSegment.titleArray[i] forState:UIControlStateNormal];
        [self addSubview:item];
        if (i==_setSegment.selectedSegmentIndex) {
            [self setCurrentItem:item];
        }
    }
    for (NSInteger i=0; i<_setSegment.titleArray.count - 1; i++) {
        CGFloat height = _seleBtn.viewHeight - (_seleBtn.viewHeight/2/2/1.1);
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(_seleBtn.rightSideOffset, (_seleBtn.viewHeight - height)/2, 1, height)];
        view.backgroundColor = _setSegment.lineColor;
        view.hidden = _setSegment.lineHide;
        [self addSubview:view];
    }
    
}
-(void)setCurrentItem:(UIButton *)currentItem{
    [_seleBtn setSelected:NO];
    _seleBtn.backgroundColor = [UIColor clearColor];
    currentItem.backgroundColor = _setSegment.backGroupColor;
    _seleBtn = currentItem;
}

-(UIButton *)segmentedBtn:(NSInteger )index{
    CGFloat widths = CGRectGetWidth(self.bounds)/_setSegment.titleArray.count;
    CGFloat height = CGRectGetHeight(self.bounds);
    UIButton *segmentBtns = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    segmentBtns.frame = CGRectMake(0 + index * widths, 0, widths, height);
    [segmentBtns setTitleColor:_setSegment.titleColor forState:UIControlStateNormal];
    segmentBtns.titleLabel.font = _setSegment.titleFont;
    [segmentBtns addTarget:self action:@selector(segmentBtnsDown:) forControlEvents:UIControlEventTouchUpInside];
    segmentBtns.tag = BTNTAG + index;
    return segmentBtns;
}
-(void)segmentBtnsDown:(UIButton *)btn{
    self.currentItem = btn;
    [self.delegate segmentedIndex:btn.tag - BTNTAG];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
