//
//  NLFeedBackViewController.m
//  NBlue
//
//  Created by LYD on 15/11/27.
//  Copyright © 2015年 LYD. All rights reserved.
//

#import "NLFeedBackViewController.h"

@interface NLFeedBackViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UILabel *textViewLab;
@property(nonatomic,strong)UIButton *submitBtn;
@end

@implementation NLFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    {
        self.navBarBack.hidden = YES;
        self.navBarPushBack.hidden = NO;
        self.controllerBack.hidden = YES;
    }
    
    self.view.backgroundColor = [ApplicationStyle subjectBackViewColor];
    self.titles.text = NSLocalizedString(@"NLFeedBack_QuestionFeedBack", nil);
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
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, [ApplicationStyle control_height:26] + [ApplicationStyle statusBarSize] + [ApplicationStyle navigationBarSize], SCREENWIDTH, [ApplicationStyle control_height:260])];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:24]];
    [self.view addSubview:_textView];
    
    _textViewLab = [[UILabel alloc] initWithFrame:CGRectMake([ApplicationStyle control_weight:40], [ApplicationStyle control_height:20], SCREENWIDTH - [ApplicationStyle control_weight:40 *2], [ApplicationStyle control_height:24])];
    _textViewLab.textColor = [@"959595" hexStringToColor];
    _textViewLab.font = [UIFont systemFontOfSize:[ApplicationStyle control_weight:24]];
    _textViewLab.text = @"请输入您的宝贵意见";
    [_textView addSubview:_textViewLab];
    
    _submitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _submitBtn.frame = CGRectMake((SCREENWIDTH - [ApplicationStyle control_weight:560])/2, _textView.bottomOffset + [ApplicationStyle control_height:30], [ApplicationStyle control_weight:560], [ApplicationStyle control_height:88]);
    [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:[@"ffffff" hexStringToColor] forState:UIControlStateNormal];
    _submitBtn.titleLabel.font = [ApplicationStyle textThrityFont];
    
    _submitBtn.layer.cornerRadius = [ApplicationStyle control_weight:10];
    [_submitBtn addTarget:self action:@selector(submitBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
    
    if ([[kAPPDELEGATE._loacluserinfo getUserGender] isEqualToString:@"0"]) {
        _submitBtn.backgroundColor = [@"ff7591" hexStringToColor];
    }else{
        _submitBtn.backgroundColor = [ApplicationStyle subjectMaleBlueColor];
    }
    
    
    
}
#pragma mark 系统Delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSString *new = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if ([new length]) {
        _textViewLab.hidden = YES;
    }else{
        _textViewLab.hidden = NO;
    }
    
    if ([text isEqualToString:@"\n"]) {
        [textView endEditing:YES];
    }
    
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];
}
#pragma mark 自己的Delegate
#pragma mark 自己的按钮事件
-(void)submitBtnDown{
    [_textView endEditing:YES];
    
    [kAPPDELEGATE AutoDisplayAlertView:@"提示" :@"谢谢你的宝贵意见~~我们会及时处理"];
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
