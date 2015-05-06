//
//  ClassesCollectionViewLayout.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/6.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "ClassesCollectionViewLayout.h"

static const CGFloat ClassesHeight = 50;
static const CGFloat NumberOfClasses = 12;

@implementation ClassesCollectionViewLayout

- (CGSize)collectionViewContentSize
{
    // Don't scroll horizontally
    CGFloat contentWidth = self.collectionView.bounds.size.width;
    
    // Scroll vertically to display a full day
    CGFloat contentHeight = ClassesHeight * NumberOfClasses;
    
    CGSize contentSize = CGSizeMake(contentWidth, contentHeight);
    return contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    
    
    
    return layoutAttributes;
}

@end
