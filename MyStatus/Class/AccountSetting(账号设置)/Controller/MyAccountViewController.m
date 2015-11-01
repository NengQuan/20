//
//  MyAccountViewController.m
//  MyStatus
//
//  Created by NengQuan on 15/10/29.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyAccountViewController.h"
#import "UIImage+Image.h"
#import "UIImage+CutCircle.h"
#import "MyCommentGroup.h"
#import "MyCommentItem.h"
#import "MyAccountCell.h"
#import "UIBarButtonItem+Extension.h"
#import "MyMenuViewController.h"
#import "MyNavigationViewController.h"
#import "MyClearCacheCell.h"
#import "MyAbout20ViewController.h"
#import "REFrostedViewController.h"

#define HeadH 200
#define TabarH 44

@interface MyAccountViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headViewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headVIewY;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIImageView *iconview;

@property (nonatomic,assign) CGFloat offsetY;

@property (nonatomic,weak) UILabel *titleLabel;

@property (nonatomic,strong) NSMutableArray *groups;

@end

@implementation MyAccountViewController

static NSString  * const ID = @"cell";
static NSString  * const cacheID = @"clear";
- (NSMutableArray *)groups
{
    if (_groups == nil){
        self.groups = [NSMutableArray array];
    }
    return _groups;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _offsetY = - (HeadH );
    
    self.tableview.contentInset = UIEdgeInsetsMake(HeadH  , 0, 0, 0);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableview.backgroundColor = MyColorA(0, 0, 0, 240);
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[MyAccountCell class] forCellReuseIdentifier:ID];
    [self.tableview registerClass:[MyClearCacheCell class] forCellReuseIdentifier:cacheID];
    self.tableview.backgroundColor = MyGlobalBg;
    self.tableview.rowHeight = 50;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"nav_list_height" Heightimage:@"nav_list_height" target:(MyNavigationViewController *)self.navigationController action:@selector(showMenu)];
    
    self.iconview.layer.cornerRadius = 50;
    self.iconview.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconview.layer.borderWidth = 3.0;
    self.iconview.layer.masksToBounds = YES;
    
    [self setUpnav];
    
    [self setUpgroup];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self setUpnav];
    
    self.titleLabel.textColor = [UIColor colorWithWhite:0 alpha:0];
    
}

- (void)setUpgroup
{
    [self setUpgroup0];
}

- (void)setUpgroup0
{
    MyCommentGroup *group = [MyCommentGroup group];
    [self.groups addObject:group];
    
    MyCommentItem *account = [MyCommentItem itemWithTitle:@"账号" icon:@"tabbar_home"];
    
    MyCommentItem *clearCache = [MyCommentItem itemWithTitle:@"清除缓存" icon:@"tabbar_home"];
    
    MyCommentItem *aboutme = [MyCommentItem itemWithTitle:@"关于20" icon:@"tabbar_home"];
    aboutme.destVCclass = [MyAbout20ViewController class];
    
    group.items = @[clearCache,account,aboutme];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MyCommentGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [tableView dequeueReusableCellWithIdentifier:cacheID];
    } else {
        MyAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        MyCommentGroup *group = self.groups[indexPath.section];
        MyCommentItem *item = group.items[indexPath.row];
        cell.item = item;
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出模型数据
    MyCommentGroup *group = self.groups[indexPath.section];
    MyCommentItem *item = group.items[indexPath.row];
    
    // 判断是否有目标控制器
    if (item.destVCclass) {
        UIViewController *destVC = [[item.destVCclass alloc]init];
        
//        MyAccountViewController *accoutVC = [[MyAccountViewController alloc]init];
//        MyNavigationViewController *nav = [[MyNavigationViewController alloc]initWithRootViewController:accoutVC];
        [self.navigationController pushViewController:destVC animated:YES];
        
//        self.frostedViewController.contentViewController = nav;
        
    }
    // 隐藏菜单
    [self.frostedViewController hideMenuViewController];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.titleLabel.textColor = [UIColor colorWithWhite:0 alpha:1];
    
    // 获取当前最新偏移量
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 计算下最新偏移量和最初偏移量的差值
    // 就是用户滚动的区域
    CGFloat delta = offsetY - _offsetY;

    CGFloat height = HeadH - delta;
   
    if (height <= 64) {
       height = 64;
    }
    self.headViewH.constant = height;
    
    CGFloat alpha = delta / (HeadH - 64);
    
    if (alpha > 1) {
        alpha = 0.90;
    }
    // 设置标题的文字颜色
    self.titleLabel.alpha = alpha;

    // 设置导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]] forBarMetrics:UIBarMetricsDefault];

}

- (void)setUpnav
{
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.text = @"账号设置";
    [titlelabel sizeToFit];
    self.titleLabel = titlelabel;
    self.navigationItem.titleView = titlelabel;
    titlelabel.alpha = 0;
    

    
}


@end
