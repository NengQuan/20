//
//  MyFriendUserCell.m
//  MyStatus
//
//  Created by NengQuan on 15/10/29.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyFriendUserCell.h"
#import "MyFriendUser.h"
#import "UIImageView+Extension.h"

@interface MyFriendUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;
@property (weak, nonatomic) IBOutlet UIButton *followButton;

@end
@implementation MyFriendUserCell


- (void)awakeFromNib {
    // Initialization code
    [self.followButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFriendUser:(MyFriendUser *)friendUser
{
    _friendUser = friendUser;
    
    [self.iconView SetCircleimageWithUrl:friendUser.header];
    self.nameLabel.text = friendUser.screen_name;
    self.fansLabel.text = [NSString stringWithFormat:@"%zd",friendUser.fans_count];
}

- (void)btnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    
}
@end
