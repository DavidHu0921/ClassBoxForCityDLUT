//
//  ClassCalendarViewLayout.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/2.
//  Copyright (c) 2015年 DavidHu All rights reserved.
//

#import "ClassCalendarViewLayout.h"
#import "ClassCalendarDataSource.h"

static const NSUInteger DaysPerWeek = 7;
static const NSUInteger ClassesPerDay = 12;
static const CGFloat HeightPerClass = 50;
static const CGFloat WeekHeight = 20;
static const CGFloat ClassesHeaderWidth = 30;

@implementation ClassCalendarViewLayout

- (CGSize)collectionViewContentSize
{
    // Don't scroll horizontally
    CGFloat contentWidth = self.collectionView.bounds.size.width;
    
    // Scroll vertically to display a full day
    CGFloat contentHeight = WeekHeight + (HeightPerClass * ClassesPerDay);
    
    CGSize contentSize = CGSizeMake(contentWidth, contentHeight);
    return contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    //week views
    NSArray *weekViewIndexPaths = [self indexPathsOfweekViewsInRect:rect];
    for (NSIndexPath *indexPath in weekViewIndexPaths) {
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForDecorationViewOfKind:@"WeekReuse" atIndexPath:indexPath];
        [layoutAttributes addObject:attribute];
    }
    
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind withIndexPath:indexPath];
    
    CGFloat totalWidth = [self collectionViewContentSize].width;
    if ([kind isEqualToString:@"WeekReuse"]) {
        CGFloat availableWidth = totalWidth - ClassesHeaderWidth;
        CGFloat widthPerDay = availableWidth / DaysPerWeek;
        attributes.frame = CGRectMake(ClassesHeaderWidth + (widthPerDay * indexPath.item), 0, widthPerDay, WeekHeight);
        attributes.zIndex = -10;
    }
//    } else if ([kind isEqualToString:@"HourHeaderView"]) {
//        attributes.frame = CGRectMake(0, DayHeaderHeight + HeightPerHour * indexPath.item, totalWidth, HeightPerHour);
//        attributes.zIndex = -10;
//    }
    return attributes;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

#pragma mark - Helpers

- (NSInteger)weekIndexFromXCoordinate:(CGFloat)xPosition
{
    CGFloat contentWidth = [self collectionViewContentSize].width - ClassesHeaderWidth;
    CGFloat widthPerDay = contentWidth / DaysPerWeek;
    NSInteger dayIndex = MAX((NSInteger)0, (NSInteger)((xPosition - ClassesHeaderWidth) / widthPerDay));
    return dayIndex;
}

- (NSArray *)indexPathsOfweekViewsInRect:(CGRect)rect
{
    if (CGRectGetMinY(rect) > WeekHeight) {
        return [NSArray array];
    }
    
    NSInteger minDayIndex = [self weekIndexFromXCoordinate:CGRectGetMinX(rect)];
    NSInteger maxDayIndex = [self weekIndexFromXCoordinate:CGRectGetMaxX(rect)];
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSInteger idx = minDayIndex; idx <= maxDayIndex; idx++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}

@end
