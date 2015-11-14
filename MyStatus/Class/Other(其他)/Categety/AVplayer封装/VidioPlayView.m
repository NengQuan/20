//
//  VidioPlayView.m
//  AVplayer
//
//  Created by NengQuan on 15/11/8.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "VidioPlayView.h"
#import "FullViewController.h"

@interface VidioPlayView ()

@property (weak, nonatomic) IBOutlet UIButton *playOrpausebtn;
@property (weak, nonatomic) IBOutlet UILabel *curenttimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totaltimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgimageview;
@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;

/** 播放器 **/
@property (nonatomic,strong) AVPlayer *player;

/** 播放器的layer **/
@property (nonatomic,weak) AVPlayerLayer *playerLayer;

/** playitem **/
@property (nonatomic,weak) AVPlayerItem *playerItem;

/** 记录当前是否显示工具条 **/
@property (nonatomic,assign) BOOL isShowToolView;

/** 工具栏显示和隐藏 **/
@property (nonatomic,strong) NSTimer *showTimer;

/** 定时器 **/
@property (nonatomic,strong) NSTimer *progressTimer;

/** 工具栏展示时间 **/
@property (nonatomic,assign) NSTimeInterval showTime;

/** 全屏控制器 **/
@property (nonatomic,strong) FullViewController *FullVc;
// 事件处理
- (IBAction)playOrPause:(UIButton *)sender;

- (IBAction)switchOrientation:(UIButton *)sender;
- (IBAction)touchdownSlider:(id)sender;

- (IBAction)valuechangeSlider:(id)sender;

- (IBAction)touchupinsideSlider:(id)sender;



@end
@implementation VidioPlayView

#pragma mark - 懒加载
- (FullViewController *)FullVc
{
    if (_FullVc == nil) {
        _FullVc = [[FullViewController alloc] init];
    }
    return _FullVc;
}

+ (instancetype)vidioPlayView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"VidioPlayView" owner:nil options:nil]lastObject];
}

- (void)awakeFromNib
{
    // 初始化player和layer
    self.player = [[AVPlayer alloc]init];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.bgimageview.layer addSublayer:self.playerLayer];
    
    // 设置工具栏内容
    self.toolView.alpha = 1;
    self.isShowToolView = NO;
    
    // 设置进度条的内容
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateNormal];
    
    // 设置按钮的状态
    self.playOrpausebtn.selected = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap:)];
    [self.bgimageview addGestureRecognizer:tap];
    
    UISwipeGestureRecognizer *swip1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipAction:)];
    [self.bgimageview addGestureRecognizer:swip1];
    
    UISwipeGestureRecognizer *swip2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipRIght:)];
    [self.bgimageview addGestureRecognizer:swip2];
}


- (void)SwipAction:(UISwipeGestureRecognizer *)sender
{
    [self swipeToRight:YES];
}

- (void)SwipRIght:(UISwipeGestureRecognizer *)sender

{
    [self swipeToRight:NO];
}
- (void)Tap:(UITapGestureRecognizer *)sender
{
   
    [self showToolView:!self.isShowToolView];
    
    if(self.isShowToolView) {
        
        [self addShowTimer];
    }
}

#pragma mark - 重新布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.playerLayer.frame = self.bounds;
}

#pragma mark - 观察者对应方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        if (AVPlayerItemStatusReadyToPlay == status) {
            [self removeProgressTimer];
            [self addProgressTimer];
        } else {
            [self removeProgressTimer];
        }
    }

}

#pragma mark - 设置播放的视频
- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
    
    NSURL *url = [NSURL URLWithString:urlString];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    self.playerItem = item;
    
    [self.player replaceCurrentItemWithPlayerItem:item];
    
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.player play];
}

/**
 *  暂停按钮的监听
 *
 *  @param sender 传入的按钮
 */
- (IBAction)playOrPause:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.player play];
        
        [self addProgressTimer];
    } else {
        [self.player pause];
        
        [self removeProgressTimer];
    }
}

#pragma mark - 切换屏幕方向
- (IBAction)switchOrientation:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    [self videoplayViewSwitchOrientation:sender.selected];
}

