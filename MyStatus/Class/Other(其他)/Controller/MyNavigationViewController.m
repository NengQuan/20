//
//  MyNavigationViewController.m
//  MyStatus
//
//  Created by NengQuan on 15/10/20.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyNavigationViewController.h"
#import "MyMenuViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "REFrostedViewController.h"
#import "UIView+Extension.h"

@interface MyNavigationViewController ()
@property (strong, readwrite, nonatomic) MyMenuViewController *menuViewController;
@end

@implementation MyNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
    
    self.interactivePopGestureRecognizer.delegate = nil;
}

- (void)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController panGestureRecognized:sender];
}

+ (void)initialize
{
    // 设置导航栏背景
    UINavigationBar *bar = [UINavigationBar appearance];
    
    UIImage *image = [UIImage imageNamed:@"111"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [bar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    bar.alpha = 0.8;
    // 设置title的字体
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:17];
 
    [bar setTitleTextAttributes:dict];
    

    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count > 0){
        
        // 设置导航栏左边按钮
        UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftbtn setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
        [leftbtn setImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
        [leftbtn sizeToFit];
        
        [leftbtn addTarget:self action:@selector(lebtnClick) forControlEvents:UIControlEventTouchUpInside];

        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftbtn];
        
    }
    [super pushViewController:viewController animated:YES];
}

// 推出当前控制器
-(void)lebtnClick
{
    [self popViewControllerAnimated:YES];
}

@end
