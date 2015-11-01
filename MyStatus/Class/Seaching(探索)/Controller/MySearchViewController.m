//
//  MySearchViewController.m
//  MyStatus
//
//  Created by NengQuan on 15/10/29.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MySearchViewController.h"
#import "MyHTTPSessionManager.h"
#import "MyDIVFooter.h"
#import "MyDIVHeader.h"
#import "MyCategery.h"
#import "MyFriendUser.h"
#import <MJExtension.h>
#import "MyCategeryCell.h"
#import "MyFriendUserCell.h"
#import "MyNavigationViewController.h"
#import "UIBarButtonItem+Extension.h"

@interface MySearchViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 👈列表表格 **/
@property (weak, nonatomic) IBOutlet UITableView *CategerytableView;
/** 👉类别表格 **/
@property (nonatomic,strong) IBOutlet UITableView *UsertableView;

@property (nonatomic,weak) MyHTTPSessionManager *manager;

@property (nonatomic,strong) NSArray *categerys;

@end

static NSString * const ID = @"categery";
static NSString * const userID = @"cell";
#define selectCategory self.categerys[self.CategerytableView.indexPathForSelectedRow.row]

@implementation MySearchViewController


- (MyHTTPSessionManager *)manager
{
    if (_manager == nil) {
        [MyHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 初始化tableview
    [self setUptableview];
    
    // 加载categery数据
    [self loadCategery];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"nav_list_gray" Heightimage:@"nav_list_gray" target:(MyNavigationViewController *)self.navigationController action:@selector(showMenu)];
    self.navigationItem.title = @"探索";
}

- (void)setUptableview
{
    
    self.CategerytableView.dataSource = self;
    self.CategerytableView.delegate = self;
    self.CategerytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.UsertableView.dataSource = self;
    self.UsertableView.delegate = self;
    self.UsertableView.rowHeight = 70;
    
    // 注册
    [self.CategerytableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyCategeryCell class]) bundle:nil] forCellReuseIdentifier:ID];
    [self.UsertableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyFriendUserCell class]) bundle:nil] forCellReuseIdentifier:userID];
    
    // 禁止掉自动设置scrollview的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.CategerytableView.contentInset = UIEdgeInsetsMake(MyNavBarbottom, 0, 0, 0);
    self.UsertableView.contentInset = UIEdgeInsetsMake(MyNavBarbottom, 0, 0, 0);
    self.CategerytableView.scrollIndicatorInsets = self.CategerytableView.contentInset;
    self.UsertableView.scrollIndicatorInsets = self.UsertableView.contentInset;
    
    // 初始化刷新控件
    self.UsertableView.header = [MyDIVHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewuser)];
    self.UsertableView.footer = [MyDIVFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmoreuser)];
    
}

#pragma mark - 加载数据
/**
 *  加载categery数据
 */
- (void)loadCategery
{
    // block中用弱指针
    __weak typeof(self) weakSelf = self;
    // 请求参数
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"category";
    parame[@"c"] = @"subscribe";
    
    // 发送请求
    [[MyHTTPSessionManager manager] GET:MyUrl parameters:parame success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 字典- 模型
        weakSelf.categerys = [MyCategery objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [weakSelf.CategerytableView reloadData];
        
        // 默认选中第一个(表格刷新完后才可以选中第一个)
        [weakSelf.CategerytableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        // 刷新右边表格
        [self.UsertableView.header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"shibai");
    }];
    
}

/**
 *  下拉刷新加载新的数据
 */
- (void)loadNewuser
{
    // 取消之前的请求 (防止上拉刷新和下拉刷新冲突)
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // block中用弱指针
    __weak typeof(self) weakSelf = self;
    
    // 获得当前选中的类别模型
    MyCategery *categery = self.categerys[self.CategerytableView.indexPathForSelectedRow.row];
    
    // 请求参数
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"list";
    parame[@"c"] = @"subscribe";
    parame[@"category_id"] = categery.id;
    
    // 发送请求
    [[MyHTTPSessionManager manager] GET:MyUrl parameters:parame success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 赋值新的页码
        categery.page = 1;
        
        // 字典- 模型
        categery.users = [MyFriendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [weakSelf.UsertableView reloadData];
        
        [self.UsertableView.header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"shibai");
    }];
    
}

/**
 *  上拉加载更多数据
 */
- (void)loadmoreuser
{
    // 取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // block中用弱指针
    __weak typeof(self) weakSelf = self;
    
    // 获得当前选中的类别模型
    MyCategery *categery = self.categerys[self.CategerytableView.indexPathForSelectedRow.row];
    // 请求参数
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"list";
    parame[@"c"] = @"subscribe";
    parame[@"category_id"] = categery.id;
    NSInteger page = categery.page + 1;
    parame[@"page"] = @(page);
    
    // 发送请求
    [[MyHTTPSessionManager manager] GET:MyUrl parameters:parame success:^(NSURLSessionDataTask *task, id responseObject) {
        
        categery.page = page;
        // 字典- 模型
        NSArray *moreuser = [MyFriendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [categery.users addObjectsFromArray:moreuser];
        
        // 总数
        categery.total = [responseObject[@"total"] integerValue];
        // 刷新表格
        [weakSelf.UsertableView reloadData];
        
        // 结束刷新
        if (categery.users.count == categery.total) { // 用户全部加载完毕提醒隐藏
            weakSelf.UsertableView.footer.hidden = YES;
        } else {
            [weakSelf.UsertableView.footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"shibai");
    }];
    
}

#pragma mark - 代理和数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.CategerytableView) { // 👈类别表格
        return self.categerys.count;
    } else { // 👉用户表格
        MyCategery *category = self.categerys[self.CategerytableView.indexPathForSelectedRow.row];
        return category.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.CategerytableView) { // 👈类别表格
        MyCategeryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        MyCategery *categery = self.categerys[indexPath.row];
        
        cell.categery = categery;
        return cell;
        
    } else {
        
        MyFriendUserCell *usercell = [tableView dequeueReusableCellWithIdentifier:userID];
        MyCategery *category = self.categerys[self.CategerytableView.indexPathForSelectedRow.row];
        
        usercell.friendUser = category.users[indexPath.row];
        
        return usercell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.CategerytableView) { // 👈类别表格
        MyCategery *category = selectCategory;
        if (category.users.count == 0) { // 被选中的表格没有任何用户数据
            
            [self.UsertableView.header beginRefreshing]; // 右边表格进入下拉刷新状态
        }
        // 刷新右边表格
        [self.UsertableView reloadData];
        
        // 控制footer的显示和隐藏
        if(category.users.count == category.total) {
            self.UsertableView.footer.hidden = YES;
        }
        
    } else {
        NSLog(@"select user table");
    }
}

@end
