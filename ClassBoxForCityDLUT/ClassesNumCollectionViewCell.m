//
//  ClassesNumCollectionViewCell.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/8.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "ClassesNumCollectionViewCell.h"

@implementation ClassesNumCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.classedNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.contentView addSubview:self.classedNum];
    }
    return self;
}
@end
