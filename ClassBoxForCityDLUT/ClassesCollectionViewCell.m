//
//  ClassesCollectionViewCell.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/2.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ClassesCollectionViewCell.h"

@implementation ClassesCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    //这里要改变背景颜色，可以去掉边框
    self.layer.cornerRadius = 10;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0.7 alpha:1] CGColor];
}

@end
