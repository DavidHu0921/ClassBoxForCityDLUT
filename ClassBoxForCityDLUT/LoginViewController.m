//
//  LoginViewController.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/4/13.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "LoginViewController.h"
#import "StudentProfile.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *stuID;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) NSString *stuName;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

- (IBAction)login:(UIButton *)sender;

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
        
        if (!veriftyInfo) {
            [self.stuName initWithString:veriftyInfo.lastObject];
            NSLog(@"2 %@", self.stuName);
            UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] init];
            
            self.discoveryVC = (DiscoveryViewController *)segue.destinationViewController;
            [self prepareForSegue:segue sender:sender];
            [self.discoveryVC unwindToLogin:segue];
            self.discoveryVC.stuName = self.stuName;
        }
        else{
            alter = [[UIAlertView alloc] initWithTitle:@"错误" message:@"账号或密码错误" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        }
    }
    else{
        alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入账号或密码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];
    }
    [self.spinner stopAnimating];
}

- (NSArray *) verityStudentProfile: (NSURL *) url {
    NSArray *verityInfo;

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSError *error;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    if (!error) {
        if (response.URL == url) {
            NSDictionary *returnStatus = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:0
                                                                           error:&error];
            NSString *status = [returnStatus valueForKey:ISCORRECT];
            NSString *stuName = [returnStatus valueForKey:STU_NAME];
            NSLog(@"1 %@", stuName);
            
            [verityInfo initWithObjects:status, stuName];
            NSLog(@"11 %@", verityInfo);
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
