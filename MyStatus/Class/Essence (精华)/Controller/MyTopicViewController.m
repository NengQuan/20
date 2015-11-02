//
//  MyTopicViewController.m
//  MyStatus
//
//  Created by NengQuan on 15/10/27.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyTopicViewController.h"
#import "MyAllViewCell.h"
#import "MyHTTPSessionManager.h"
#import "MyTopics.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "MyDIVHeader.h"
#import "MyDIVFooter.h"
#import "MyNavigationViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "MyCommentViewController.h"


@interface MyTopicViewController () <UITableViewDelegate,MyAllViewCellDelegate>

@property (nonatomic,strong) NSMutableArray *topices;
// 存储最后一条动态的ID
@property (nonatomic,strong) NSString *maxtime;

@end
@implementation MyTopicViewController

static NSString * const XMGCellId = @"topic";

- (MyTopicType)type
{
    return 0;
}
- (NSMutableArray *)topices
{
    if (_topices == nil) {
        _topices = [NSMutableArray array];
    }
    return _topices;
}

#pragma  mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化tableview
    [self setUpTableview];
    
    // 增加刷新控件
    [self setUpRefresh];
    
    self.navigationItem.title = @"首页";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"nav_list_gray" Heightimage:@"nav_list_gray" target:(MyNavigationViewController *)self.navigationController action:@selector(showMenu)];
    
}

/**
 *  初始化tableview
 */
- (void)setUpTableview
{
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyAllViewCell class]) bundle:nil] forCellReuseIdentifier:XMGCellId];
    
    // 设置内边距
    self.tableView.backgroundColor = MyGlobalBg;
}

- (void)setUpRefresh
{
    // 下拉刷新
    self.tableView.header = [MyDIVHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewStatus)];
    
    // 自动进入刷新状态
    [self.tableView.header beginRefreshing];
    
    // 上拉刷新
    self.tableView.footer = [MyDIVFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStatus)];
    
}

#pragma mark - 加载数据

- (void)loadMoreStatus
{
    // block中用弱指针
    __weak typeof(self) weakSelf = self;
    // 请求参数
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"newlist";
    parame[@"c"] = @"data";
    parame[@"type"] = @(self.type);
    parame[@"maxtime"] = self.maxtime;
    
    // 发送请求
    [[MyHTTPSessionManager manager] GET:MyUrl parameters:parame success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //                int i = 0;
        //                NSArray *dictArray = responseObject[@"list"];
        //                for (NSMutableDictionary *dict in dictArray) {
        //                    NSArray *top_cmt = dict[@"top_cmt"];
        //                    if (top_cmt.count) {
        //                        NSLog(@"第%d有最热",i);
        //                    }
        //                    i ++;
        //                }
        //                MyWriteToPlist(responseObject, @"top_2");
        //存储maxtime
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 ->模型数组
        NSArray *moreTopics =[MyTopics objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 增加到以前数组的最后面
        [weakSelf.topices addObjectsFromArray:moreTopics];
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 结束刷新
        [weakSelf.tableView.footer endRefreshing];
    }];
    
}

- (void)loadNewStatus
{
    // block中用弱指针
    __weak typeof(self) weakSelf = self;
    // 请求参数
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"newlist";
    parame[@"c"] = @"data";
    parame[@"type"] = @(self.type);
    
    // 发送请求
    [[MyHTTPSessionManager manager] GET:MyUrl parameters:parame success:^(NSURLSessionDataTask *task, id responseObject) {
        //
        //                int i = 0;
        //                NSArray *dictArray = responseObject[@"list"];
        //                for (NSMutableDictionary *dict in dictArray) {
        //                    NSArray *top_cmt = dict[@"top_cmt"];
        //                    if (top_cmt.count) {
        //                        NSLog(@"第%d有最热",i);
        //                    }
        //                    i ++;
        //                }
        //                MyWriteToPlist(responseObject, @"top_1");
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 ->模型数组
        weakSelf.topices =[MyTopics objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [weakSelf.tableView.header endRefreshing];
    }];
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyAllViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGCellId];
    
    cell.topic = self.topices[indexPath.row];
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTopics *topics = self.topices[indexPath.row];
    return topics.cellHeight;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCommentViewController *commentVC = [[MyCommentViewController alloc]init];
    commentVC.topic = self.topices[indexPath.row];
    [self.navigationController pushViewController:commentVC animated:YES];
}

- (void)MyAllViewDidClick:(MyAllViewCell *)cell
{
    MyCommentViewController *commentVC = [[MyCommentViewController alloc]init];
    commentVC.topic = cell.topic;
    [self.navigationController pushViewController:commentVC animated:YES];
}
@end
