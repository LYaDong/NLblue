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
#import "NLHealtCalenderPeriod.h"
#import "NLCalenderPicker.h"
@interface NLHealthCalenderView()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIScrollView *mainScrollew;
@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)UILabel *periodTimeDay;
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
    
    
    {//经期时间
        UIImageView *calenderback = [[UIImageView alloc] initWithFrame:CGRectMake(0, calenderView.bottomOffset, SCREENWIDTH, [ApplicationStyle control_height:100])];
        calenderback.image = [UIImage imageNamed:@"NLBackCalender"];
        [_mainScrollew addSubview:calenderback];
        
        NSArray *periodArr = @[NSLocalizedString(@"NLHealthCalender_JQ", nil),
                               NSLocalizedString(@"NLHealthCalender_YCQ", nil),
                               NSLocalizedString(@"NLHealthCalender_AQQ", nil),
                               NSLocalizedString(@"NLHealthCalender_YYQ", nil),];
        NSArray *periodColor = @[[@"ff6c32" hexStringToColor],
                                 [@"ffad54" hexStringToColor],
                                 [@"fee39a" hexStringToColor],
                                 [@"ffe9ed" hexStringToColor],];
        
        NLHealtCalenderPeriod *periodView;
        for (NSInteger i = 0; i<periodArr.count; i++) {
            CGRect frame = CGRectMake([ApplicationStyle control_weight:52] + i * ((SCREENWIDTH - [ApplicationStyle control_weight:52])/4), [ApplicationStyle control_height:10], (SCREENWIDTH - [ApplicationStyle control_weight:52])/4, [ApplicationStyle control_height:20]);
            periodView = [[NLHealtCalenderPeriod alloc] initWithFrame:frame
                                                                                       color:periodColor[i]
                                                                                        text:periodArr[i]];
            [calenderback addSubview:periodView];
        }
        
        _periodTimeDay = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:52],
                                                                  [ApplicationStyle control_height:40] + ((calenderback.viewHeight - [ApplicationStyle control_height:40]) - [ApplicationStyle control_height:35])/2 ,
                                                                   SCREENWIDTH - [ApplicationStyle control_weight:100 * 2],
                                                                   [ApplicationStyle control_height:35])];
        
        _periodTimeDay.textColor = [ApplicationStyle subjectWithColor];
        _periodTimeDay.font = [UIFont    systemFontOfSize:[ApplicationStyle control_weight:28]];
        _periodTimeDay.text = @"距离下次来临大约还有15天";
        [calenderback addSubview:_periodTimeDay];
    }
    
    NLCalenderPicker *vc = [[NLCalenderPicker alloc] initWithFrame:CGRectMake(0, calenderView.bottomOffset + [ApplicationStyle control_height:100] + [ApplicationStyle control_height:2 ], SCREENWIDTH, [ApplicationStyle control_height:500])];
    vc.backgroundColor = [UIColor redColor];
    [_mainScrollew addSubview:vc];
    
    
//    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, calenderView.bottomOffset + [ApplicationStyle control_height:100] + [ApplicationStyle control_height:2 ], SCREENWIDTH, [ApplicationStyle control_height:4 * 88]) style:UITableViewStylePlain];
//    _mainTableView.delegate = self;
//    _mainTableView.dataSource = self;
////    _mainTableView.separatorStyle = UITableViewCellSelectionStyleNone;
//    _mainTableView.backgroundColor = [UIColor clearColor];
//    [_mainScrollew addSubview:_mainTableView];
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
    
    
    NSArray *imageArr = @[@"NLHClen_DYM",
                          @"NLHClen_AA",
                          @"NLHClen_SHXG",
                          @"NLHClen_BSF"];
    
    NSArray *labArr = @[NSLocalizedString(@"NLHealthCalender_DYM", nil),
                        NSLocalizedString(@"NLHealthCalender_AA", nil),
                        NSLocalizedString(@"NLHealthCalender_SHXG", nil),
                        NSLocalizedString(@"NLHealthCalender_BSF", nil),];
    cell.cellImage.image = [UIImage imageNamed:imageArr[indexPath.row]];
    cell.cellLab.text = labArr[indexPath.row];
    cell.cellCountImage.image = [UIImage imageNamed:@"NLHClen_DDD"];
    if (indexPath.row==0) {
        cell.cellCountImage.image = [UIImage imageNamed:@"NLHClen_DYM_NO"];
    }
    
    cell.backgroundColor = [UIColor  clearColor];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
