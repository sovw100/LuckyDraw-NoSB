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
#import "AppDelegate.h"
#import "ShowSetViewController.h"

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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.mTableView reloadData];
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
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    [myDelegate.processArray removeAllObjects];
    [myDelegate.prizeInfoArray removeAllObjects];
    
    [self.mTableView reloadData];
}

//添加按钮点击处理
- (void)addBtnClick{
    
    //跳转至奖项设置界面
    SettingViewController *setViewCtrl = [[SettingViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:setViewCtrl animated:YES];
    
}

// Next按钮点击处理
- (void)nextBtnClick{
    
    //跳转至总抽奖人数设置界面
    NumSettingViewController *numSetViewCtrl = [[NumSettingViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:numSetViewCtrl animated:YES];
}

#pragma mark - TabelView cell相关方法

//设置tableView的section数，可选方法，默认返回1，可选择不实现该方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

//设置tableView的cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    return [myDelegate.prizeInfoArray count];
}

//配置cell--cell的textLable, detailTextLabel, imageView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MyIdenifier = @"MyCell";
    
    //复用cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdenifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdenifier];
        //点击该行进入下一个页面
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    NSDictionary *prizeInfo = [[NSDictionary alloc] init];
    prizeInfo = [myDelegate.prizeInfoArray objectAtIndex:indexPath.row];
    
    NSString *level = [prizeInfo objectForKey:@"level"];
    NSString *prize = [prizeInfo objectForKey:@"prize"];
    NSString *num = [prizeInfo objectForKey:@"num"];
    NSString *prizeInfoStr = [NSString stringWithFormat:@"奖项：%@ 奖品：%@", level, prize];
    NSString *numStr = [NSString stringWithFormat:@"奖品个数：%@", num];

    cell.backgroundColor = [UIColor colorWithRed:(CGFloat)(81/255.f) green:(CGFloat)(229/255.f) blue:(CGFloat)(239/255.f) alpha:1.f];
    cell.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:18];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12];
    cell.textLabel.text = prizeInfoStr;
    cell.detailTextLabel.text = numStr;
    

    return cell;
    
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    
    [super setEditing:editing animated:animated];
    [self.mTableView setEditing:editing animated:animated];
}

//返回类型：进入编辑状态时候，选择返回删除或者增加
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
//    return UITableViewCellEditingStyleInsert; 增加
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowSetViewController *showSetViewCtrl = [[ShowSetViewController alloc] init];
    [self.navigationController pushViewController:showSetViewCtrl animated:YES];
    NSInteger row = [indexPath row];
    showSetViewCtrl.index = row;
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    myDelegate.strCell = [NSString stringWithFormat:@"%ld", row];
    
    NSLog(@"第 %ld 个cell", row);
}

@end
