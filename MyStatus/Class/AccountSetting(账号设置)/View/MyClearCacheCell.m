//
//  MyClearCacheCell.m
//  MyStatus
//
//  Created by NengQuan on 15/10/30.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyClearCacheCell.h"
#import "NSString+Filepath.h"
#import "NSString+FileSize.h"
#import <SVProgressHUD.h>

@implementation MyClearCacheCell

#define MyFilePath [@"default" pathCaches]

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        self.textLabel.textColor = [UIColor colorWithRed:99.0/255.0 green:99.0/255.0 blue:99.0/255.0 alpha:1];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 初始化文字
        self.textLabel.text = @"清除缓存";
        // 右边显示一个圈圈
        UIActivityIndicatorView *loadview = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.accessoryView = loadview;
        [loadview startAnimating];
        
        // 在子线程中计算缓存大小
        [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
            [NSThread sleepForTimeInterval:3.0];
            // 获取文件大小
            NSUInteger filesize = [MyFilePath filesize];
            // 单位
            double unit = 10000.0;
            NSString *text ;
            // 文字
            if (filesize > pow(unit, 3)) {
                text = [NSString stringWithFormat:@"%.2fGB",filesize / pow(unit, 3)];
            } else if (filesize > pow(unit, 2)) {
                text = [NSString stringWithFormat:@"%.2fMB",filesize / pow(unit, 2)];
            } else if (filesize > pow(unit, 1)) {
                text = [NSString stringWithFormat:@"%2.fKB",filesize / pow(unit, 1)];
            } else {
                text = [NSString stringWithFormat:@"%zdB",filesize];
            }
            
            // 回到主线程
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                // 设置标签文字
                self.textLabel.text = [NSString stringWithFormat:@"清除缓存(%@)",text];
                // 去掉圈圈
                self.accessoryView = nil;
                self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }];
            
        }];
        
        // 给cell添加轻击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClearCache)];
        [self addGestureRecognizer:tap];
        
        
    }
    return self;

}

/**
 *  清除缓存
 */
- (void)ClearCache
{
    
    [SVProgressHUD showInfoWithStatus:@"正在清理中..."];
    
    [[[NSOperationQueue alloc]init] addOperationWithBlock:^{
        // 清除缓存
        NSFileManager *mgr = [NSFileManager defaultManager];
        [mgr removeItemAtPath:MyFilePath error:nil];
        
        [NSThread sleepForTimeInterval:2.0];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [SVProgressHUD dismiss];
            // 修改文字
            self.textLabel.text = [NSString stringWithFormat:@"清除缓存(%zdB)",[MyFilePath filesize]];
            
        }];
        
    }];
    
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 当cell离开屏幕时, UIActivityIndicatorView的动画就会被自动停止
    
    // 当cell重新显示到屏幕上时, 应该重新开始UIActivityIndicatorView的动画
    UIActivityIndicatorView *loadview = (UIActivityIndicatorView *)self.accessoryView;
    [loadview startAnimating];
    
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.y += Mymargin / 2;
    frame.size.height -= Mymargin  /2;
    frame.size.width -= 10;
    frame.origin.x += 5;
    
    [super setFrame:frame];
}


@end
