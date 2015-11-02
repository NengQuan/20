//
//  MyTopics.h
//  MyStatus
//
//  Created by NengQuan on 15/10/27.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    MyWordType = 29,
    MyPicType = 10,
    MyVoiceType = 31,
    MyVideoType = 41,
     MyAllType = 1
} MyTopicType;

@class MyComment;
@interface MyTopics : NSObject



/** 唯一标识 */
@property (nonatomic, copy) NSString *id;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像的URL */
@property (nonatomic, copy) NSString *profile_image;
/** 审核通过时间*/
@property (nonatomic, copy) NSString *created_at;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;

/** type 帖子的类型 **/
@property (nonatomic,assign) MyTopicType type;

/** height	string	图片或视频等其他的内容的高度 **/
@property (nonatomic,assign) CGFloat height;

/** width	string	视频或图片类型帖子的宽度 **/
@property (nonatomic,assign) CGFloat width;

/** 大图 **/
@property (nonatomic,strong) NSString *largeImage;

/** 中等图 **/
@property (nonatomic,strong) NSString *middleImage;

/** 小图 **/
@property (nonatomic,strong) NSString *smallImage;


/** 播放数量 */
@property (nonatomic, assign) NSInteger playcount;
/** 声音文件的长度 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频的地址 **/
@property (nonatomic,strong) NSString *voiceuri;
/** 视频文件的长度 */
@property (nonatomic, assign) NSInteger videotime;
/** 视频的地址 **/
@property (nonatomic,strong) NSString *videouri;


/** 最热评论(数组里面存放MyComment模型) */
@property (nonatomic, strong) MyComment *top_cmt;

/** 辅助模型 **/
@property (nonatomic,assign)CGFloat cellHeight;

@property (nonatomic,assign) CGRect centerFrame;

@property (nonatomic,assign,getter=isBigImage)BOOL BigImage;
@end
