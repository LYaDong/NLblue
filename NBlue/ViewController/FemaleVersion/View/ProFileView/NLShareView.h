//
//  NLShareView.h
//  NBlue
//
//  Created by LYD on 16/3/7.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NLShareViewDelegate <NSObject>
-(void)shareBtnDownIndex:(NSInteger)index;
-(void)cancleBtn;
@end



@interface NLShareView : UIView
@property(nonatomic,strong)id<NLShareViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray textArray:(NSArray *)textArray;
@end
