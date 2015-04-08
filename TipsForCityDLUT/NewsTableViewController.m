//
//  NewsTableViewController.m
//  TipsForCityDLUT
//
//  Created by 胡啸晨 on 15/4/3.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsFetcher.h"
#import "NewsWebViewController.h"

#define holiday @"放假"

@interface NewsTableViewController ()

@end

@implementation NewsTableViewController

- (void)setNews:(NSArray *)news
{
    _news = news;
    
    if (self.refresh.refreshing) {
        [self.refresh endRefreshing];
    }
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"News Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    //configure the cell...
    NSDictionary *new = self.news[indexPath.row];
    NSString *newsTitle = [new valueForKeyPath:NEWS_TITLE];
    cell.textLabel.text = newsTitle;
    //放假嘛，当然要醒目   滚动时会出现红字错位，暂时注释掉
//    if ([newsTitle rangeOfString:holiday].location != NSNotFound) {
//        cell.textLabel.textColor = [UIColor redColor];
//    }
    if ([new valueForKeyPath:NEWS_CONTENT] != nil) {
        cell.detailTextLabel.text = [new valueForKeyPath:NEWS_CONTENT];
    }
    else
    {
        cell.detailTextLabel.text = nil;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Display News"]) {
                if ([segue.destinationViewController isKindOfClass:[NewsWebViewController class]]) {
                    NewsWebViewController *nwvc = (NewsWebViewController *)segue.destinationViewController;
                    nwvc.newsWebURL = [NSURL URLWithString:[self.news[indexPath.row] valueForKeyPath:NEWS_HREF]];
                    //nwvc.title = [NSString stringWithFormat:@"新闻资讯"];
                }
            }
        }
    }
}

@end
