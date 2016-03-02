//
//  NLMyMessageViewController.m
//  NBlue
//
//  Created by LYD on 16/2/23.
//  Copyright © 2016年 LYD. All rights reserved.
//

#import "NLMyMessageViewController.h"
#import "NLMyMessageCell.h"
#import "NLMessageDetailsViewController.h"
#import <UIImageView+WebCache.h>
@interface NLMyMessageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation NLMyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    {
        self.navBarBack.hidden = YES;
        self.navBarPushBack.hidden = NO;
        self.controllerBack.hidden = YES;
    }
    self.view.backgroundColor = [ApplicationStyle subjectBackViewColor];
    self.titles.text = NSLocalizedString(@"NLProfileView_MyMessage", nil);
    [self bulidUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark 基础UI
-(void)bulidUI{
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle navBarAndStatusBarSize], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle navBarAndStatusBarSize]) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_mainTableView];
}
#pragma mark 系统Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return _dataArray.count;
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ApplicationStyle control_height:201];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"LYD";
    NLMyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[NLMyMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"User_Head"]];
    cell.headTitle.text = @"暖蓝小助手";
    cell.timeLab.text = [NSString stringWithFormat:@"%@  %@",@"12/16",@"12:25"];
    cell.countLab.text = @"你女朋友今天在经期，但是已经走了7K步啦，快去阻止她糟蹋自己的身体!";
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NLMessageDetailsViewController *vc = [[NLMessageDetailsViewController alloc] init];
    vc.titleLab = @"暖蓝小助手";
    vc.timeLab = @"2016/1/19   9:30";
    vc.countLab = @"你女朋友今天在经期，但是已经走了7K步啦，快去阻止她糟蹋自己的身体!";
    vc.promptLab = @"暖蓝小提示:\n经期不宜过量运动，过量运动会造成经血增加、痛经加重等情况";
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
#pragma mark 自己的Delegate
#pragma mark 自己的按钮事件

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
