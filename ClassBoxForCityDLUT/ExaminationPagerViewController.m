//
//  ExaminationPagerViewController.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/6/1.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "ExaminationPagerViewController.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Student.h"
#import "ExaminationViewController.h"

//这里ViewPagerController.h是一个第三方的类库

@interface ExaminationPagerViewController () <ViewPagerDataSource, ViewPagerDelegate>

@end

@implementation ExaminationPagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSource = self;
    self.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    NSInteger startItem = [self startItem];

    NSDateComponents *comp = [[NSCalendar currentCalendar] components: NSCalendarUnitWeekOfYear | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger weekNumberOfNow =  [comp weekOfYear];
    NSInteger numberOfYear = [comp year];
    
    if (weekNumberOfNow < 30) {
        return (numberOfYear - startItem) * 2;
    }
    else{
        return (numberOfYear - startItem) * 2 -1;
    }
}

#pragma mark - ViewPagerDataSource
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    NSInteger startItem = [self startItem];
    UILabel *label = [[UILabel alloc]init];
    
    if (index%2 == 0) {
        label.text = [NSString stringWithFormat:@"%ld年秋学期", startItem + index/2];
    }
    else{
        label.text = [NSString stringWithFormat:@"%ld年春学期", startItem + (index+1)/2];
    }
    [label sizeToFit];
    
    return label;
}

#pragma mark - ViewPagerDataSource
- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    NSInteger startItem = [self startItem];
    NSDateComponents *comp = [[NSCalendar currentCalendar]
                              components: NSCalendarUnitWeekOfYear | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger weekNumberOfNow =  [comp weekOfYear];
    NSInteger numberOfYear = [comp year];

    NSNumber *num = [[NSNumber alloc]initWithInteger:index];
    if (num == nil) {
        if (weekNumberOfNow < 30) {
            index = (numberOfYear - startItem) * 2;
        }
        else{
            index = (numberOfYear - startItem) * 2 -1;
        }
    }
    else{
        [userDefaults setInteger:index forKey:@"iterm"];
    }
    
    ExaminationViewController *evc = [self.storyboard instantiateViewControllerWithIdentifier:@"examination"];
    return evc;
}

#pragma mark - helper

- (NSInteger)startItem{
    NSArray *stu = [Student MR_findAll];
    NSString *studentName = [stu[0] valueForKeyPath:@"username"];
    return [[studentName substringToIndex:4] intValue];
}

@end
