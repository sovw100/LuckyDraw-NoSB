//
//  NumSettingViewController.m
//  LuckyDraw-NoSB
//
//  Created by ZHOUTAO on 15/4/10.
//  Copyright (c) 2015年 ZHOUTAO. All rights reserved.
//

#import "NumSettingViewController.h"
#import "DrawingViewController.h"
#import "AppDelegate.h"

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
        
        _TotalPerson = [[UITextField alloc] initWithFrame:CGRectMake(50, 200, 220, 35)];
        _TotalPerson.placeholder = @"请输入抽奖总人数";
        _TotalPerson.backgroundColor = [UIColor whiteColor];
        _TotalPerson.font = [UIFont fontWithName:@"Avenir-Light" size:16];
        _TotalPerson.keyboardType = UIKeyboardTypeNumberPad;
    
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
    
    self.navigationItem.title = @"抽奖人数";
    
    [self TotalPerson];
    [self startBtn];
    
}

//Start按钮点击事件处理
- (void)startBtnClick{

    DrawingViewController *drawViewCtrl = [[DrawingViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:drawViewCtrl animated:YES];
    
    NSLog(@"Here is %@ player", self.TotalPerson.text);
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    myDelegate.strPlayer = self.TotalPerson.text;
    
    NSUInteger numPlayer = [myDelegate.strPlayer intValue];
    NSLog(@"numPlayer %ld",numPlayer);
    
    NSUInteger numPrize = [myDelegate.processArray count];
    NSLog(@"numPrize %lu", numPrize);
    
    NSMutableDictionary *infoDicts = [[NSMutableDictionary alloc]init];
    
    NSUInteger numNone = numPlayer - numPrize;
    NSLog(@"numNone %lu", numNone);
    
    if ( numPlayer > 0 ) {
        for (int i = 0; i < numNone ; i++ ) {
            
            [infoDicts setValue:@"没中奖" forKey:@"level"];
            [infoDicts setValue:@"没奖品" forKey:@"prize"];
            [myDelegate.processArray addObject:infoDicts];
        }
    } else {
        //以后加上警报：关于人数不正确。
        NSLog(@"I think you need more people 0.0");
    }
    
    NSLog(@"知道参加人数后的抽奖池:%lu", [myDelegate.processArray count]);
    NSLog(@"抽奖池:%@", myDelegate.processArray);
    
    myDelegate.exeProcessArray = [myDelegate.processArray mutableCopy];
}

//点击TextField以外区域，键盘消失
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}

@end
