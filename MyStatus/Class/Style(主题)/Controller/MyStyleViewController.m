//
//  MyStyleViewController.m
//  MyStatus
//
//  Created by NengQuan on 15/10/31.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyStyleViewController.h"
#import "SkinTool.h"
#import "UIImage+Image.h"
#import "MyAllViewController.h"
#import "MyNavigationViewController.h"
#import "REFrostedViewController.h"
#import "UIView+Extension.h"

@interface MyStyleViewController ()
@property (weak, nonatomic) IBOutlet UIView *choseStyleView;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@property (nonatomic,weak) UIImageView *picview;

@end

@implementation MyStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = MyGlobalBg;
    self.navigationItem.title = @"主题更换";
    
    UIButton *rightbutton = [[UIButton alloc]init];
    [rightbutton setTitle:@"确定" forState:UIControlStateNormal];
    [rightbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightbutton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:0.6 alpha:0.3]] forState:UIControlStateHighlighted];
    [rightbutton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    rightbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightbutton sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    
  
}

- (void)btnClick
{
    MyAllViewController *vc = [[MyAllViewController alloc]init];
    MyNavigationViewController *nav = [[MyNavigationViewController alloc]initWithRootViewController:vc];
    
    self.frostedViewController.contentViewController = nav;
    
    [self.frostedViewController hideMenuViewController];
}



- (IBAction)SwitchToblack {
    [SkinTool setSkinColor:@"black"];
    NSString *color = @"black";

    [[NSNotificationCenter defaultCenter] postNotificationName:@"handelblack" object:nil userInfo:@{@"color":color}];
    
    self.imageview.image = [UIImage imageNamed:@"black-1"];
    
    CATransition *anima = [CATransition animation];
    anima.type = @"fade";
    anima.duration = 0.25;
    [_imageview.layer addAnimation:anima forKey:nil];
    

}

- (IBAction)SwitchTored:(id)sender {
    [SkinTool setSkinColor:@"red"];
    
    NSString *color = @"red";
    
    self.imageview.image = [UIImage imageNamed:@"red-1"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"handelred" object:nil userInfo:@{@"color":color}];
    
    CATransition *anima = [CATransition animation];
    anima.type = @"fade";
    anima.duration = 0.25;
    [_imageview.layer addAnimation:anima forKey:nil];
    
}
- (IBAction)SwitchToblue:(id)sender {
    [SkinTool setSkinColor:@"blue"];
    
    NSString *color = @"blue";
    
    self.imageview.image = [UIImage imageNamed:@"blue-1"];
    CATransition *anima = [CATransition animation];
    anima.type = @"fade";
    anima.duration = 0.25;
    [_imageview.layer addAnimation:anima forKey:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"handelblue" object:nil userInfo:@{@"color":color}];
}



@end
