//
//  CalendarViewController.m
//  Calendar
//
//  Created by Ole Begemann on 29.07.13.
//  Copyright (c) 2013 Ole Begemann. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarDataSource.h"
#import "HeaderView.h"

@interface CalendarViewController ()

@property (strong, nonatomic) IBOutlet CalendarDataSource *calendarDataSource;

@end

@implementation CalendarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Register NIB for supplementary views
    UINib *headerViewNib = [UINib nibWithNibName:@"HeaderView" bundle:nil];
    //[self.collectionView registerNib:headerViewNib forSupplementaryViewOfKind:@"DateHeaderView" withReuseIdentifier:@"HeaderView"];
    [self.collectionView registerNib:headerViewNib forSupplementaryViewOfKind:@"DayHeaderView" withReuseIdentifier:@"HeaderView"];
    [self.collectionView registerNib:headerViewNib forSupplementaryViewOfKind:@"HourHeaderView" withReuseIdentifier:@"HeaderView"];
    
    // Define cell and header view configuration
    CalendarDataSource *dataSource = (CalendarDataSource *)self.collectionView.dataSource;
    
    //add collection cell
    dataSource.configureCellBlock = ^(CalendarEventCell *cell, NSIndexPath *indexPath, id<CalendarEvent> event) {
        cell.titleLabel.text = event.title;
    };
    
    //draw the background
    dataSource.configureHeaderViewBlock = ^(HeaderView *headerView, NSString *kind, NSIndexPath *indexPath) {
//        if ([kind isEqualToString:@"DateHeaderView"]) {
//            headerView.titleLabel.text = [NSString stringWithFormat:@"Day %d", indexPath.item + 1];
//        }else
            if ([kind isEqualToString:@"DayHeaderView"]) {
            headerView.titleLabel.text = [NSString stringWithFormat:@"Day %d", indexPath.item + 1];
        } else if ([kind isEqualToString:@"HourHeaderView"]) {
            headerView.titleLabel.text = [NSString stringWithFormat:@"%2d", indexPath.item + 1];
        }
    };
}

@end
