//
//  MyCommentViewController.m
//  MyStatus
//
//  Created by NengQuan on 15/11/1.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyCommentViewController.h"
#import "MyTopics.h"
#import "MyHTTPSessionManager.h"
#import "MyCommentCell.h"
#import <MJRefresh.h>
#import "MyComment.h"
#import "MyAllViewCell.h"
#import <MJExtension.h>
#import "UIView+Extension.h"


@interface MyCommentViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomH;



@property (nonatomic,strong) NSMutableArray *hotComments;
@property (nonatomic,strong) NSMutableArray<MyComment *> *latesComments;

@property (nonatomic,strong) MyHTTPSessionManager *manager;

@property (nonatomic,strong) id top_cmt;
@end

static NSString * const ID = @"comment";

@implementation MyCommentViewController


#pragma mark - 懒加载
-(MyHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [MyHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUpBace];
    [self setUptable];
    [self setUpheader];
}

- (void)setUpBace
{
    self.navigationItem.title = @"评论";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)setUptable
{
    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(MyNavBarbottom, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyCommentCell class]) bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.sectionHeaderHeight = 30;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(LoadNewComment)];
    [self.tableView.header beginRefreshing];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMoreComment)];
    
    
}

- (void)setUpheader
{
    if (self.topic.top_cmt) {
        self.top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        self.topic.cellHeight = 0;
    }
    
    UIView *headerView = [[UIView alloc]init];
    
    //把cell添加到头部控件中
    MyAllViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"MyAllViewCell" owner:self options:nil]lastObject];
    cell.topic = self.topic;
    
    cell.frame = CGRectMake(0, 0, MyScreen.size.width, self.topic.cellHeight);
    
    [headerView addSubview:cell];
    
    headerView.height = cell.height + 2 * Mymargin;

    
    self.tableView.tableHeaderView = headerView;
    
}

- (void)KeyboardFrameChange:(NSNotification *)note
{
    CGRect KeyboardF = [note.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    self.bottomH.constant = MyScreen.size.height - KeyboardF.origin.y;
    
    CGFloat duriing = [note.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    [UIView animateWithDuration:duriing animations:^{
        
        [self.view layoutIfNeeded];
    }];
    
}

#pragma mark - 加载数据
-(void)LoadNewComment
{
    // block中用弱指针
    __weak typeof(self) weakSelf = self;
    // 请求参数
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"dataList";
    parame[@"hot"] = @"1";
    parame[@"c"] = @"comment";
    parame[@"data_id"] = self.topic.id;
    
    
    [weakSelf.manager GET:MyUrl parameters:(parame) success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSArray class]]) { // 没有评论数据
            // 结束刷新
            [weakSelf.tableView.header endRefreshing];
            return;
        }
        //字典数组- 模型数组
        weakSelf.hotComments = [MyComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        weakSelf.latesComments = [MyComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        //刷新数据
        [self.tableView reloadData];
        
        // 隐藏刷新控件
        CGFloat total = [responseObject[@"total"] doubleValue];
        if (self.latesComments.count == total) {
            [self.tableView.header endRefreshing];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)LoadMoreComment
{
    // block中用弱指针
    __weak typeof(self) weakSelf = self;
    // 请求参数
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"dataList";
    parame[@"c"] = @"comment";
    parame[@"data_id"] = self.topic.id;
    parame[@"lastcid"] = self.latesComments.lastObject.id;
    
    
    [weakSelf.manager GET:MyUrl parameters:(parame) success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            weakSelf.tableView.footer.hidden = YES;
            [self.tableView.header endRefreshing];
            return ;
        }
        //字典数组- 模型数组
        
        NSArray *comment = [MyComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.latesComments addObjectsFromArray:comment];
        //刷新数据
        [self.tableView reloadData];
        
        // 隐藏刷新控件
        CGFloat total = [responseObject[@"total"] doubleValue];
        if (self.latesComments.count == total) {
            [self.tableView.header endRefreshing];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

#pragma mark - UITableViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.view endEditing:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotComments.count) return 2;
    if (self.latesComments.count) return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.hotComments.count && section == 0) return self.hotComments.count;
    
    return self.latesComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (self.hotComments.count && indexPath.section == 0) {
        cell.comment = self.hotComments[indexPath.row];
    } else {
        cell.comment = self.latesComments[indexPath.row];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 创建header
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = MyGlobalBg;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    [headerView addSubview:label];
    
    // 设置label
    label.x = 10;
    label.width = 100;
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor darkGrayColor];
    if (self.hotComments.count && section == 0) {
        //        label.text = @"   最热评论";
        label.text = @"最热评论";
    } else {
        //        label.text = @"   最新评论";
        label.text = @"最新评论";
    }
    
    return headerView;
}


@end