- (void)videoplayViewSwitchOrientation:(BOOL)isfull
{
    if (isfull) {
        [self.constrainerViewController presentViewController:self.FullVc animated:NO completion:^{
            [self.FullVc.view addSubview:self];
            self.center = self.FullVc.view.center;
            
            [UIView animateKeyframesWithDuration:.15 delay:0.0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
                self.frame = self.FullVc.view.bounds;
                
            } completion:nil];
        }];
    } else {
        [self.FullVc dismissViewControllerAnimated:NO completion:^{
            [self.constrainerViewController.view addSubview:self];
            
           self.frame =  CGRectMake(0, 0, self.constrainerViewController.view.bounds.size.width, self.constrainerViewController.view.bounds.size.width * 9 / 16);
        }];
    }
}

#pragma mark - 滚到条事件
- (IBAction)touchdownSlider:(id)sender {
    
    [self removeProgressTimer];
}

- (IBAction)valuechangeSlider:(id)sender {
    NSTimeInterval curentTime = CMTimeGetSeconds(self.playerItem.duration) * self.progressSlider.value;
    
    NSTimeInterval duration = CMTimeGetSeconds(self.playerItem.duration);
    
    self.curenttimeLabel.text = [self stringWithCurentTime:curentTime];
    self.totaltimeLabel.text = [self stringWithDuring:duration];
}

- (IBAction)touchupinsideSlider:(id)sender {
    
    [self addProgressTimer];
    
    NSTimeInterval curentTime = CMTimeGetSeconds(self.player.currentItem.duration) * self.progressSlider.value;
    [self.player seekToTime:CMTimeMakeWithSeconds(curentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];

}



- (void)swipeToRight:(BOOL)isRight
{
    // 获取当前播放时间
    NSTimeInterval curentTime = CMTimeGetSeconds(self.player.currentItem.currentTime);
    
    if (isRight) {
        curentTime += 10;
    } else {
        curentTime -= 10;
    }
    
    if (curentTime >= CMTimeGetSeconds(self.player.currentItem.duration)) {
        curentTime = CMTimeGetSeconds(self.player.currentItem.duration) - 1;
    } else if (curentTime <= 0) {
        curentTime = 0;
    }
    
    [self.player seekToTime:CMTimeMakeWithSeconds(curentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    
    [self updataProgressinfo];
}

- (void)showToolView:(BOOL)isShow
{
    [UIView animateWithDuration:.5 animations:^{
        
        self.toolView.alpha = !self.isShowToolView;
        self.isShowToolView = !self.isShowToolView;
    }];
}

#pragma mark - 定时器操作
- (void)addProgressTimer
{
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updataProgressinfo) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}

- (void)removeProgressTimer {
    [self.progressTimer invalidate];
    
    self.progressTimer = nil;
}

- (void)updataProgressinfo
{
    // 更新时间
    NSTimeInterval dutation = CMTimeGetSeconds(self.player.currentItem.duration);
    NSTimeInterval curenttime = CMTimeGetSeconds(self.player.currentTime);
    
    self.curenttimeLabel.text = [self stringWithCurentTime:curenttime];
    self.totaltimeLabel.text = [self stringWithDuring:dutation];
    
    self.progressSlider.value = curenttime / dutation;
}

- (void)addShowTimer
{
    self.showTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updataShowTime) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.showTimer forMode:NSRunLoopCommonModes];
}

- (void)removeShowTimer
{
    [self.showTimer invalidate];
    self.showTimer = nil;
}

- (void)updataShowTime
{
    self.showTime += 1;
    
    if (self.showTime > 10) {
        [self Tap:nil];
        [self removeShowTimer ];
        
        self.showTime = 0;
    }
}

- (NSString *)stringWithCurentTime:(NSTimeInterval)cutenttime
{
    NSInteger cMin = cutenttime / 60;
    NSInteger cSec = (NSInteger)cutenttime % 60;
    
    NSString *curentString = [NSString stringWithFormat:@"%02ld:%02ld",cMin,cSec];
    
    return  curentString;
}

- (NSString *)stringWithDuring:(NSTimeInterval)during
{
    NSInteger dMin = during / 60;
    NSInteger dSce = (NSInteger)during % 60;
    
    NSString *duringString = [NSString stringWithFormat:@"%02ld:%02ld",dMin,dSce];
    
    return duringString;
}

@end
