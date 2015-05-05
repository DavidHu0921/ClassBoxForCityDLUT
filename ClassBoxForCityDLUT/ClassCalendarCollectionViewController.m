//
//  ClassCalendarCollectionViewController.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/2.
//  Copyright (c) 2015年 DavidHu. All rights reserved.
//

#import "ClassCalendarCollectionViewController.h"
#import "ClassCalendarDataSource.h"
#import "WeekReuse.h"

static NSArray *weekDay = (@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日");

@interface ClassCalendarCollectionViewController ()

@property (strong, nonatomic) IBOutlet ClassCalendarDataSource *classedDataSource;

@end

@implementation ClassCalendarCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UINib *weekViewNib = [UINib nibWithNibName:@"ReuseView" bundle:nil];
    [self.collectionView registerNib:weekViewNib forSupplementaryViewOfKind:@"WeekReuse" withReuseIdentifier:@"WeekReuse"];
    
    ClassCalendarDataSource *classDataSource = (ClassCalendarDataSource *)self.collectionView.dataSource;
    
    //执行下面的代码就会crash
    classDataSource.configureWeekViewBlock = ^(WeekReuse *weekReuseView, NSString *kind, NSIndexPath *indexPath) {
        if ([kind isEqualToString:@"WeekReuse"]) {
            for (int i = 0; i < 7; i++) {
                NSLog(@"will print: %@", weekDay[i]);
                weekReuseView.WeekTitle.text = [NSString stringWithFormat:weekDay[i], indexPath.item +1];
            }
        }
        //课程号
    };
}


@end
