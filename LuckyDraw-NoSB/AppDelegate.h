//
//  AppDelegate.h
//  LuckyDraw-NoSB
//
//  Created by ZHOUTAO on 15/4/10.
//  Copyright (c) 2015年 ZHOUTAO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSMutableArray *processArray;
@property (strong, nonatomic) NSMutableArray *exeProcessArray; //copy froming process

@property (strong, nonatomic) NSMutableArray *prizeInfoArray;
@property (strong, nonatomic) NSMutableArray *winnerNumArray;

@property (strong, nonatomic) NSString *strPlayer;
@property (strong, nonatomic) NSString *strCell; //第一个tableView的Cell

@end

