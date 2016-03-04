//
//  NLIndividuaEditingViewController.m
//  NBlue
//
//  Created by LYD on 15/11/26.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLIndividuaEditingViewController.h"

@interface NLIndividuaEditingViewController ()<UITextFieldDelegate>{
    
}
@property(nonatomic,strong)UITextField *nameTextFiled;
@end

@implementation NLIndividuaEditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    
    self.view.backgroundColor = [ApplicationStyle subjectBackViewColor];
    
    self.titles.text = NSLocalizedString(@"", nil);
    [self bulidUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_nameTextFiled becomeFirstResponder];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_nameTextFiled resignFirstResponder];
}
#pragma mark 基础UI
-(void)bulidUI{
    UIView *filedBackView = [[UIView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize] + [ApplicationStyle control_height:20], SCREENWIDTH, [ApplicationStyle control_height:88])];
    filedBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:filedBackView];
    
    _nameTextFiled = [[UITextField alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:20], 0, filedBackView.viewWidth - [ApplicationStyle control_weight:20 * 2], [ApplicationStyle control_height:88])];
    _nameTextFiled.font = [ApplicationStyle textThrityFont];
    _nameTextFiled.placeholder = @"请输入名字";
    _nameTextFiled.text = self.userName;
    _nameTextFiled.clearButtonMode = UITextFieldViewModeAlways;
    _nameTextFiled.returnKeyType = UIReturnKeyDefault;
    _nameTextFiled.delegate = self;
    [filedBackView addSubview:_nameTextFiled];
}
#pragma mark 系统Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark 自己的Delegate
#pragma mark 自己的按钮事件
-(void)returnBtnDown{
    if (self.editionName) {
       self.editionName(_nameTextFiled.text);
    }
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
