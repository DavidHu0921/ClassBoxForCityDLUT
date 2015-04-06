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

@property (assign, nonatomic)NSInteger *selectedSegment;

@end

@implementation JustPostNewsTVC

- (void)setSelectedSegment:(NSInteger)selectedSegment
{
    _selectedSegment = &selectedSegment;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchNews];
}

- (IBAction)NewsAndReports:(UISegmentedControl *)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    _selectedSegment = segmentedControl.selectedSegmentIndex;
    
    [self fetchNews];
}


- (void)fetchNews
{
    //fetch json data
    NSURL *url;
    if (_selectedSegment == 0) {
        url = [NewsFetcher URLforNews];
    }
    else {
        url = [NewsFetcher URLforReport];
    }
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
#warning it's gonna block the main queue
    NSData *jsonResults = [NSURLConnection sendSynchronousRequest:urlRequest
                                                returningResponse:&response
                                                            error:&error];
    NSDictionary *newsList = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                             options:0
                                                               error: &error];
    NSArray *news = [newsList valueForKeyPath:NEWS_COLLECTION];
    //NSLog(@"%@", news);
    self.news = news;
    
    //NSLog(@"cityNews: %@", newsList);
    /*
     [NSURLConnection sendAsynchronousRequest: urlRequest queue:queue
     completionHandler:^(
     NSURLResponse *response,
     NSData *data,
     NSError *error){
     if(data  && error == nil){
     NSLog(@"%@", data);
     NSDictionary *newsList = [NSJSONSerialization JSONObjectWithData:data
     options:0
     error: &error];
     NSLog(@"cityNews: %@", newsList);
     //NSArray *news = [newsList valueForKeyPath:nil];
     }else if([data length] == 0 && error == nil){
     NSLog(@"Nothing was downloaded.");
     }else if(error != nil){
     NSLog(@"Error happened = %@",error);
     }
     }];
     */
}

@end
