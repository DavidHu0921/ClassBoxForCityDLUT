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

typedef void (^VerifyClassesBlock) (BOOL wasSuccessful, NSDictionary *classesInfo);

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
- (IBAction)fetchClasses:(UIButton *)sender;

- (void)requestStudentInfo:(NSURL *)url withCallback:(VerifyClassesBlock)callback;

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
    ;[textField resignFirstResponder];
    
    return  YES;
}

#pragma mark - cancelButton

- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - fetchClasses

- (IBAction)fetchClasses:(UIButton *)sender {
    UIAlertView *alert;
    if (self.itemTextField.text == [NSString stringWithFormat:@""]) {
        alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择学期" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
    }
    else{
        NSArray *student = [Student MR_findAll];
        
        NSString *studentName = [student[0] valueForKeyPath:@"studentname"];
        NSString *password = [student[0] valueForKeyPath:@"password"];
        NSInteger startItem = [[studentName substringToIndex:4] intValue];
        NSLog(@"start item is :%ld", startItem);
        
        NSInteger *itemNumber = [self numberOfItem:self.itemTextField.text];
        
        // 计算选择的学期是哪个学期
        NSInteger thisItem = *(7 + (startItem - 2010) * 2 + itemNumber);
        NSLog(@"this item is :%ld", thisItem);
        
        
    }
}

//callback function
- (void)requestClassesInfo:(NSURL *)url withCallback:(VerifyClassesBlock)callback{
    
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
                                       NSString *status = [returnStatus valueForKey:ISCORRECT];
                                       
                                       if ([status isEqualToString:[NSString stringWithFormat:@"success"]]) {
                                           [verityInfo addObject:status];
                                           [verityInfo addObject:stuName];
                                           
                                           callback(YES, verityInfo);
                                       }
                                       else{
                                           callback(NO, nil);
                                       }
                                   }
                               }
                           }];
}


//返回一个值，第几学期就加几
- (NSInteger)numberOfItem:(NSString *)itemNum{
    if ([itemNum isEqualToString:@"大一上学期"]) {
        return 0;
    }
    else if([itemNum isEqualToString:@"大一下学期"]){
        return 1;
    }
    else if([itemNum isEqualToString:@"大二上学期"]){
        return 2;
    }
    else if([itemNum isEqualToString:@"大二下学期"]){
        return 3;
    }
    else if([itemNum isEqualToString:@"大三上学期"]){
        return 4;
    }
    else if([itemNum isEqualToString:@"大三下学期"]){
        return 5;
    }
    else if([itemNum isEqualToString:@"大四上学期"]){
        return 6;
    }
    else if([itemNum isEqualToString:@"大四下学期"]){
        return 7;
    }
    else if([itemNum isEqualToString:@"大五上学期"]){
        return 8;
    }
    else if([itemNum isEqualToString:@"大五下学期"]){
        return 9;
    }
    else{
        return 10;
    }
}

@end
