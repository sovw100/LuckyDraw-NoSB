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
    
        // 1. 创建核心动画
        CATransition *transition = [CATransition animation];
        // 2. 选择动画过渡效果
        transition.type = @"cube";
        transition.subtype = kCATransitionFromRight;
        // 3.设置动画时间
        transition.duration = 0.5;
        // 4. 添加核心动画
    
        transition.delegate = self;
    
        [self.view.layer addAnimation:transition forKey:nil];
    
    
    //专场动画的几个属性
    /*
     ♢type -- 动画过渡效果
     
     1.fade                      交叉淡化过渡，不支持过渡方向，kCATransitionFade
     2.push                      新视图把旧视图推出去 kCATransitionPush
     3.moveIn                    新视图移到旧视图上面 kCATransitionMoveIn
     4.reveal                    将旧视图移开，显示下面的新视图 kCATransitionReveal
     5.cube                      立方体翻滚效果
     6.oglFlip                   上下左右翻转效果
     7.suckEffect                收缩效果，如一块布被抽走，不支持过渡方向
     8.rippleEffect              滴水效果，不支持过渡方向
     9.pageCurl                  向上翻页效果
     10.pageUnCurl               向下翻页效果
     11.cameraIrisHollowOpen     相机镜头打开效果，不支持过渡方向
     12.cameraIrisHollowClose    相机镜头关闭效果，不支持过渡方向
     */
    
    /*
     ♢subtype -- 过渡方向
     
     kCATransitionFromRight
     kCATransitionFromLeft
     kCATransitionFromTop
     kCATransitionFromBottom
     */
    
    //♢startProgress 动画起点（在整体动画的百分比）
    //♢stopProgress 动画终点（在整体动画的百分比）
    

    
}

//该方法是实现转场动画结束后再跳转至抽奖设置界面
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    SettingViewController *setViewCtrl = [[SettingViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:setViewCtrl animated:NO];
}

// Next按钮点击处理
- (void)nextBtnClick{

    //另一种动画实现方式--块动画
    //在completion里面可以设置动画完成后做什么事情
    //这里的options选择太少了，动画效果就那么几个，还是上面那种方法好
    [UIView transitionWithView:self.navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
//        NumSettingViewController *numSetViewCtrl = [[NumSettingViewController alloc] initWithNibName:nil bundle:nil];
//        [self.navigationController pushViewController:numSetViewCtrl animated:NO];
    } completion:^(BOOL finished) {
        
        //这两句放在上面的block里面也可以
        NumSettingViewController *numSetViewCtrl = [[NumSettingViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:numSetViewCtrl animated:NO];
    }];
    
    
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
