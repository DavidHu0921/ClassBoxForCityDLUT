//
//  DateView.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/6.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "DateView.h"

@implementation DateView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews{
    //获取当前日历信息
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger weekNumber =  [[calendar components: NSCalendarUnitWeekOfYear fromDate:now] weekOfYear];
    NSInteger todaysMonth =[[calendar components: NSCalendarUnitMonth fromDate:now] month];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [gregorian components:NSCalendarUnitYear | NSCalendarUnitWeekday fromDate:now];
    NSInteger thisWeekDay = [comp weekday];
    
    //判断当前是不是周日，是的话减一周
    if (thisWeekDay == 1) {
        [comp setWeekOfYear:weekNumber - 1];
    }
    else{
        [comp setWeekOfYear:weekNumber];  //Week number.
    }
    
    NSInteger monthNum, dayNum;
    
    for (int i = 0; i < 8; i=i+1){
        if (i == 0) {
            //这里把第一格设置成当前月份
            UILabel *week = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 25, 20)];
            week.text = [NSString stringWithFormat:@"%ld月", (long)todaysMonth];
            week.font = [UIFont systemFontOfSize:12];
            week.textAlignment = NSTextAlignmentCenter;
            week.textColor = [UIColor blackColor];
            [self addSubview:week];
        }
        else if (i != 7) {
            //这里设置所有的日期，并且判断在日期等于1的时候直接表示月份
            [comp setWeekday:i + 1]; //First day of the week. Change it to 7 to get the last date of the week
            NSDate *resultDate = [gregorian dateFromComponents:comp];
            
            NSCalendar *newCalendar = [NSCalendar currentCalendar];
            NSDateComponents *newComp = [newCalendar components:NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:resultDate];
            
            monthNum = [newComp month];
            dayNum   = [newComp day];
            NSInteger wDay = [newComp weekday];
            
            UILabel *week = [[UILabel alloc]initWithFrame:CGRectMake(25 + (i - 1)*(self.frame.size.width - 25)/7, 0, (self.frame.size.width - 25)/7, 20)];
            if (dayNum == 1 && wDay != 2) {
                week.text = [NSString stringWithFormat:@"%ld月", (long)monthNum];
            }
            else{
                week.text = [NSString stringWithFormat:@"%ld", (long)dayNum];
            }
            
            week.font = [UIFont systemFontOfSize:12];
            week.textAlignment = NSTextAlignmentCenter;
            week.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"weekDayBGI"]];
            week.textColor = [UIColor blackColor];
            [self addSubview:week];
        }
        else{
            //这里把所有的周日移到最后，因为系统日历以周日为一周的开始，而学校日历以周一为一周的开始
            
            //判断当前是不是周日，不是的话就要加一周
            if (thisWeekDay == 1) {
                [comp setWeekOfYear:weekNumber];
            }
            else{
                [comp setWeekOfYear:weekNumber + 1];
            }
            
            [comp setWeekday:1]; //First day of the week. Change it to 7 to get the last date of the week
            
            NSDate *resultDate = [gregorian dateFromComponents:comp];
            
            NSCalendar *newCalendar = [NSCalendar currentCalendar];
            NSDateComponents *newComp = [newCalendar components:NSCalendarUnitMonth | NSCalendarUnitDay fromDate:resultDate];
            
            monthNum = [newComp month];
            dayNum   = [newComp day];
            
            UILabel *week = [[UILabel alloc]initWithFrame:CGRectMake(25 + (i - 1)*(self.frame.size.width - 25)/7, 0, (self.frame.size.width - 25)/7, 20)];
            if (dayNum == 1) {
                week.text = [NSString stringWithFormat:@"%ld月", (long)monthNum];
            }
            else{
                week.text = [NSString stringWithFormat:@"%ld", (long)dayNum];
            }
            
            week.font = [UIFont systemFontOfSize:12];
            week.textAlignment = NSTextAlignmentCenter;
            week.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"weekDayBGI"]];
            week.textColor = [UIColor blackColor];
            [self addSubview:week];
        }
    }
}


@end
