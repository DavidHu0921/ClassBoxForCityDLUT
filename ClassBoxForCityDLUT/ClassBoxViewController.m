//
//  ClassBoxViewController.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/6.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "ClassBoxViewController.h"
#import "WeekView.h"
#import "DateView.h"
#import "ClassesCollectionView.h"

@interface ClassBoxViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *ClassBoxNC;

@end

@implementation ClassBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createView];
}

- (void)createView{
    //添加navigation的title
    [self setNavigationBar];
    
    DateView *dateView = [[DateView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 20)];
    WeekView *weekView = [[WeekView alloc]initWithFrame:CGRectMake(0, 84, self.view.frame.size.width, 20)];
    ClassesCollectionView *classesView = [[ClassesCollectionView alloc]initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height - 104)];
    
    [self.view addSubview:dateView];
    [self.view addSubview:weekView];
    [self.view addSubview:classesView];
}

- (void)setNavigationBar{
    //获取当前周数
    NSDate *now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *openDay = [dateFormatter dateFromString:@"2015-03-09"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger weekNumberOfNow =  [[calendar components: NSCalendarUnitWeekOfYear fromDate:now] weekOfYear];
    NSInteger weekNumberOfOpenDay =  [[calendar components: NSCalendarUnitWeekOfYear fromDate:openDay] weekOfYear];
    
    //赋值给NC
//    NSString *numberOfWeek = [NSString stringWithFormat:@"第%ld周", weekNumberOfNow - weekNumberOfOpenDay + 1];
    self.ClassBoxNC.title = [NSString stringWithFormat:@"第%ld周", weekNumberOfNow - weekNumberOfOpenDay + 1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
