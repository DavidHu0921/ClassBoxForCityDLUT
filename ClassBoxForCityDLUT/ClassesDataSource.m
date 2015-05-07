//
//  ClassesDataSource.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/7.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "ClassesDataSource.h"

@implementation ClassesDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}
@end
