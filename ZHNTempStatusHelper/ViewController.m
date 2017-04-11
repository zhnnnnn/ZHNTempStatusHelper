//
//  ViewController.m
//  ZHNtemp
//
//  Created by zhn on 2017/4/10.
//  Copyright © 2017年 zhn. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "ZHNTempStatusMan.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *contentTableView;
@property (nonatomic,assign) int index;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentTableView = [[UITableView alloc]init];
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    [self.view addSubview:self.contentTableView];
    self.contentTableView.frame = self.view.bounds;
    self.contentTableView.superViewController = self;
    self.contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self p_loadDatas];
    }];
}

- (void)p_loadDatas{
    self.index ++;
    [self.contentTableView reloadData];
    [self.contentTableView.mj_header endRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.index%2 == 0) {
        return 10;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UITableViewCell alloc]init];
}

- (UIView *)ZHN_tempStatusPlaceholderView {
    UIView *tempView = [[UIView alloc]init];
    tempView.backgroundColor = [UIColor whiteColor];
    UILabel *stateLabel = [[UILabel alloc]init];
    [tempView addSubview:stateLabel];
    stateLabel.center = self.view.center;
    stateLabel.bounds = CGRectMake(0, 0, 100, 200);
    if (self.index == 3 || self.index == 7) {
        stateLabel.text = @"网络错误";
        tempView.backgroundColor = [UIColor redColor];
    }else {
        stateLabel.text = @"没有数据";
        tempView.backgroundColor = [UIColor yellowColor];
    }
    return tempView;
}

- (BOOL)ZHN_tempStatusEnableTableViewScroll {
    return YES;
}
@end
