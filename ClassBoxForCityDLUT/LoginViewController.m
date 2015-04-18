//
//  LoginViewController.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/4/13.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "LoginViewController.h"
#import "StudentProfile.h"
#import "User.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *stuID;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) NSString *stuName;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

- (IBAction)login:(UIButton *)sender;
- (IBAction)cancelButton:(UIBarButtonItem *)sender;

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

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if (self.stuName != NULL) {
        self.discoveryVC = [[DiscoveryViewController alloc]init];
        self.discoveryVC.stuName = self.stuName;
        NSLog(@"2 %@", self.discoveryVC.stuName);
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"unwindLogin"]) {
        if (sender != self.loginButton) return;
        if (!self.stuName) {
            self.discoveryVC = [[DiscoveryViewController alloc]init];
            self.discoveryVC.stuName = self.stuName;
            NSLog(@"3 %@", self.stuName);
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)login:(UIButton *)sender {
    [self.spinner startAnimating];
    
    UIAlertView *alter;
    if (self.stuID.text.length != 0 && self.password.text.length != 0) {
        
        NSURL *url = [StudentProfile URLforStuProfile:self.stuID.text password:self.password.text];
        NSArray *veriftyInfo = [self verityStudentProfile:url];
        
        if (veriftyInfo != nil) {
            self.stuName = veriftyInfo.lastObject;
            NSLog(@"1 %@", self.stuName);
            
            //这边能跳转了，但是没调用到unwindLogin那个函数
            [self performSegueWithIdentifier:@"unwindLogin" sender:self];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            // Save userinfo
            User *user = [User MR_createInContext:[NSManagedObjectContext MR_defaultContext]];
            user.username = self.stuID.text;
            user.passwd = self.password.text;
            [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
                NSLog(@"SUCCESS: %d, with ERROR: %@", success, error);
            }];
            
            NSArray *users = [User MR_findAll];
            for (int i = 0; i < users.count; i++) {
                NSLog(@"All Users: USERNAME: %@, PASSWD: %@", [users[i] valueForKey:@"username"], [users[i] valueForKey:@"passwd"]);
            }

        }
        else{
            alter = [[UIAlertView alloc] initWithTitle:@"错误" message:@"账号或密码错误" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alter show];
        }
    }
    else{
        alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入账号或密码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];
    }
    [self.spinner stopAnimating];
}

- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSArray *) verityStudentProfile: (NSURL *) url {
    NSMutableArray *verityInfo = [[NSMutableArray alloc]init];

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    if (!error) {
        if (response.URL == url) {
            NSDictionary *returnStatus = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:0
                                                                           error:&error];
            NSString *status = [returnStatus valueForKey:ISCORRECT];
            NSString *stuName = [returnStatus valueForKey:STU_NAME];
            
            [verityInfo addObject:status];
            [verityInfo addObject:stuName];
        }
    }
    if ([verityInfo.firstObject isEqualToString:[NSString stringWithFormat:@"success"]]) {
        return verityInfo;
    }
    else{
        return nil;
    }
}

@end
