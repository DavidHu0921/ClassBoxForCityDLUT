//
//  ExaminationViewCell.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/6/1.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "ExaminationViewCell.h"

@implementation ExaminationViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    CGFloat ScreenWidth = self.frame.size.width;
//    CGFloat ScreenHeight = self.frame.size.height;
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
        self.category = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, ScreenWidth/2, 30)];
        self.examining_method = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2, 30, ScreenWidth/2, 30)];
        self.credit_hours = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, ScreenWidth/2, 30)];
        self.credit = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2, 60, ScreenWidth/2, 30)];
        self.average_gradesTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,  90, ScreenWidth/3, 30)];
        self.final_gradesTitle = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/3, 90, ScreenWidth/3, 30)];
        self.general_gradesTitle = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/3 * 2, 90, ScreenWidth/3, 30)];
        self.average_grades = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, ScreenWidth/3, 30)];
        self.final_grades = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/3, 120, ScreenWidth/3, 30)];
        self.general_grades = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/3 * 2, 120, ScreenWidth/3, 30)];
        
        [self addSubview:self.name];
        [self addSubview:self.category];
        [self addSubview:self.examining_method];
        [self addSubview:self.credit_hours];
        [self addSubview:self.credit];
        [self addSubview:self.average_gradesTitle];
        [self addSubview:self.final_gradesTitle];
        [self addSubview:self.general_gradesTitle];
        [self addSubview:self.average_grades];
        [self addSubview:self.final_grades];
        [self addSubview:self.general_grades];
    }
    return self;
}

@end
