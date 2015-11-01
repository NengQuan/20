//
//  MyMenuViewController.m
//  MyStatus
//
//  Created by NengQuan on 15/10/20.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyMenuViewController.h"
#import "MyNavigationViewController.h"
#import "MyMenuCell.h"
#import "MyCommentGroup.h"
#import "MyCommentItem.h"
#import "MyNavigationViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "REFrostedViewController.h"
#import "MyAllViewController.h"
#import "MyPictureViewController.h"
#import "MyVideoViewController.h"
#import "MyVoiceViewController.h"
#import "MyWordViewController.h"
#import "MySearchViewController.h"
#import "MyAccountViewController.h"
#import "UIImage+REFrostedViewController.h"
#import "MyStyleViewController.h"

@interface MyMenuViewController ()<UITableViewDelegate,UITableViewDataSource,MyStyleViewControllerDelegate>

@property (nonatomic,strong) NSMutableArray *groups;

@end

@implementation MyMenuViewController


 static NSString * const ID = @"MING";

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化tableview
    [self setUpTableView];
    
    // 初始化组模型
    [self setUpGroup];
   
    [[NSNotificationCenter defaultCenter] addObserverForName:@"handelblack" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self.tableView reloadData];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"handelblue" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self.tableView reloadData];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"handelred" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self.tableView reloadData];
    }];
    
    
    }

- (void)setUpGroup
{
    [self setupGroup0];
    
    [self setupGroup1];
}

/**
 *  第0组模型
 */
- (void)setupGroup0
{
    [self.tableView reloadData];
    
    MyCommentGroup *group = [MyCommentGroup group];
    [self.groups addObject:group];
    
    UIImage *homepic = [UIImage imageNamed:@"dock_home"];
    MyCommentItem *home = [MyCommentItem itemWithTitle:@"首页" icon:@"dock_home"];
    home.destVCclass = [MyAllViewController class];
    
    MyCommentItem *search = [MyCommentItem itemWithTitle:@"探索" icon:@"dock_explore"];
    search.destVCclass = [MySearchViewController class];
    
    MyCommentItem *style = [MyCommentItem itemWithTitle:@"主题更换" icon:@"set_icn_skin"];
    MyStyleViewController *styleVC = [[MyStyleViewController alloc]init];
    styleVC.delegate = self;
    style.destVCclass = [styleVC class];

    
    MyCommentItem *me = [MyCommentItem itemWithTitle:@"账号设置" icon:@"dock_profile"];
    me.destVCclass = [MyAccountViewController class];
    group.items = @[home,search,style,me];
}



- (void)setupGroup1
{
    MyCommentGroup *group = [MyCommentGroup group];
    [self.groups addObject:group];
    
    group.header = @"分类浏览";
    
    MyCommentItem *picture = [MyCommentItem itemWithTitle:@"图片" icon:@"tabbar_home"];
    picture.destVCclass = [MyPictureViewController class];
    
    MyCommentItem *video = [MyCommentItem itemWithTitle:@"视频" icon:@"tabbar_message_center"];
    video.destVCclass = [MyVideoViewController class];
    
    MyCommentItem *voice = [MyCommentItem itemWithTitle:@"声音" icon:@"tabbar_message_center"];
    voice.destVCclass = [MyVoiceViewController class];
    
    MyCommentItem *word = [MyCommentItem itemWithTitle:@"段子" icon:@"tabbar_message_center"];
    word.destVCclass = [MyWordViewController class];
    
    group.items = @[picture,video,voice,word];
    
}

/**
 *  初始化tableview
 */
-(void)setUpTableView
{
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 260.0f)];
//        view.backgroundColor = [UIColor colorWithRed:25/255.0 green:123/255.0 blue:242/255.0 alpha:1];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, 100, 100)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"11.jpg"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 190, 0, 24)];
        label.text = @"Lin Yuner";
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
//        label.textColor = [UIColor whiteColor];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [view addSubview:imageView];
        [view addSubview:label];
        view;
    });
    
    [self.tableView registerClass:[MyMenuCell class] forCellReuseIdentifier:ID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MyCommentGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 传递模型数据
    MyCommentGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出模型数据
    MyCommentGroup *group = self.groups[indexPath.section];
    MyCommentItem *item = group.items[indexPath.row];
    
    // 判断是否有目标控制器
    if (item.destVCclass) {
        UIViewController *destVC = [[item.destVCclass alloc]init];
        
        MyNavigationViewController *nav = [[MyNavigationViewController alloc]initWithRootViewController:destVC];
       
        self.frostedViewController.contentViewController = nav;
       
    }
    // 隐藏菜单
    [self.frostedViewController hideMenuViewController];
    
}

#pragma mark - 代理方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    label.text = @"分类浏览";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 34;
}
@end
