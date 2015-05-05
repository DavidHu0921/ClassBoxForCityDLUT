//
//  ClassCalendarDataSource.h
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/2.
//  Copyright (c) 2015年 DavidHu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClassesCollectionViewCell.h"
#import "WeekReuse.h"

//typedef void (^ConfigureCellBlock)(ClassesCollectionViewCell *cell, NSIndexPath *indexPath, id<CalendarEvent> event);
typedef void (^ConfigureWeekViewBlock)(WeekReuse *weekReuseView, NSString *kind, NSIndexPath *indexPath);

@interface ClassCalendarDataSource : NSObject <UICollectionViewDataSource>

//@property (copy, nonatomic) ConfigureCellBlock configureCellBlock;
@property (copy, nonatomic) ConfigureWeekViewBlock configureWeekViewBlock;

//- (id<CalendarEvent>)eventAtIndexPath:(NSIndexPath *)indexPath;
//- (NSArray *)indexPathsOfEventsBetweenMinDayIndex:(NSInteger)minDayIndex maxDayIndex:(NSInteger)maxDayIndex minStartHour:(NSInteger)minStartHour maxStartHour:(NSInteger)maxStartHour;

@end
