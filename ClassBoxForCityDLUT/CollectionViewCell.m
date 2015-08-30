//
//  CollectionViewCell.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/27.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - 30, 15, 60, 60)];
        self.logoTitle = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - 40, 80, 80, 30)];

        [self.contentView addSubview:self.logoImage];
        [self.contentView addSubview:self.logoTitle];
    }
    return self;
}

@end
