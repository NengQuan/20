//
//  textViewController.m
//  MyStatus
//
//  Created by NengQuan on 15/10/20.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "textViewController.h"
#import "MyNavigationViewController.h"

@interface textViewController ()

@end

@implementation textViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    [super viewDidLoad];
    self.title = @"Second Controller";
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:(MyNavigationViewController *)self.navigationController
                                                                            action:@selector(showMenu)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
