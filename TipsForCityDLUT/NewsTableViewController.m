//
//  NewsTableViewController.m
//  TipsForCityDLUT
//
//  Created by 胡啸晨 on 15/4/3.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "NewsTableViewController.h"

@implementation NewsTableViewController

- (void)setNews:(NSArray *)news
{
    _news = news;
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:@"News and Reports" forIndexPath:indexPath];
    
    
    
    return nil;
}

@end
