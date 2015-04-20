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
@property (weak, nonatomic) IBOutlet UIView *profileView;

@end

@implementation DiscoveryViewController

- (void)viewWillAppear {
    __weak DiscoveryViewController *weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:SharedContextUserLoginNotificationName
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      NSString *userInfo = [NSString stringWithFormat:@"%@", note.userInfo];
                                                      NSLog(@"userinfo: %@", userInfo);
                                                      [weakSelf loadUserProfile:userInfo];
                                                  }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SharedContextUserLogoutNotificationName
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      [weakSelf loadLoginUserInterface];
                                                  }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        NSLog(@"stu name: %@", self.stuName);
        [self.profileView reloadInputViews];
    }
    else{
        self.nameLabel.text = @"未登录";
    }
}

- (void)loadUserProfile:userInfo {
    NSLog(@"Login Success.");
}

- (void)loadLoginUserInterface {
    // TODO: do somthing
    NSLog(@"Login Failed.");
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
