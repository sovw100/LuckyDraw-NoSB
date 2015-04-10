//
//  DrawingViewController.m
//  LuckyDraw-NoSB
//
//  Created by ZHOUTAO on 15/4/10.
//  Copyright (c) 2015年 ZHOUTAO. All rights reserved.
//

#import "DrawingViewController.h"

@interface DrawingViewController ()<UITableViewDataSource, UITableViewDelegate>

/**显示抽奖结果的tableView*/
@property (nonatomic, strong) UITableView *mTableView;
/**抽奖按钮*/
@property (nonatomic, strong) UIButton *drawBtn;

@end

@implementation DrawingViewController

-(UITableView *)mTableView{
    
    if (!_mTableView) {
        
        _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 500) style:UITableViewStylePlain];
        _mTableView.backgroundColor = [UIColor colorWithRed:(CGFloat)(81/255.f) green:(CGFloat)(229/255.f) blue:(CGFloat)(239/255.f) alpha:1.f];
        _mTableView.tableFooterView = [[UITableView alloc] init];
        
        [self.view addSubview:_mTableView];
    }
    
    return _mTableView;
}

-(UIButton *)drawBtn{

    if (!_drawBtn) {
        
        _drawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _drawBtn.frame = CGRectMake(80, 500, 160, 40);
        _drawBtn.backgroundColor = [UIColor lightGrayColor];
        _drawBtn.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16];
        [_drawBtn setTitle:@"抽奖吧！" forState:UIControlStateNormal];
        
        [self.view addSubview:_drawBtn];
        
        [_drawBtn addTarget:self action:@selector(drawBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _drawBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)(81/255.f) green:(CGFloat)(229/255.f) blue:(CGFloat)(239/255.f) alpha:1.f];
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    [self drawBtn];
    
}

- (void)drawBtnClick{

    NSLog(@"Drawing!!");
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
