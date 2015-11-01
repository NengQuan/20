//
//  MyAllVoiceView.m
//  MyStatus
//
//  Created by NengQuan on 15/10/28.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyAllVoiceView.h"
#import "MyTopics.h"
#import <UIImageView+WebCache.h>


@interface MyAllVoiceView ()
@property (weak, nonatomic) IBOutlet UILabel *countLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
@implementation MyAllVoiceView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.countLable.backgroundColor = MyColorA(0, 0, 0, 180);
    self.timeLabel.backgroundColor = MyColorA(0, 0, 0, 180);
}
- (void)setTopics:(MyTopics *)topics
{
    [super setTopics:topics];
    
    // 显示图片
    [_iconview sd_setImageWithURL:[NSURL URLWithString:topics.largeImage]];
    
    self.countLable.text = [NSString stringWithFormat:@"%zd次播放",topics.playcount];
    NSInteger minute = topics.voicetime / 60;
    NSInteger second = topics.voicetime % 60;
    self.timeLabel.text = [NSString stringWithFormat:@"%zd:%zd",minute,second];
    
    
}

@end
