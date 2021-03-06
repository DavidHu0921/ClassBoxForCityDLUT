//
//  WeekView.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/6.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "WeekView.h"

@implementation WeekView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews{
    UILabel *blink = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 25, 20)];
    blink.text = [NSString stringWithFormat:@""];
    blink.font = [UIFont systemFontOfSize:12];
    blink.textAlignment = NSTextAlignmentCenter;
    blink.textColor = [UIColor blackColor];
    [self addSubview:blink];
    
    NSArray *weekDay = [NSArray arrayWithObjects:@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日", nil];
    
    for (int i = 0; i<7; i++) {
        UILabel *week = [[UILabel alloc]initWithFrame:CGRectMake(25 + i*(self.frame.size.width - 25)/7, 0, (self.frame.size.width - 25)/7, 20)];
        week.text = [weekDay objectAtIndex:i];
        week.font = [UIFont systemFontOfSize:12];
        week.textAlignment = NSTextAlignmentCenter;
        week.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"weekDayBGI"]];
        week.textColor = [UIColor blackColor];
        [self addSubview:week];
    }
}

@end
