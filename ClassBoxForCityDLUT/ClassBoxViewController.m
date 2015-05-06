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

@interface ClassBoxViewController ()

@end

@implementation ClassBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createView];
}

- (void)createView{
    DateView *dateView = [[DateView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 20)];
    WeekView *weekView = [[WeekView alloc]initWithFrame:CGRectMake(0, 84, self.view.frame.size.width, 20)];
    
    [self.view addSubview:dateView];
    [self.view addSubview:weekView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
