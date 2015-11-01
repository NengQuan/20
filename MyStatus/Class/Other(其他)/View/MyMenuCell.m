//
//  MyMenuCell.m
//  MyStatus
//
//  Created by NengQuan on 15/10/20.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyMenuCell.h"
#import "MyCommentItem.h"
#import "UIView+Extension.h"
#import "SkinTool.h"
#import "MyStyleViewController.h"


@interface MyMenuCell ()<MyStyleViewControllerDelegate>

@end
@implementation MyMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        // 设置cell的背景颜色和字体颜色
        self.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor colorWithRed:99.0/255.0 green:99.0/255.0 blue:99.0/255.0 alpha:1];
    }
    return  self;
}


- (void)setItem:(MyCommentItem *)item
{
    _item = item;

    [[NSNotificationCenter defaultCenter] addObserverForName:@"handelred" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [SkinTool setSkinColor:note.userInfo[@"color"]];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"handelblack" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [SkinTool setSkinColor:note.userInfo[@"color"]];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"handelblue" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [SkinTool setSkinColor:note.userInfo[@"color"]];
    }];
    
    
    self.imageView.image = [SkinTool skinToolWithName:item.icon];
    self.textLabel.text = item.title;
}

// textlabel的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.x = self.imageView.right + 22;
}
@end
