//
//  ProfileViewController.m
//  NBlue
//
//  Created by LYD on 15/11/23.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLProfileViewController.h"
#import "NLProTableCell.h"
#import "NLIndividuaFormatViewController.h"
#import "NLMyEquipmentController.h"
#import "NLFeedBackViewController.h"
#import "NLAboutNLViewController.h"
@interface NLProfileViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIButton *userHeadImage;
@property(nonatomic,strong)UILabel *userNameLab;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation NLProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBarBack.hidden = YES;
    self.returnBtn.hidden = YES;
    
    
    
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
    
    _userHeadImage = [UIButton buttonWithType:UIButtonTypeCustom];
    _userHeadImage.backgroundColor = [UIColor redColor];
    _userHeadImage.frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:128])/2, [ApplicationStyle control_height:10] + [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize], [ApplicationStyle control_weight:128], [ApplicationStyle control_weight:128]);
    _userHeadImage.layer.cornerRadius = [ApplicationStyle control_weight:128]/2;
    _userHeadImage.layer.borderWidth = [ApplicationStyle control_weight:3];
    _userHeadImage.layer.borderColor = [UIColor whiteColor].CGColor;
    _userHeadImage.alpha = 0.15;
    [_userHeadImage addTarget:self action:@selector(userHeadImageDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_userHeadImage];
    
    CGSize ss = [ApplicationStyle textSize:@"小丑" font:[ApplicationStyle textThrityFont] size:SCREENWIDTH];
    
    _userNameLab = [[UILabel alloc] initWithFrame:CGRectMake((SCREENWIDTH - ss.width)/2, _userHeadImage.bottomOffset + [ApplicationStyle control_height:26], ss.width, [ApplicationStyle control_height:34])];
    _userNameLab.font = [ApplicationStyle textThrityFont];
    _userNameLab.text = @"小丑";

    _userNameLab.textAlignment = NSTextAlignmentCenter;
    _userNameLab.textColor = [UIColor whiteColor];
    [self.view addSubview:_userNameLab];
    
    

    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle control_height:410], SCREENWIDTH, SCREENHEIGHT - [ApplicationStyle control_height:410] - [ApplicationStyle tabBarSize]) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    
    
}
#pragma mark 系统Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ApplicationStyle control_height:88];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *nlProTableCell = @"NLProTableCell";
    NLProTableCell *cell = [tableView dequeueReusableCellWithIdentifier:nlProTableCell];
    if (!cell) {
        cell = [[NLProTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nlProTableCell];
    }
    

    NSArray *cellLabArray = @[NSLocalizedString(@"NLProfileView_MyEquitment", nil),
                              NSLocalizedString(@"NLProfileView_Share", nil),
                              NSLocalizedString(@"NLProfileView_FeedBack", nil),
                              NSLocalizedString(@"NLProfileView_Set", nil),
                              NSLocalizedString(@"NLProfileView_AboutNL", nil),];
    NSArray *cellImageArray = @[@"ProFile_M_E_T",@"ProFile_S_H",@"ProFile_F_B",@"ProFile_SET",@"ProFile_A_NL"];
    
    

    
    
    
    cell.cellImages.image = [UIImage imageNamed:cellImageArray[indexPath.row]];
    cell.cellLabs.text = cellLabArray[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    switch (indexPath.row) {
        case 0:
        {
            NLMyEquipmentController *vc = [[NLMyEquipmentController alloc] init];
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:
        {
            break;
        }
        case 2:
        {
            NLFeedBackViewController *vc = [[NLFeedBackViewController alloc] init];
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:
        {
            break;
        }
        case 4:
        {
            NLAboutNLViewController *vc = [[NLAboutNLViewController alloc] init];
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
    
  
    
    
    
    
}
#pragma mark 自己的Delegate
#pragma mark 事件方法
-(void)userHeadImageDown{
    NLIndividuaFormatViewController *vc = [[NLIndividuaFormatViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
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
