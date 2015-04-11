//
//  SettingViewController.m
//  LuckyDraw-NoSB
//
//  Created by ZHOUTAO on 15/4/10.
//  Copyright (c) 2015年 ZHOUTAO. All rights reserved.
//

#import "SettingViewController.h"
#import "AppDelegate.h"

//TextField宏定义
#define WIDTH 220
#define HEIGHT 35
#define FONT_SIZE 16

@interface SettingViewController ()<UITextFieldDelegate>//设置TextField的代理

/**奖项文本框*/
@property (nonatomic, strong) UITextField *levelTextField;
/**奖品文本框*/
@property (nonatomic, strong) UITextField *prizeTextField;
/**获奖人数文本框*/
@property (nonatomic, strong) UITextField *numTextField;
/**保存按钮*/
@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation SettingViewController

//控件懒加载
//1.奖项文本框
-(UITextField *)levelTextField{

    if (!_levelTextField) {
        
        _levelTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 160, WIDTH, HEIGHT)];
        _levelTextField.placeholder = @"请输入奖项名称";
        _levelTextField.backgroundColor = [UIColor whiteColor];
        _levelTextField.font = [UIFont fontWithName:@"Avenir-Light" size:FONT_SIZE];
        [self.view addSubview:_levelTextField];
        
        _levelTextField.delegate = self;
    }
    
    return _levelTextField;
}

//2.奖品文本框
-(UITextField *)prizeTextField{
    
    if (!_prizeTextField) {
        
        _prizeTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 220, WIDTH, HEIGHT)];
        _prizeTextField.placeholder = @"请输入奖品名称";
        _prizeTextField.backgroundColor = [UIColor whiteColor];
        _prizeTextField.font = [UIFont fontWithName:@"Avenir-Light" size:FONT_SIZE];
        [self.view addSubview:_prizeTextField];
        
        _prizeTextField.delegate = self;
    }
    
    return _prizeTextField;
}

//3.获奖人数文本框
-(UITextField *)numTextField{
    
    if (!_numTextField) {
        _numTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 280, WIDTH, HEIGHT)];
        _numTextField.placeholder = @"请输入获奖人数";
        _numTextField.backgroundColor = [UIColor whiteColor];
        _numTextField.font = [UIFont fontWithName:@"Avenir-Light" size:FONT_SIZE];
        _numTextField.keyboardType = UIKeyboardTypeNumberPad;
        [self.view addSubview:_numTextField];
        
        _numTextField.delegate = self;
    }
    
    return _numTextField;
}


//4.Save button
-(UIButton *)saveBtn{
    
    if (!_saveBtn) {
        
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.frame = CGRectMake(80, 500, 160, 40);
        [_saveBtn setBackgroundColor:[UIColor lightGrayColor]];
        [_saveBtn setTintColor:[UIColor whiteColor]];
        [_saveBtn setTitle:@"Save" forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16];
        
        [self.view addSubview:_saveBtn];
        
        [_saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _saveBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)(81/255.f) green:(CGFloat)(229/255.f) blue:(CGFloat)(239/255.f) alpha:1.f];
    
    self.navigationItem.title = @"奖项设置";
    
    [self levelTextField];
    [self prizeTextField];
    [self numTextField];
    [self saveBtn];

}

- (void) saveBtnClick{
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    NSMutableDictionary *processDicts = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *prizeInfoDicts = [[NSMutableDictionary alloc] init];
    
    int num = [self.numTextField.text intValue];
    for (int i = 0 ; i< num; i++ ) {
        //Process 的数据
        [processDicts setValue:self.levelTextField.text forKey:@"level"];
        [processDicts setValue:self.prizeTextField.text forKey:@"prize"];
        [myDelegate.processArray addObject:processDicts];
    }
    NSLog(@"processArray%@", myDelegate.processArray);
    
    
    //prize information
    [prizeInfoDicts setValue:self.levelTextField.text forKey:@"level"];
    [prizeInfoDicts setValue:self.prizeTextField.text forKey:@"prize"];
    [prizeInfoDicts setValue:self.numTextField.text forKey:@"num"];
    [myDelegate.prizeInfoArray insertObject:prizeInfoDicts atIndex:[myDelegate.prizeInfoArray count]];
    
    NSLog(@"Prize's Information's Array %@", myDelegate.prizeInfoArray);
}

//键盘按return键后从屏幕消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    return YES;
}
//点击TextField以外的区域让键盘消失,解决数字键盘无return键问题
//这个方法应该是最简单的了
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}

@end
