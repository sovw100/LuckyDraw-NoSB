//
//  DrawingViewController.m
//  LuckyDraw-NoSB
//
//  Created by ZHOUTAO on 15/4/10.
//  Copyright (c) 2015年 ZHOUTAO. All rights reserved.
//

#import "DrawingViewController.h"
#import "AppDelegate.h"

//角度转弧度,传入角度，计算出弧度
#define angle2Radian(angle) ((angle) / 180.0 * M_PI)

@interface DrawingViewController ()<UITableViewDataSource, UITableViewDelegate>

/**显示抽奖结果的tableView*/
@property (nonatomic, strong) UITableView *mTableView;
/**抽奖按钮*/
@property (nonatomic, strong) UIButton *drawBtn;
/**用来往tableView上天加行数*/
@property (nonatomic)  NSMutableArray *cellDataArray;

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

//抽奖按钮惰性实例化
-(UIButton *)drawBtn{

    if (!_drawBtn) {
        
        _drawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _drawBtn.frame = CGRectMake(80, 500, 160, 40);
        _drawBtn.backgroundColor = [UIColor lightGrayColor];
        _drawBtn.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16];
        [_drawBtn setTitle:@"抽奖吧！" forState:UIControlStateNormal];
        
        [self.view addSubview:_drawBtn];
        
        //设置抽奖按钮监听
        [_drawBtn addTarget:self action:@selector(drawBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _drawBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)(81/255.f) green:(CGFloat)(229/255.f) blue:(CGFloat)(239/255.f) alpha:1.f];
    
    //这个不能忘记
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    self.navigationItem.title = @"抽奖ing";
    
    [self drawBtn];
    
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    NSLog(@"有%ld 个人抽奖", [myDelegate.exeProcessArray count] );
    NSString *strWinnner = [[NSString alloc]init];
    
    for (int i = 0 ; i < [myDelegate.exeProcessArray count] ; i++) {
        strWinnner = [NSString stringWithFormat:@"%d", i + 1];
        [myDelegate.winnerNumArray addObject:strWinnner];
    }
    
    NSLog(@"中奖号码%@", myDelegate.winnerNumArray );
    
}
//new--test
//抽奖按钮点击处理方法
- (void)drawBtnClick{

    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    if ( [myDelegate.winnerNumArray count] != 0) {
        if (!self.cellDataArray) {
            self.cellDataArray = [[NSMutableArray alloc] init];
        }
        [self.cellDataArray insertObject:[NSDate date] atIndex:0];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.mTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }

    

    /****给抽奖按钮创建动画****/
    // 1. 创建核心动画--关键帧动画
    CAKeyframeAnimation *drawBtnkeyAnima = [CAKeyframeAnimation animation];
    
    drawBtnkeyAnima.keyPath = @"transform.rotation";
    drawBtnkeyAnima.values = @[@(-angle2Radian(10)),@(angle2Radian(10)),@(-angle2Radian(10))];
    //动画完成后删除动画
    drawBtnkeyAnima.removedOnCompletion = YES;
    //保存动画的最新状态
    drawBtnkeyAnima.fillMode = kCAFillModeForwards;
    //动画时长
    drawBtnkeyAnima.duration = 0.5;
    //设置动画重复次数 MAXFLOAT无限次
//    drawBtnkeyAnima.repeatCount = MAXFLOAT;
    
    // 4. 添加核心动画
    [self.drawBtn.layer addAnimation:drawBtnkeyAnima forKey:nil];
}

#pragma mark - TabelView cell相关方法

//设置tableView的section数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

//设置tableView的cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellDataArray.count;
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
    
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    
    NSMutableArray *testArray = [[NSMutableArray alloc] initWithArray:myDelegate.exeProcessArray];
    NSDictionary *testDicts = [[NSDictionary alloc] init];
    
    int numDraw;
    
    if ( [myDelegate.exeProcessArray count] != 0 ) {
        
        numDraw = (arc4random() % [myDelegate.exeProcessArray count]);

        testDicts = [testArray objectAtIndex:numDraw];
        
        NSString *numOfPrize = [myDelegate.winnerNumArray objectAtIndex:numDraw];
        
        NSString *levelName = [testDicts objectForKey:@"level"];
        NSString *prizeName = [testDicts objectForKey:@"prize"];
        NSString *prizeInfoStr = [NSString stringWithFormat:@"奖项:%@  奖品:%@", levelName, prizeName];
        NSString *numStr = [NSString stringWithFormat:@"号码：%@", numOfPrize];
        
        cell.textLabel.text = prizeInfoStr;
        cell.detailTextLabel.text = numStr;
        
        [myDelegate.winnerNumArray removeObjectAtIndex:numDraw];
        [myDelegate.exeProcessArray removeObjectAtIndex:numDraw];
        
    }
    
    return cell;
    
    
}
//添加cell的动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    //动画1.大风车
    CAKeyframeAnimation *cellRotation = [CAKeyframeAnimation animation];
    
    cellRotation.keyPath = @"transform.rotation";
    cellRotation.values = @[@(-angle2Radian(30)),@(angle2Radian(30)),@(-angle2Radian(30))];
    //动画完成后删除动画
    cellRotation.removedOnCompletion = YES;
    //保存动画的最新状态
    cellRotation.fillMode = kCAFillModeForwards;
    //动画时长
    cellRotation.duration = 0.5;
    //设置动画重复次数 MAXFLOAT无限次
    cellRotation.repeatCount = 2;
    [cell.layer addAnimation:cellRotation forKey:nil];
    
    //动画2.缩放
    CAKeyframeAnimation *cellScale = [CAKeyframeAnimation animation];
    
    cellScale.keyPath = @"transform.scale";
    cellScale.values = @[@(0.3),@(1.5),@(0.3),@(1.0)];
    //动画完成后删除动画
    cellScale.removedOnCompletion = YES;
    //保存动画的最新状态
    cellScale.fillMode = kCAFillModeForwards;
    //动画时长
    cellScale.duration = 2.0;
    //设置动画重复次数 MAXFLOAT无限次
    cellScale.repeatCount = 1;
    [cell.layer addAnimation:cellScale forKey:nil];
    
}

@end
