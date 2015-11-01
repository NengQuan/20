//
//  MyStyleViewController.m
//  MyStatus
//
//  Created by NengQuan on 15/10/31.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyStyleViewController.h"
#import "SkinTool.h"

@interface MyStyleViewController ()
@property (weak, nonatomic) IBOutlet UIView *choseStyleView;

@end

@implementation MyStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = MyGlobalBg;
  
}
- (IBAction)SwitchToblack {
    [SkinTool setSkinColor:@"black"];
    NSString *color = @"black";
    NSLog(@"%@",color);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"handelblack" object:nil userInfo:@{@"color":color}];
    
    if ([self.delegate respondsToSelector:@selector(styleView:didChoseColor:)]) {
        [self.delegate styleView:self didChoseColor:color];
    }
}

- (IBAction)SwitchTored:(id)sender {
    [SkinTool setSkinColor:@"red"];
    
    NSString *color = @"red";
    NSLog(@"red");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"handelred" object:nil userInfo:@{@"color":color}];
    
  
    
}
- (IBAction)SwitchToblue:(id)sender {
    [SkinTool setSkinColor:@"blue"];
    
    NSString *color = @"blue";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"handelblue" object:nil userInfo:@{@"color":color}];
}




@end
