//
//  SettingViewController.m
//  LuckyDraw-NoSB
//
//  Created by ZHOUTAO on 15/4/10.
//  Copyright (c) 2015年 ZHOUTAO. All rights reserved.
//

#import "SettingViewController.h"

//TextField宏定义
#define WIDTH 220
#define HEIGHT 35
#define FONT_SIZE 16

@interface SettingViewController ()

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
        
        _levelTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 200, WIDTH, HEIGHT)];
        _levelTextField.placeholder = @"请输入奖项名称";
        _levelTextField.backgroundColor = [UIColor whiteColor];
        _levelTextField.font = [UIFont fontWithName:@"Avenir-Light" size:FONT_SIZE];
        [self.view addSubview:_levelTextField];
    }
    
    return _levelTextField;
}

//2.奖品文本框
-(UITextField *)prizeTextField{
    
    if (!_prizeTextField) {
        
        _prizeTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 260, WIDTH, HEIGHT)];
        _prizeTextField.placeholder = @"请输入奖品名称";
        _prizeTextField.backgroundColor = [UIColor whiteColor];
        _prizeTextField.font = [UIFont fontWithName:@"Avenir-Light" size:FONT_SIZE];
        [self.view addSubview:_prizeTextField];
    }
    
    return _prizeTextField;
}

//3.获奖人数文本框
-(UITextField *)numTextField{
    
    if (!_numTextField) {
        _numTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 320, WIDTH, HEIGHT)];
        _numTextField.placeholder = @"请输入获奖人数";
        _numTextField.backgroundColor = [UIColor whiteColor];
        _numTextField.font = [UIFont fontWithName:@"Avenir-Light" size:FONT_SIZE];
        [self.view addSubview:_numTextField];
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
    
    [self levelTextField];
    [self prizeTextField];
    [self numTextField];
    [self saveBtn];
    
}

- (void) saveBtnClick{

    NSLog(@"Saved");
}


@end
