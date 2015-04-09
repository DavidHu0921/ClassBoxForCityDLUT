//
//  JustPostNewsTVC.m
//  TipsForCityDLUT
//
//  Created by 胡啸晨 on 15/4/3.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "JustPostNewsTVC.h"
#import "NewsFetcher.h"

@interface JustPostNewsTVC ()

@property (assign, nonatomic)NSInteger selectedSegment;
- (IBAction)changeSegmented:(UISegmentedControl *)sender;
- (IBAction)refreshSpinner:(UIRefreshControl *)sender;

@end

@implementation JustPostNewsTVC

- (void)setSelectedSegment:(NSInteger)selectedSegment
{
    _selectedSegment = selectedSegment;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self refreshSpinner:self.refresh];
    //[self fetchNews];
}

- (void)fetchNews
{
    //fetch json data
    NSURL *url;
    if (_selectedSegment == 0) {
        url = [NewsFetcher URLforReport];
    }
    else {
        url = [NewsFetcher URLforNews];
    }
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
           queue:queue
            completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                if (!connectionError) {
                    if (response.URL == url) {
                        NSDictionary *newsList = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error: &connectionError];
                        NSArray *news = [newsList valueForKeyPath:NEWS_COLLECTION];
                        dispatch_async(dispatch_get_main_queue(), ^{ self.news = news; });
                    }
                }
            }];
}

- (IBAction)changeSegmented:(UISegmentedControl *)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    _selectedSegment = segmentedControl.selectedSegmentIndex;
    
    [self refreshSpinner:self.refresh];
}

- (IBAction)refreshSpinner:(UIRefreshControl *)sender {
    
    if (!self.refresh.refreshing) {
        self.refresh.attributedTitle = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"下拉刷新..."]];
        [self.refresh didMoveToWindow];
        [self.refresh beginRefreshing];
    }
    if (self.refresh.refreshing) {
        self.refresh.attributedTitle = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"正在刷新..."]];
    }
    
    [self fetchNews];
}

@end
