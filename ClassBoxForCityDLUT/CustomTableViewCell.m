//
//  CustomTableViewCell.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/6/1.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //不知道为什么UITextView新建以后里面有两个UIImageView，怎么都去不掉，也不知道哪来的
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(self.frame.size.width - 70, self.frame.size.height/2 -18 + 2, 120, 36)];
        [self addSubview:self.textView];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
