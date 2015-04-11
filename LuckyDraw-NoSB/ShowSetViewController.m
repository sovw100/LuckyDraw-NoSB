//
//  ShowSetViewController.m
//  LuckyDraw-NoSB
//
//  Created by ZHOUTAO on 15/4/11.
//  Copyright (c) 2015年 ZHOUTAO. All rights reserved.
//

#import "ShowSetViewController.h"
#import "AppDelegate.h"

//TextField宏定义
#define WIDTH 220
#define HEIGHT 35
#define FONT_SIZE 16

static unsigned long numCell;//Cell在数组中的正确位置

@interface ShowSetViewController ()<UITextFieldDelegate>//设置TextField的代理

/**奖项文本框*/
@property (nonatomic, strong) UITextField *levelTextField;
/**奖品文本框*/
@property (nonatomic, strong) UITextField *prizeTextField;
/**获奖人数文本框*/
@property (nonatomic, strong) UITextField *numTextField;
/**保存按钮*/
@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation ShowSetViewController

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
    
    [self levelTextField];
    [self prizeTextField];
    [self numTextField];
    [self saveBtn];
    
    //Niklas 1.4.2015
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    NSDictionary *editInfoDicts = [[NSDictionary alloc]init];
    
    numCell = [myDelegate.strCell intValue];
    
    NSLog(@"第%@个cell在数组中是%ld：", myDelegate.strCell, numCell);
    
    editInfoDicts = [myDelegate.prizeInfoArray objectAtIndex:numCell];
    
    self.levelTextField.text = [editInfoDicts objectForKey:@"level"];
    self.prizeTextField.text = [editInfoDicts objectForKey:@"prize"];
    self.numTextField.text = [editInfoDicts objectForKey:@"num"];
    
    NSLog(@"ShowView被加载");
    /////////////////////////////////////////////////////////////////////////////////
    
}

- (void) saveBtnClick{
    
    
    //function 去除旧数据
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    NSMutableDictionary *processDelDicts = [[NSMutableDictionary alloc]init];
    NSString *delPrize = [[NSString alloc]init];
    unsigned int numCell = [myDelegate.strCell intValue];
    processDelDicts = [myDelegate.prizeInfoArray objectAtIndex:numCell];
    NSLog(@"processDelDicts%@", processDelDicts);
    delPrize = [processDelDicts objectForKey:@"prize"];
    NSLog(@"被删掉的是%@ 奖。",delPrize);
    //算出成员数
    unsigned long numObjProcessArray = [myDelegate.processArray count];
    
    
    //#function 删除prize信息，删除奖池信息 3.4.2015
    NSLog(@"processArray 有 %ld 个成员",numObjProcessArray);
    
    for (int i = 0; i < numObjProcessArray ; i++) {
        
        for (int j = 0; j < [myDelegate.processArray count] ; j++ ) {
            
            processDelDicts = [myDelegate.processArray objectAtIndex:j];
            NSLog(@"从process中抽出奖项名字：%@",[processDelDicts objectForKey:@"prize"]);
            
            if ( [[processDelDicts objectForKey:@"prize"]isEqualToString:delPrize] ) {
                NSLog(@"匹配成功！");
                [myDelegate.processArray removeObjectAtIndex:j];
                NSLog(@"还需要再比对%ld次", numObjProcessArray);
            }
        }
    }
    NSLog(@"去除该奖励后，奖池信息:%@", myDelegate.processArray);
    [myDelegate.prizeInfoArray removeObjectAtIndex:numCell];
    NSLog(@"删除后prizeInforArray信息：%@ ", myDelegate.prizeInfoArray);
    NSLog(@"第%d被删除", numCell);
    
    //function 从textFiled重新读入
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

@end
