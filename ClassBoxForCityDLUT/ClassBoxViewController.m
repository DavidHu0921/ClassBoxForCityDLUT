//
//  ClassBoxViewController.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/4/24.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "ClassBoxViewController.h"
#import "DrawWeekViewController.h"

@interface ClassBoxViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *monthView;
@property (weak, nonatomic) IBOutlet UICollectionView *weekView;

@end

@implementation ClassBoxViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //todo sth
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self drawView];
}

- (void)drawView{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    NSLog(@"%f", screenWidth);
    [self.weekView numberOfItemsInSection:1];
}



@end
