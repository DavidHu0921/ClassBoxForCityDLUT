//
//  NewsTableViewController.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/4/3.
//  Copyright (c) 2015年 DavidHu All rights reserved.
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
    NSArray* reversedArray = [[news reverseObjectEnumerator] allObjects];
    _news = reversedArray;
    
    if (self.refresh.refreshing) {
        //NSLog(@"end");
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
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
//  放假嘛，当然要醒目   滚动时会出现红字错位，暂时注释掉
//    if ([newsTitle rangeOfString:holiday].location != NSNotFound) {
//        cell.textLabel.textColor = [UIColor redColor];
//    }
//    if ([new valueForKeyPath:NEWS_CONTENT] != nil) {
//        cell.detailTextLabel.text = [new valueForKeyPath:NEWS_CONTENT];
//    }
//    else
//    {
        cell.detailTextLabel.text = nil;
//    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *new = self.news[indexPath.row];
    NSString *cellText = [new valueForKeyPath:NEWS_TITLE];
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:16.0];
    
    NSAttributedString *attributedText =
    [[NSAttributedString alloc] initWithString:cellText attributes:@{
                                                                     NSFontAttributeName: cellFont
                                                                     }];
    
    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(tableView.bounds.size.width - 55, CGFLOAT_MAX)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    return rect.size.height + 20;
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
                }
            }
        }
    }
}

@end
