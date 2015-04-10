//
//  ViewController.m
//  LuckyDraw-NoSB
//
//  Created by ZHOUTAO on 15/4/10.
//  Copyright (c) 2015年 ZHOUTAO. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIBarButtonItem *leftBtn;
@property (nonatomic, strong) UIBarButtonItem *rightBtn;

@end

@implementation ViewController

//控件懒加载
//（1）不必将创建对象的代码全部写在viewDidLoad方法中，代码的可读性更强
//（2）每个控件的getter方法中分别负责各自的实例化处理，代码彼此之间的独立性强，松耦合
-(UITableView *)mTableView{

    if (!_mTableView) {
        
        _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 468) style:UITableViewStylePlain];
        _mTableView.backgroundColor = [UIColor yellowColor];
        
        [self.view addSubview:_mTableView];
    }
    
    return _mTableView;
}

-(UIButton *)nextBtn{

    if (!_nextBtn) {
        
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.frame = CGRectMake(80, 498, 160, 40);
        [_nextBtn setBackgroundColor:[UIColor grayColor]];
        [_nextBtn setTitle:@"Next" forState:UIControlStateNormal];
        [_nextBtn setTitle:@"Clicked" forState:UIControlStateHighlighted];
        _nextBtn.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16];
        
        [self.view addSubview:_nextBtn];
    }
    
    return _nextBtn;
}

-(UIBarButtonItem *)leftBtn{

    if (!_leftBtn) {
        _leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(clearBtnClick)];
        self.navigationItem.leftBarButtonItem = _leftBtn;
    }
    
    return _leftBtn;
}

-(UIBarButtonItem *)rightBtn{

    if (!_rightBtn) {
        
        _rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"➕" style:UIBarButtonItemStylePlain target:self action:@selector(addBtnClick)];
        self.navigationItem.rightBarButtonItem = _rightBtn;
    }
    
    return _rightBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    [self nextBtn];
    [self leftBtn];
    [self rightBtn];
}

- (void)clearBtnClick{
    
    NSLog(@"Clicked ClearBtn");
}

- (void)addBtnClick{
    
    NSLog(@"Clicked addBtn");
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MyIdenifier = @"MyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdenifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdenifier];
    }
    
    cell.textLabel.text = @"Success";
    
    
    return cell;
    
}

@end
