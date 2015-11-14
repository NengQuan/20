//
//  MyAllViewCell.m
//  MyStatus
//
//  Created by NengQuan on 15/10/27.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyAllViewCell.h"
#import "MyTopics.h"
#import "UIImageView+Extension.h"
#import "MyComment.h"
#import "MyUser.h"
#import "MyAllPictureView.h"
#import "MyTopicCenterView.h"
#import "MyAllVideoView.h"
#import "MyAllVoiceView.h"


@interface MyAllViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconview;
@property (weak, nonatomic) IBOutlet UILabel *nameview;
@property (weak, nonatomic) IBOutlet UILabel *timeview;
@property (weak, nonatomic) IBOutlet UILabel *text_view;
@property (weak, nonatomic) IBOutlet UIButton *likebutton;
@property (weak, nonatomic) IBOutlet UIButton *commentbutton;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
- (IBAction)lickClick:(UIButton *)sender;

- (IBAction)commentClcik:(UIButton *)sender;

/** 图片控件 **/
@property (nonatomic,weak) MyAllPictureView *pictureView;

/** 视频控件 **/
@property (nonatomic,weak) MyAllVideoView *videoView;

/** 音频控件 **/
@property (nonatomic,weak) MyAllVoiceView *voiceView;

- (IBAction)MoreClick:(id)sender;


@end
@implementation MyAllViewCell


- (MyAllPictureView *)pictureView
{
    if (_pictureView == nil) {
        
       MyAllPictureView *picview = [MyAllPictureView topicCenter];
        _pictureView = picview;
        [self.contentView addSubview:picview];
    }
    return _pictureView;
}

- (MyAllVoiceView *)voiceView
{
    if (_voiceView == nil) {
        MyAllVoiceView *voiceview = [MyAllVoiceView topicCenter];
        _voiceView = voiceview;
        [self.contentView addSubview:voiceview];
    }
    return _voiceView;
}

- (MyAllVideoView *)videoView
{
    if (_videoView == nil) {
        MyAllVideoView *videoview = [MyAllVideoView topicCenter];
        _videoView = videoview;
        [self.contentView addSubview:videoview];
    }
    return _videoView;
}

- (void)awakeFromNib {
    
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTopic:(MyTopics *)topic
{
    _topic = topic;
    
    [self.iconview SetCircleimageWithUrl:topic.profile_image];
    self.nameview.text = topic.name;
    self.timeview.text = topic.created_at;
    self.text_view.text= topic.text;
    
    // 赞和评论
    self.likeLabel.text = [NSString stringWithFormat:@"%zd个赞 . %zd个评论",topic.ding,topic.comment];
    
    // 显示中间内容
    if (topic.type == MyPicType){ // 图片
        // 添加图片控件
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        
        self.pictureView.topics = topic;
        self.pictureView.frame = topic.centerFrame;
        
    } else if (topic.type == MyWordType) { // 文字
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        
    } else if (topic.type == MyVoiceType) { // 声音
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        
        self.voiceView.hidden = NO;
        self.voiceView.topics = topic;
        self.voiceView.frame = topic.centerFrame;
        
    } else if (topic.type == MyVideoType) { //视频
        
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = NO;
        
        self.videoView.frame = topic.centerFrame;
        self.videoView.topics = topic;

    }

}

- (IBAction)MoreClick:(id)sender {
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    
    // 添加按钮
    [alertVc addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"收藏");
    }]];
    
    [alertVc addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"举报");
    }]];
    
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }]];
    
    [self.window.rootViewController presentViewController:alertVc animated:YES completion:nil];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.y += Mymargin ;
    frame.size.height -= Mymargin ;
    
    [super setFrame:frame];
}
- (IBAction)lickClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)commentClcik:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(MyAllViewDidClick:)]) {
        [self.delegate MyAllViewDidClick:self];
    }
    
}
@end
