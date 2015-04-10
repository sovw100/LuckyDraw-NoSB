//
//  ViewController.m
//  LuckyDraw-NoSB
//
//  Created by ZHOUTAO on 15/4/10.
//  Copyright (c) 2015年 ZHOUTAO. All rights reserved.
//

#import "ViewController.h"
#import "SettingViewController.h"
#import "NumSettingViewController.h"

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

// 1.tabelView
-(UITableView *)mTableView{

    if (!_mTableView) {
        
        _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 500) style:UITableViewStylePlain];
        _mTableView.backgroundColor = [UIColor colorWithRed:(CGFloat)(81/255.f) green:(CGFloat)(229/255.f) blue:(CGFloat)(239/255.f) alpha:1.f];
        _mTableView.tableFooterView = [[UITableView alloc] init];
        
        [self.view addSubview:_mTableView];
    }
    
    return _mTableView;
}

// 2.屏幕最下方的 Next 按钮
-(UIButton *)nextBtn{

    if (!_nextBtn) {
        
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.frame = CGRectMake(80, 498, 160, 40);
        [_nextBtn setBackgroundColor:[UIColor lightGrayColor]];
        [_nextBtn setTitle:@"Next" forState:UIControlStateNormal];
        [_nextBtn setTitle:@"Clicked" forState:UIControlStateHighlighted];
        _nextBtn.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16];
        
        [self.view addSubview:_nextBtn];
        
        [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _nextBtn;
}

//3. 左上角的Clear按钮
-(UIBarButtonItem *)leftBtn{

    if (!_leftBtn) {
        _leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(clearBtnClick)];
        self.navigationItem.leftBarButtonItem = _leftBtn;
    }
    
    return _leftBtn;
}

//4. 右上角的添加按钮
-(UIBarButtonItem *)rightBtn{

    if (!_rightBtn) {
        
        _rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"➕" style:UIBarButtonItemStylePlain target:self action:@selector(addBtnClick)];
        self.navigationItem.rightBarButtonItem = _rightBtn;
    }
    
    return _rightBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)(81/255.f) green:(CGFloat)(229/255.f) blue:(CGFloat)(239/255.f) alpha:1.f];

    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    self.navigationItem.title = @"Home";
    
    [self nextBtn];
    [self leftBtn];
    [self rightBtn];
    
}

//Clear按钮点击处理
- (void)clearBtnClick{
    
    NSLog(@"Clicked ClearBtn");
}

//添加按钮点击处理
- (void)addBtnClick{
    
    NSLog(@"Clicked addBtn");
    SettingViewController *setViewCtrl = [[SettingViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:setViewCtrl animated:YES];
    
}

// Next按钮点击处理
- (void)nextBtnClick{

    NumSettingViewController *numSetViewCtrl = [[NumSettingViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:numSetViewCtrl animated:YES];
}

#pragma mark - TabelView cell相关方法

//设置tableView的section数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

//设置tableView的cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

//配置cell--cell的textLable, detailTextLabel, imageView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MyIdenifier = @"MyCell";
    
    //复用cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdenifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdenifier];
    }
    
    cell.backgroundColor = [UIColor colorWithRed:(CGFloat)(81/255.f) green:(CGFloat)(229/255.f) blue:(CGFloat)(239/255.f) alpha:1.f];
    cell.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:18];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12];
    cell.textLabel.text = @"Success";
    cell.detailTextLabel.text = @"Text Font";
    

    return cell;
    
}

@end
