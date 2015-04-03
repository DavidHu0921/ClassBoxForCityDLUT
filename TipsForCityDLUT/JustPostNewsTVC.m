//
//  JustPostNewsTVC.m
//  TipsForCityDLUT
//
//  Created by 胡啸晨 on 15/4/3.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "JustPostNewsTVC.h"

@implementation JustPostNewsTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchNews];
}

- (void)fetchNews
{
    self.news = nil;
}

@end
