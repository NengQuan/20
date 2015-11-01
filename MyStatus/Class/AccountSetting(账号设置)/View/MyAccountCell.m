//
//  MyAccountCell.m
//  MyStatus
//
//  Created by NengQuan on 15/10/30.
//  Copyright © 2015年 NengQuan. All rights reserved.
//

#import "MyAccountCell.h"
#import "MyCommentItem.h"

@implementation MyAccountCell

- (void)awakeFromNib {
    // Initialization code
    
   
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        self.textLabel.textColor = [UIColor colorWithRed:99.0/255.0 green:99.0/255.0 blue:99.0/255.0 alpha:1];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(MyCommentItem *)item
{
    _item = item;
    
    self.textLabel.text = item.title;
    self.imageView.image = [UIImage imageNamed:item.icon];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.y += Mymargin / 2;
    frame.size.height -= Mymargin  /2;
    frame.size.width -= 10;
    frame.origin.x += 5;
    
    [super setFrame:frame];
}

@end
