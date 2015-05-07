//
//  ClassesDelegateFlowLayout.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/7.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "ClassesDelegateFlowLayout.h"

static const CGFloat ClassesHieght = 50;

@implementation ClassesDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 ) {
        return CGSizeMake(25, ClassesHieght);
    }
    else{
        return CGSizeMake((collectionView.frame.size.width - 25)/7, 50);
    }
}

@end
