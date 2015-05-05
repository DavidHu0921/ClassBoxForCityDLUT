//
//  ClassCalendarDataSource.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/2.
//  Copyright (c) 2015年 DavidHu All rights reserved.
//

#import "ClassCalendarDataSource.h"

@interface ClassCalendarDataSource ()

@property (strong, nonatomic) NSMutableArray *classes;

@end

@implementation ClassCalendarDataSource

- (void)awakeFromNib{
    _classes = [[NSMutableArray alloc]init];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    id<CalendarEvent> event = self.events[indexPath.item];
//    CalendarEventCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalendarEventCell" forIndexPath:indexPath];
//    
//    if (self.configureCellBlock) {
//        self.configureCellBlock(cell, indexPath, event);
//    }
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    WeekReuse *weekReuseView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"WeekReuse" forIndexPath:indexPath];
    if (self.configureWeekViewBlock) {
        self.configureWeekViewBlock(weekReuseView, kind, indexPath);
    }
    return weekReuseView;
}


@end
