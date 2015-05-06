//
//  ClassesCollectionView.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/6.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "ClassesCollectionView.h"
#import "ClassesCollectionViewLayout.h"
#import "ClassesDataSource.h"

@implementation ClassesCollectionView

- (void)layoutSubviews{
    ClassesCollectionViewLayout *layout = [[ClassesCollectionViewLayout alloc]init];
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    
    id collectionViewDataSource = [[ClassesDataSource alloc]init];
    collectionView.dataSource = collectionViewDataSource;
}

@end
