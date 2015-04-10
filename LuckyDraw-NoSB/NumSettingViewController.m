//
//  NumSettingViewController.m
//  LuckyDraw-NoSB
//
//  Created by ZHOUTAO on 15/4/10.
//  Copyright (c) 2015年 ZHOUTAO. All rights reserved.
//

#import "NumSettingViewController.h"
#import "DrawingViewController.h"

@interface NumSettingViewController ()

/**抽奖总人数*/
@property (nonatomic, strong) UITextField *TotalPerson;
/**开始抽奖按钮*/
@property (nonatomic, strong) UIButton *startBtn;

@end


@implementation NumSettingViewController

//懒加载
//1.抽奖总人数TextField

-(UITextField *)TotalPerson{

    if (!_TotalPerson) {
        
        _TotalPerson = [[UITextField alloc] initWithFrame:CGRectMake(50, 280, 220, 35)];
        _TotalPerson.placeholder = @"请输入抽奖总人数";
        _TotalPerson.backgroundColor = [UIColor whiteColor];
        _TotalPerson.font = [UIFont fontWithName:@"Avenir-Light" size:16];
        
        [self.view addSubview:_TotalPerson];
    }
    
    return _TotalPerson;
}

-(UIButton *)startBtn{

    if (!_startBtn) {
        
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _startBtn.frame = CGRectMake(80, 500, 160, 40);
        [_startBtn setBackgroundColor:[UIColor lightGrayColor]];
        [_startBtn setTintColor:[UIColor whiteColor]];
        [_startBtn setTitle:@"Start" forState:UIControlStateNormal];
        _startBtn.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16];
        
        [self.view addSubview:_startBtn];
        
        [_startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _startBtn;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)(81/255.f) green:(CGFloat)(229/255.f) blue:(CGFloat)(239/255.f) alpha:1.f];
    
    [self TotalPerson];
    [self startBtn];
    
}

- (void)startBtnClick{

    NSLog(@"Clicked StartBtn");
    DrawingViewController *drawViewCtrl = [[DrawingViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:drawViewCtrl animated:YES];
}



@end
