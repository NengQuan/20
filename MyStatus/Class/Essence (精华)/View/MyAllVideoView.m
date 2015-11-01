//
//  MyAllVideoView.m
//  MyStatus
//
//  Created by NengQuan on 15/10/28.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyAllVideoView.h"
#import "MyTopics.h"
#import <UIImageView+WebCache.h>

@interface MyAllVideoView ()

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
@implementation MyAllVideoView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.countLabel.backgroundColor = MyColorA(0, 0, 0, 180);
    self.timeLabel.backgroundColor = MyColorA(0, 0, 0, 180);
}

- (void)setTopics:(MyTopics *)topics
{
    [super setTopics:topics];
    
    // 显示图片
    [_iconview sd_setImageWithURL:[NSURL URLWithString:topics.largeImage]];
    self.countLabel.text = [NSString stringWithFormat:@"%zd次播放",topics.playcount];
    NSInteger minute = topics.videotime / 60;
    NSInteger second = topics.videotime % 60;
    self.timeLabel.text = [NSString stringWithFormat:@"%zd:%zd",minute,second];
    
}

@end
