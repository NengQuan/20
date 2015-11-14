//
//  VidioPlayView.h
//  AVplayer
//
//  Created by NengQuan on 15/11/8.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface VidioPlayView : UIView

/** 快速创建view **/
+(instancetype)vidioPlayView;

/** 视频的链接 **/
@property (nonatomic,copy) NSString *urlString;

/** 全屏控制器 **/
@property (nonatomic,weak) UIViewController *constrainerViewController;
@end
