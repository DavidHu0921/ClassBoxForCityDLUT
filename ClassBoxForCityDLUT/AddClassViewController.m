//
//  AddClassViewController.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/10.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "AddClassViewController.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "Student.h"

@interface AddClassViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *addClassNG;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stuIDLabel;

- (IBAction)cancelButton:(UIBarButtonItem *)sender;

@end

@implementation AddClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *student = [Student MR_findAll];
    
    NSString *studentName = [student[0] valueForKeyPath:@"studentname"];
    NSString *stuID = [student[0] valueForKeyPath:@"username"];
    self.nameLabel.text = [NSString stringWithFormat:@"学生姓名:%@",studentName];
    self.stuIDLabel.text = [NSString stringWithFormat:@"学生学号:%@", stuID];
    
    [self.addClassNG setTitle:[NSString stringWithFormat:@"添加课程表"]];
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

- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
