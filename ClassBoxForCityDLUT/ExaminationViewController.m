//
//  ExaminationViewController.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/29.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "ExaminationViewController.h"
#import "ExaminationViewCell.h"
#import "ExaminationFetcher.h"

static NSString *CellIdentifier = @"cell";

@interface ExaminationViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ExaminationViewController

- (void)setGrades:(NSArray *)grades{
    _grades = grades;
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    
    if (self.tableView != nil) {
        [self createTableView];
    }
}

- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ExaminationViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    [self.view addSubview:self.tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExaminationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.grades count];
}

#pragma mark - fetchResult


#pragma mark - mem warn
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
