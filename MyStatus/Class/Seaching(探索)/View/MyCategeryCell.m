//
//  MyCategeryCell.m
//  MyStatus
//
//  Created by NengQuan on 15/10/29.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyCategeryCell.h"
#import "MyCategery.h"

@interface MyCategeryCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *blackView;

@end
@implementation MyCategeryCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = MyColor(252, 252, 252);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) { // 选中状态
        
        self.blackView.hidden = NO;
        self.nameLabel.textColor = MyColor(6, 58, 121);
    } else { // 取消状态
        
        self.nameLabel.textColor = [UIColor blackColor];
        self.blackView.hidden = YES;
    }

}

-(void)setCategery:(MyCategery *)categery
{
    _categery = categery;
    self.nameLabel.text = categery.name;
}

@end
