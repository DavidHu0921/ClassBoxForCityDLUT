//
//  LoginViewController.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/4/13.
//  Copyright (c) 2015年 DavidHu All rights reserved.
//

#import "LoginViewController.h"
#import "StudentProfile.h"
//#import "User.h"
#import "Student.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
//#import "SharedContext+User.h"

typedef void (^VerifyUserNameBlock) (BOOL wasSuccessful, NSArray *studentInfo);

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *stuID;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) NSString *stuName;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

- (IBAction)login:(UIButton *)sender;
- (IBAction)cancelButton:(UIBarButtonItem *)sender;

- (void)requestStudentInfo:(NSURL *)url withCallback:(VerifyUserNameBlock)callback;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.spinner stopAnimating];
    // Do any additional setup after loading the view.
}

- (IBAction)ViewDownTouch:(UIControl *)sender {
    // 发送resignFirstResponder.
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (IBAction)login:(UIButton *)sender {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.spinner startAnimating];
        self.loginButton.enabled = NO;
        [self.loginButton setTitle:@"登录中" forState:UIControlStateDisabled];
    });
    
    __block UIAlertView *alter;
    if (self.stuID.text.length != 0 && self.password.text.length != 0) {
        
        NSURL *url = [StudentProfile URLforStuProfile:self.stuID.text password:self.password.text];
        
        //begin the block
        VerifyUserNameBlock callback = ^(BOOL wasSuccessful, NSArray *studentInfo) {
            if (wasSuccessful) {
                NSArray *stu = [Student MR_findAll];
                if (stu.count != 0) {
                    [Student MR_truncateAll];
                }
                
                // Save student info
                Student *student = [Student MR_createInContext:[NSManagedObjectContext MR_defaultContext]];
                student.username = self.stuID.text;
                student.studentname = studentInfo.lastObject;
                student.password = self.password.text;
                
                //and then save the entity
                [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
//                    NSLog(@"SUCCESS: %d, with ERROR: %@", success, error);
                }];
                
                // Post notification
                //[SharedContext postUserLoginNotification:self.stuName];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.spinner stopAnimating];
                    self.loginButton.enabled = YES;
                    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
                });
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else {
                
                [self.spinner stopAnimating];
                self.loginButton.enabled = YES;
                [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
                
                alter = [[UIAlertView alloc] initWithTitle:@"错误" message:@"账号或密码错误" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                [alter show];
                // Post notification
                //[SharedContext postUserLoginFailedNotification];
            }
        };
        
        [self requestStudentInfo:url withCallback:callback];
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.spinner stopAnimating];
            self.loginButton.enabled = YES;
            [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
        });
        
        alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入账号或密码" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alter show];
        // Post notification
        //[SharedContext postUserLoginFailedNotification];
    }
}

//callback function
- (void)requestStudentInfo:(NSURL *)url withCallback:(VerifyUserNameBlock)callback{
    NSMutableArray *verityInfo = [[NSMutableArray alloc]init];
    
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
                                       NSString *stuName = [returnStatus valueForKey:STU_NAME];
                                       
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

- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

//
//- (NSArray *) verityStudentProfile: (NSURL *) url {
//    NSMutableArray *verityInfo = [[NSMutableArray alloc]init];
//
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//    NSURLResponse *response;
//    NSError *error;
//
//    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
//
//    if (!error) {
//        if (response.URL == url) {
//            NSDictionary *returnStatus = [NSJSONSerialization JSONObjectWithData:data
//                                                                         options:0
//                                                                           error:&error];
//            NSString *status = [returnStatus valueForKey:ISCORRECT];
//            NSString *stuName = [returnStatus valueForKey:STU_NAME];
//
//            [verityInfo addObject:status];
//            [verityInfo addObject:stuName];
//        }
//    }
//    if ([verityInfo.firstObject isEqualToString:[NSString stringWithFormat:@"success"]]) {
//        return verityInfo;
//    }
//    else{
//        return nil;
//    }
//}


// to verify if the data is in the database now
//            for (int i = 0; i < students.count; i++) {
//                NSLog(@"All Users: USERNAME: %@, PASSWD: %@", [students[i] valueForKey:@"username"], [students[i] valueForKey:@"passwd"]);
//            }
//            BOOL identicalStringFound = NO;
//            NSString *loginUser = self.stuID.text;
//            NSLog(@"%@", students);
//            for (loginUser in students) {
//                identicalStringFound = YES;
//                break;
//            }
//            if (!identicalStringFound) {
//                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
//                    NSLog(@"SUCCESS: %d, with ERROR: %@", success, error);
//                }];
//            }