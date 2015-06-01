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

@interface ExaminationPagerViewController () <ViewPagerDataSource, ViewPagerDelegate>

@end

@implementation ExaminationPagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSource = self;
    self.delegate = self;
    
    self.navigationController.navigationBarHidden = NO;
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
        NSDateComponents *comp = [[NSCalendar currentCalendar] components: NSCalendarUnitWeekOfYear | NSCalendarUnitYear fromDate:[NSDate date]];
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
            [userDefaults setInteger:index forKey:@"term"];
        }

    
    ExaminationViewController *evc = [self.storyboard instantiateViewControllerWithIdentifier:@"examination"];
    return evc;
    
}
- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index {
    
    // Do something useful
}

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
        case ViewPagerOptionCenterCurrentTab:
            return 0.0;
        case ViewPagerOptionTabLocation:
            return 0.0;
        default:
            return value;
    }
}

#pragma mark - helper

- (NSInteger)startItem{
    NSArray *stu = [Student MR_findAll];
    NSString *studentName = [stu[0] valueForKeyPath:@"username"];
    return [[studentName substringToIndex:4] intValue];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
