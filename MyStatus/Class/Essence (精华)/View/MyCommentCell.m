//
//  MyCommentCell.m
//  MyStatus
//
//  Created by NengQuan on 15/11/1.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyCommentCell.h"
#import "MyComment.h"
#import "MyUser.h"
#import "UIImageView+Extension.h"

@interface MyCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconVIew;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contenLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;

@end
@implementation MyCommentCell

- (void)awakeFromNib {
    // Initialization code
    self.imageView.autoresizingMask = UIViewAutoresizingNone;
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setComment:(MyComment *)comment
{
    _comment = comment;
    
    [self.iconVIew SetCircleimageWithUrl:comment.user.profile_image];
    self.nameLabel.text = comment.user.username;
    self.contenLabel.text = comment.content;
    self.likeCount.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    
    NSString *sexImage = [comment.user.sex isEqualToString:@"m"] ? @"Profile_manIcon" : @"Profile_womanIcon";
    self.sexView.image = [UIImage imageNamed:sexImage];
    
    [self layoutIfNeeded];
}


@end
