//
//  DiscoveryViewController.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/4/13.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "SharedContext+User.h"

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
    
//    __weak DiscoveryViewController *weakSelf = self;
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
}

- (void)viewWillAppear:(BOOL)animated{
    
    __weak DiscoveryViewController *weakSelf = self;
    [[NSNotificationCenter defaultCenter]
     addObserverForName:SharedContextUserLoginNotificationName
     object:nil
     queue:[NSOperationQueue mainQueue]
     usingBlock:^(NSNotification *note) {
         NSString *userInfo = [NSString stringWithFormat:@"%@", note.userInfo];
         [weakSelf loadUserProfile:userInfo];
     }];
    
    [[NSNotificationCenter defaultCenter]
     addObserverForName:SharedContextUserLogoutNotificationName
     object:nil
     queue:[NSOperationQueue mainQueue]
     usingBlock:^(NSNotification *note) {
         [weakSelf loadLoginUserInterface];
     }];
    
    [[NSNotificationCenter defaultCenter]
     addObserverForName:SharedContextUserLoginFailedNotificationName
     object:nil
     queue:[NSOperationQueue mainQueue]
     usingBlock:^(NSNotification *note) {
         [weakSelf loadLoginFailedAlert];
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToLogin:(UIStoryboardSegue *)segue
{
    NSLog(@"%@", self.stuName);
    if (self.stuName != NULL) {
        self.nameLabel.text = self.stuName;
        [self.profileView reloadInputViews];
    }
    else{
        self.nameLabel.text = @"未登录";
    }
}

- (void)loadUserProfile:userInfo {
    // TODO: do somthing
    NSLog(@"Login Success with user: %@.", userInfo);
    self.nameLabel.text = userInfo;
    self.loginLogoutBtn.titleLabel.text = @"注销";
}

- (void)loadLoginUserInterface {
    // TODO: do somthing
    NSLog(@"Logout.");
    self.nameLabel.text = @"未登录";
    self.loginLogoutBtn.titleLabel.text = @"登录";
}

- (void)loadLoginFailedAlert {
    // TODO: do somthing
    NSLog(@"Login Failed.");
    self.nameLabel.text = @"未登录";
    self.loginLogoutBtn.titleLabel.text = @"登录";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)LoginBTN:(UIButton *)sender {
    NSString *loginText = self.loginLogoutBtn.titleLabel.text;
    NSLog(@"%@", loginText);
    UIAlertView *alter;
    
    NSLog(@"1");
    if ([loginText isEqualToString:[NSString stringWithFormat:@"登录"]] ) {
        NSLog(@"2");
        [self performSegueWithIdentifier:@"ToLogin" sender:self];
    }
    else{
        alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"真的要注销登录吗？" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];
    }
}
@end
