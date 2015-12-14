//
//  NLHealthCalenderView.m
//  NBlue
//
//  Created by LYD on 15/11/24.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLHealthCalenderView.h"
#import "NLCalenderPackage.h"
#import "NLHealtCalenderCell.h"
@interface NLHealthCalenderView()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIScrollView *mainScrollew;
@property(nonatomic,strong)UITableView *mainTableView;
@end
@implementation NLHealthCalenderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor yellowColor];
        [self bulidUI];
    }
    return self;
}

#pragma mark 基础UI
-(void)bulidUI{
    _mainScrollew = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, self.frame.size.height)];
    _mainScrollew.delegate = self;
    _mainScrollew.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT + 200);
    [self addSubview:_mainScrollew];
    
    NLCalenderPackage *calenderView = [[NLCalenderPackage alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ApplicationStyle control_height:520])];
    [_mainScrollew addSubview:calenderView];
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, calenderView.bottomOffset + [ApplicationStyle control_height:100], SCREENWIDTH, [ApplicationStyle control_height:4 * 88]) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [_mainScrollew addSubview:_mainTableView];
}
#pragma mark 系统Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ApplicationStyle control_height:88];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"LYD";
    NLHealtCalenderCell *cell = [tableView   dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[NLHealtCalenderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    
    return cell;
}

#pragma mark 自己的Delegate
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
