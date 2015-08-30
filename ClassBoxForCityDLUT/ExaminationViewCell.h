//
//  ExaminationViewCell.h
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/6/1.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExaminationViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *category;
@property (nonatomic, strong) UILabel *examining_method;
@property (nonatomic, strong) UILabel *credit_hours;
@property (nonatomic, strong) UILabel *credit;
@property (nonatomic, strong) UILabel *average_gradesTitle;
@property (nonatomic, strong) UILabel *final_gradesTitle;
@property (nonatomic, strong) UILabel *general_gradesTitle;
@property (nonatomic, strong) UILabel *average_grades;
@property (nonatomic, strong) UILabel *final_grades;
@property (nonatomic, strong) UILabel *general_grades;

@end
