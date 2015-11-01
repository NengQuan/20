//
//  MyTopicCenterView.m
//  MyStatus
//
//  Created by NengQuan on 15/10/28.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyTopicCenterView.h"
#import "MySeeBigViewController.h"
#import <VKVideoPlayerViewController.h>
#import "MyTopics.h"

@interface MyTopicCenterView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconview;

- (IBAction)Doplay:(id)sender;

@end
@implementation MyTopicCenterView

+ (instancetype)topicCenter
{
     return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}

- (void)awakeFromNib
{
    // 去除默认的autoresizingMask设置 （这个会导致设置的frame不匹配）
    self.autoresizingMask = UIViewAutoresizingNone;
    self.iconview.contentMode =  UIViewContentModeScaleAspectFill;
    self.iconview.clipsToBounds = YES;
    
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick)];
    self.iconview.userInteractionEnabled = YES;
    [self.iconview addGestureRecognizer:tap];

}

/**
 *  点击照片
 */
- (void)imageClick
{
    MySeeBigViewController *seeBig = [[MySeeBigViewController alloc] init];
    seeBig.topic = self.topics;
    [self.window.rootViewController presentViewController:seeBig animated:YES completion:nil];
}


- (IBAction)Doplay:(id)sender {
    
    VKVideoPlayerViewController *viewController = [[VKVideoPlayerViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:viewController animated:YES completion:nil];
    
    [viewController playVideoWithStreamURL:[NSURL URLWithString:self.topics.videouri]];
    [viewController playVideoWithStreamURL:[NSURL URLWithString:self.topics.voiceuri]];
}
@end
