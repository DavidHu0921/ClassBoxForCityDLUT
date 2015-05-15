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

@interface AddClassViewController ()<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *addClassNG;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stuIDLabel;
@property (weak, nonatomic) IBOutlet UITextField *itemTextField;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBarCancelDone;
@property (weak, nonatomic) IBOutlet UIPickerView *itemPicker;

- (IBAction)cancelButton:(UIBarButtonItem *)sender;
- (IBAction)itemCancel:(UIBarButtonItem *)sender;
- (IBAction)itemDone:(UIBarButtonItem *)sender;

@end

@implementation AddClassViewController
{
    
    NSArray *itemArray;
    
    BOOL firstTimeLoad;
    
}

@synthesize itemTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    itemArray = @[@"大一上学期", @"大一下学期",@"大二上学期", @"大二下学期",@"大三上学期", @"大三下学期",@"大四上学期", @"大四下学期",@"大五上学期", @"大五下学期"];
//    NSLog(@"%ld", itemArray.count);
    
    firstTimeLoad = YES;
    self.itemPicker.hidden = YES;
    self.toolBarCancelDone.hidden = YES;
    
    [self createStudent];
    
    //add picker
//    [self.itemPicker selectRow:0 inComponent:0 animated:YES];
    self.itemPicker.dataSource = self;
    self.itemPicker.delegate = self;
    
    self.itemTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createStudent{
    NSArray *student = [Student MR_findAll];
    
    NSString *studentName = [student[0] valueForKeyPath:@"studentname"];
    NSString *stuID = [student[0] valueForKeyPath:@"username"];
    self.nameLabel.text = [NSString stringWithFormat:@"学生姓名:%@",studentName];
    self.stuIDLabel.text = [NSString stringWithFormat:@"学生学号:%@", stuID];
    
    [self.addClassNG setTitle:[NSString stringWithFormat:@"添加课程表"]];
}

#pragma mark - pickerView
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return itemArray[row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return itemArray.count;
}

- (IBAction)itemCancel:(UIBarButtonItem *)sender {
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.itemPicker.hidden = YES;
                         self.toolBarCancelDone.hidden = YES;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
}

- (IBAction)itemDone:(UIBarButtonItem *)sender {
    self.itemTextField.text = [NSString stringWithFormat:@"%@",[itemArray objectAtIndex:[self.itemPicker selectedRowInComponent:0]]];
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.itemPicker.hidden = YES;
                         self.toolBarCancelDone.hidden = YES;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.itemPicker.hidden = NO;
                         self.toolBarCancelDone.hidden = NO;
                         self.itemTextField.text = @"";
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    
    self.itemPicker.hidden = NO;
    self.toolBarCancelDone.hidden = NO;
    self.itemTextField.text = @"";
    
    return NO;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return  YES;
}

#pragma mark - cancelButton

- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
