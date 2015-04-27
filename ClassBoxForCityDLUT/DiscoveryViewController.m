//
//  DiscoveryViewController.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/4/13.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "DiscoveryViewController.h"
//#import "SharedContext+User.h"
//#import "User.h"
#import "Student.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>

@interface DiscoveryViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginLogoutBtn;
@property (weak, nonatomic) IBOutlet UIView *profileView;

- (IBAction)LoginBTN:(UIButton *)sender;

@end

@implementation DiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSArray *student = [Student MR_findAll];
    
    if (student.count != 0) {
        self.nameLabel.text = [student[0] valueForKeyPath:@"studentname"];
        NSLog(@"%@", student);
        [self.loginLogoutBtn setTitle:@"注销" forState:UIControlStateNormal];
    }
    else{
        self.nameLabel.text = [NSString stringWithFormat:@"未登录"];
        [self.loginLogoutBtn setTitle:@"登录" forState:UIControlStateNormal];
    }
}

- (IBAction)LoginBTN:(UIButton *)sender {
    NSString *loginText = self.loginLogoutBtn.titleLabel.text;
    UIAlertView *alert;
    
    if ([loginText isEqualToString:[NSString stringWithFormat:@"登录"]] ) {
        [self performSegueWithIdentifier:@"ToLogin" sender:self];
    }
    else{
        alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"真的要注销登录吗？"
                                          delegate:self cancelButtonTitle:@"取消"
                                            otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            break;
        case 1:
            [self deleteStudent];
            break;
        default:
            break;
    }
}

- (void)deleteStudent{
    
    //still have some problems
    [Student MR_truncateAll];
    self.nameLabel.text = @"未登录";
    [self.loginLogoutBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.profileView setNeedsDisplay];
    
    NSArray *stu = [Student MR_findAll];
    NSLog(@"%ld", stu.count);
}

@end


//viewdidload
//    __weak DiscoveryViewController *weakSelf = self;
//
//    [[NSNotificationCenter defaultCenter]
//     addObserverForName:SharedContextUserLoginNotificationName
//     object:nil
//     queue:[NSOperationQueue mainQueue]
//     usingBlock:^(NSNotification *note) {
//         NSString *userInfo = [NSString stringWithFormat:@"%@", note.userInfo];
//         [weakSelf loadUserProfile:userInfo];
//     }];
//
//    [[NSNotificationCenter defaultCenter]
//     addObserverForName:SharedContextUserLogoutNotificationName
//     object:nil
//     queue:[NSOperationQueue mainQueue]
//     usingBlock:^(NSNotification *note) {
//         [weakSelf loadLoginUserInterface];
//     }];
//
//    [[NSNotificationCenter defaultCenter]
//     addObserverForName:SharedContextUserLoginFailedNotificationName
//     object:nil
//     queue:[NSOperationQueue mainQueue]
//     usingBlock:^(NSNotification *note) {
//         [weakSelf loadLoginFailedAlert];
//     }];


//- (void)loadUserProfile:userInfo {
//    // TODO: do somthing
//
//    NSInteger studentsNumber = [self studentNum];
//
//    if (studentsNumber != 0) {
//        NSLog(@"Login Success with user: %@.", userInfo);
//        self.nameLabel.text = userInfo;
//        self.loginLogoutBtn.titleLabel.text = @"注销";
//    }
//}
//
//- (void)loadLoginUserInterface {
//    // TODO: do somthing
//
//    NSInteger studentsNumber = [self studentNum];
//
//    if (studentsNumber == 0) {
//        NSLog(@"Logout.");
//        self.nameLabel.text = @"未登录";
//        self.loginLogoutBtn.titleLabel.text = @"登录";
//    }
//}
//
//- (void)loadLoginFailedAlert {
//    // TODO: do somthing
//
//    NSInteger studentsNumber = [self studentNum];
//
//    if (studentsNumber == 0) {
//        NSLog(@"Login Failed.");
//        self.nameLabel.text = @"未登录";
//        self.loginLogoutBtn.titleLabel.text = @"登录";
//    }
//
//}
//- (NSInteger)studentNum{
//
//    //User *user = [User MR_createInContext:[NSManagedObjectContext MR_defaultContext]];
//    NSArray *students = [Student MR_findAll];
//    NSLog(@"现在数据库里的用户：%@ %zd", students, students.count);
//
//    return students.count;
//}
