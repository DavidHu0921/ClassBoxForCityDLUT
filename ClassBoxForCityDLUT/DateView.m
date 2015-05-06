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
    
//    for (int i = 0; i<7; i++) {
//        UILabel *week = [[UILabel alloc]initWithFrame:CGRectMake(25 + i*(self.frame.size.width - 25)/7, 0, (self.frame.size.width - 25)/7, 20)];
//        week.text = [weekDay objectAtIndex:i];
//        //        [week setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"weekDayBGI"]]];
//        //背景加不上，暂时不知道为什么
//        week.font = [UIFont systemFontOfSize:14];
//        week.textAlignment = NSTextAlignmentCenter;
//        week.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"weekDayBGI"]];
//        week.textColor = [UIColor blackColor];
//        [self addSubview:week];
//    }
    
    
    //获取当前日历信息
//    NSCalendar *calender = [NSCalendar currentCalendar];
//    NSDateComponents *dateComponent = [calender components:(NSWeekOfYearCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit |  NSYearCalendarUnit | NSWeekdayCalendarUnit) fromDate:[NSDate date]];
//    NSLog(@"%@",dateComponent);
    
    NSInteger year,month,day,week,weekNum;
    NSString *weekStr=nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *now = [NSDate date];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitWeekOfYear;
    
    //test
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *testdate = [dateFormatter dateFromString:@"2015-05-01"];
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:testdate];
    year = [comps year];
    week = [comps weekday];
    month = [comps month];
    day = [comps day];
    weekNum = [comps weekOfYear];
    
    switch (week) {
        case 1:
            weekStr = @"星期天";
            break;
        case 2:
            weekStr = @"星期一";
            break;
        case 3:
            weekStr = @"星期二";
            break;
        case 4:
            weekStr = @"星期三";
            break;
        case 5:
            weekStr = @"星期四";
            break;
        case 6:
            weekStr = @"星期五";
            break;
        case 7:
            weekStr = @"星期六";
            break;
        default:
            NSLog(@"error!");
            break;
    }

    
    NSLog(@"现在是:%ld年%ld月%ld日 今年第%ld周  %@",year, month,day,weekNum,weekStr);
    
    NSInteger Monday = day - week+1+1;

    for (int i=1; i<=7; i++) {
        NSLog(@"本周 星期%d :%ld年%ld月%ld日 ",i,year,month, Monday);
        Monday+=1;
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
