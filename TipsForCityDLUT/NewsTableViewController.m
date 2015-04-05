//
//  NewsTableViewController.m
//  TipsForCityDLUT
//
//  Created by 胡啸晨 on 15/4/3.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsFetcher.h"

@implementation NewsTableViewController

- (void)setNews:(NSArray *)news
{
    _news = news;
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"News Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell) {
        //configure the cell...
        NSDictionary *new = self.news[indexPath.row];
        NSLog(@"%@", new);
        cell.textLabel.text = [new valueForKeyPath:NEWS_TITLE];
        NSLog(@"%@", cell.textLabel.text);
        cell.detailTextLabel.text = [new valueForKeyPath:NEWS_CONTENT];
        NSLog(@"%@", cell.detailTextLabel.text);
    }
    else
    {
        NSLog(@"cell is null");
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.news count];
}

@end
