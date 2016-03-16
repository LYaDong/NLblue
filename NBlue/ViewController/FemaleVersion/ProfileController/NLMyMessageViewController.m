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
#import "NLSQLData.h"
@interface NLMyMessageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation NLMyMessageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray = [NSMutableArray array];

    self.view.backgroundColor = [ApplicationStyle subjectBackViewColor];
    self.titles.text = NSLocalizedString(@"NLProfileView_MyMessage", nil);
    [self bulidUI];
    [self sqlData];
    [self loadDataMessage];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self delNotification];
    [self addNotification];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self delNotification];
}
#pragma mark 基础UI
-(void)bulidUI{
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle navBarAndStatusBarSize], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle navBarAndStatusBarSize]) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_mainTableView];
    _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataMessage];
    }];
    //暂时注释掉
//    _mainTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
//        [self footerDataMessage];
//    }];
}
-(void)sqlData{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_dataArray removeAllObjects];
        NSMutableArray *array = [NSMutableArray array];
        array = [NLSQLData getMyMessageData];
        NSLog(@"%@",array);
        
        [_dataArray addObjectsFromArray:array];
       dispatch_async(dispatch_get_main_queue(), ^{
           [_mainTableView reloadData];
       });
    });
}
#pragma mark 系统Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
//    return 4;
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

    NSString *headImage = [[_dataArray[indexPath.row] objectForKey:@"from"] objectForKey:@"header"]==[NSNull null]||[[_dataArray[indexPath.row] objectForKey:@"from"] objectForKey:@"header"]==nil?@"":[[_dataArray[indexPath.row] objectForKey:@"from"] objectForKey:@"header"];
    NSString *name = [[_dataArray[indexPath.row] objectForKey:@"from"] objectForKey:@"name"]==[NSNull null]||[[_dataArray[indexPath.row] objectForKey:@"from"] objectForKey:@"name"]==nil?@"":[[_dataArray[indexPath.row] objectForKey:@"from"] objectForKey:@"name"];
    NSString *count = [[_dataArray[indexPath.row] objectForKey:@"message"] objectForKey:@"message"]==[NSNull null]||[[_dataArray[indexPath.row] objectForKey:@"message"] objectForKey:@"message"]==nil?@"":[[_dataArray[indexPath.row] objectForKey:@"message"] objectForKey:@"message"];
    
    NSString *times = [ApplicationStyle datePickerTransformationVacancyTime:[[[_dataArray[indexPath.row] objectForKey:@"message"] objectForKey:@"created"] integerValue]];
    
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:headImage] placeholderImage:[UIImage imageNamed:@"User_Head"]];
    cell.headTitle.text = name;
    cell.timeLab.text = [times substringWithRange:NSMakeRange(5, times.length - 5)];
    cell.countLab.text = count;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *name = [[_dataArray[indexPath.row] objectForKey:@"from"] objectForKey:@"name"]==[NSNull null]||[[_dataArray[indexPath.row] objectForKey:@"from"] objectForKey:@"name"]==nil?@"":[[_dataArray[indexPath.row] objectForKey:@"from"] objectForKey:@"name"];
    
    NSString *count = [[_dataArray[indexPath.row] objectForKey:@"message"] objectForKey:@"message"]==[NSNull null]||[[_dataArray[indexPath.row] objectForKey:@"message"] objectForKey:@"message"]==nil?@"":[[_dataArray[indexPath.row] objectForKey:@"message"] objectForKey:@"message"];
    NSString *times = [ApplicationStyle datePickerTransformationVacancyTime:[[[_dataArray[indexPath.row] objectForKey:@"message"] objectForKey:@"created"] integerValue]];
    
    NLMessageDetailsViewController *vc = [[NLMessageDetailsViewController alloc] init];
    vc.titleLab = name;
    vc.timeLab = times;
    vc.countLab = count;
    vc.promptLab = @"暖蓝小提示:\n经期不宜过量运动，过量运动会造成经血增加、痛经加重等情况";
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
#pragma mark 自己的Delegate
#pragma mark 自己的按钮事件
-(void)addNotification{
    NSNotificationCenter *notifi = [NSNotificationCenter defaultCenter];
    [notifi addObserver:self selector:@selector(myMessageSuccess:) name:NLGetMyMessageSuccessNotification object:nil];
    [notifi addObserver:self selector:@selector(myMessageFicaled) name:NLGetMyMessageFicaledNotification object:nil];
}
-(void)myMessageSuccess:(NSNotification *)notifi{
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:notifi.object];
    [NLSQLData myMessage:_dataArray];
    [_mainTableView reloadData];
    [_mainTableView.mj_header endRefreshing];
    
    
}
-(void)myMessageFicaled{
    
}





#pragma mark 网络请求
-(void)loadDataMessage{
    [[NLDatahub sharedInstance] getMyMessages];
}
//-(void)footerDataMessage{
//    
//}

-(void)delNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

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
