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
#import "Student.h"
#import <MagicalRecord/MagicalRecord.h>

static NSString *CellIdentifier = @"cell";

@interface ExaminationViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation ExaminationViewController

- (void)setGrades:(NSArray *)grades{
    _grades = grades;
    
    if (self.spinner.isAnimating) {
        [self.spinner stopAnimating];
    }
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self.spinner startAnimating];
    
    [self fetchExamination];
    if (self.tableView == nil) {
        [self createTableView];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.spinner startAnimating];
}

- (void)fetchExamination{
    NSArray *student = [Student MR_findAll];
    NSString *studentName = [student[0] valueForKeyPath:@"username"];
    NSString *password = [student[0] valueForKeyPath:@"password"];
    NSInteger startItem = [[studentName substringToIndex:4] intValue];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger nowOnTab = [userDefaults integerForKey:@"iterm"];
    
    NSNumber *num = [[NSNumber alloc]initWithInteger:nowOnTab];
    if (num == nil) {
        nowOnTab = self.grades.count - 1;
    }
    
    NSInteger term = 5 + (startItem - 2010) * 2 + nowOnTab;
    
    NSURL *url = [ExaminationFetcher URLforExamination:studentName password:password term:term];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (!connectionError) {
                                   if (response.URL == url) {
                                       NSDictionary *returnStatus = [NSJSONSerialization JSONObjectWithData:data
                                                                                                    options:0
                                                                                                      error:&connectionError];
                                       NSArray *grade = [returnStatus valueForKey:INFO];

                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           self.grades = grade;
                                       });
                                  }
                               }
                           }];
}

- (void)createTableView{
    //height is error
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 108)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ExaminationViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    [self.view addSubview:self.tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExaminationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *grade = self.grades[indexPath.row];
//    NSLog(@"grade is:%@", grade);
    cell.name.text = [grade valueForKeyPath:NAME];
    cell.category.text = [grade valueForKeyPath:CATEGORY];
    cell.examining_method.text = [grade valueForKeyPath:EXAMINING_METHOD];
    
    NSInteger credit_hoursNum = [[grade valueForKeyPath:CREDIT_HOURS] integerValue];
    NSInteger creditNum = [[grade valueForKeyPath:CREDIT] integerValue];
    cell.credit_hours.text = [NSString stringWithFormat:@"%ld学分", credit_hoursNum];
    cell.credit.text = [NSString stringWithFormat:@"%ld学时", creditNum];
    
    cell.average_gradesTitle.text = @"平时成绩";
    cell.final_gradesTitle.text = @"期末成绩";
    cell.general_gradesTitle.text = @"综合成绩";
    NSInteger average_gradesNum = [[grade valueForKeyPath:AVERAGE_GRADES] integerValue];
    NSInteger final_gradesNum = [[grade valueForKeyPath:FINAL_GRADES] integerValue];
    NSInteger general_gradesNum = [[grade valueForKeyPath:GENERAL_GRADES] integerValue];
    
    cell.average_grades.text = [NSString stringWithFormat:@"%ld分", average_gradesNum];
    cell.final_grades.text = [NSString stringWithFormat:@"%ld分", final_gradesNum];
    cell.general_grades.text = [NSString stringWithFormat:@"%ld分", general_gradesNum];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
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
