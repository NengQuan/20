//
//  MyAllPictureView.m
//  MyStatus
//
//  Created by NengQuan on 15/10/28.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyAllPictureView.h"
#import "UIImageView+WebCache.h"
#import "MyTopics.h"
#import <DALabeledCircularProgressView.h>
#import "MySeeBigViewController.h"


@interface MyAllPictureView ()


@property (weak, nonatomic) IBOutlet UIImageView *gifimage;
@property (weak, nonatomic) IBOutlet UIButton *checkBigtbutton;

@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *placeHolderView;
@end

@implementation MyAllPictureView


- (void)awakeFromNib
{
    [super awakeFromNib];
    // 初始化
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor blackColor];
    self.progressView.progressTintColor = MyColorA(0, 0, 0, 100);
}


- (void)setTopics:(MyTopics *)topics
{
    [super setTopics:topics];
    
    [_iconview sd_setImageWithURL:[NSURL URLWithString:topics.largeImage]];
    [_iconview sd_setImageWithURL:[NSURL URLWithString:topics.largeImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        self.placeHolderView.hidden = NO;
        
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progress = progress;
        NSString *progressText = [NSString stringWithFormat:@"%.0f%%",progress * 100.0];
        self.progressView.progressLabel.text = progressText;
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.placeHolderView.hidden = YES;
        self.progressView.hidden = YES;
        
    } ];
    
    // 是否为gif
    NSString *extension = [topics.largeImage pathExtension].lowercaseString;
    
    if ([extension isEqualToString:@"gif"]) {
        self.gifimage.hidden = NO;
    } else {
        self.gifimage.hidden = YES;
    }
    
    // 查看大图
    if (topics.isBigImage) {
        self.checkBigtbutton.hidden = NO;
    } else {
        self.checkBigtbutton.hidden = YES;
    }

}
@end
