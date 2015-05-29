 //
//  DiscoveryViewController.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/4/13.
//  Copyright (c) 2015年 DavidHu All rights reserved.
//

#import "DiscoveryViewController.h"
//#import "SharedContext+User.h"
//#import "User.h"
#import "Student.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "Course.h"
#import "CollectionViewCell.h"
#import "LibraryViewController.h"
#import "ExaminationViewController.h"
#import "DiningHallViewController.h"
#import "AboutTableViewController.h"

@interface DiscoveryViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginLogoutBtn;
@property (weak, nonatomic) IBOutlet UIView *profileView;
@property (strong, nonatomic) UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UIImageView *profile;
@property (strong, nonatomic) NSString *imageName;

- (IBAction)LoginBTN:(UIButton *)sender;

@end

@implementation DiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //set profile image
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userProfile = [userDefaults stringForKey:@"profile"];
    
    if (userProfile == nil) {
        
        self.imageName = @"boy";
        self.profile.image = [UIImage imageNamed:self.imageName];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
        singleTap.numberOfTapsRequired = 1;
        [self.profile setUserInteractionEnabled:YES];
        [self.profile addGestureRecognizer:singleTap];
        
        [self.profile setNeedsDisplay];
    }
    else{
        self.imageName = userProfile;
        self.profile.image = [UIImage imageNamed:self.imageName];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
        singleTap.numberOfTapsRequired = 1;
        [self.profile setUserInteractionEnabled:YES];
        [self.profile addGestureRecognizer:singleTap];
        
        [self.profile setNeedsDisplay];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSArray *student = [Student MR_findAll];
    
    if (student.count != 0) {
        self.nameLabel.text = [student[0] valueForKeyPath:@"studentname"];
        [self.loginLogoutBtn setTitle:@"注销" forState:UIControlStateNormal];
    }
    else{
        self.nameLabel.text = [NSString stringWithFormat:@"未登录"];
        [self.loginLogoutBtn setTitle:@"登录" forState:UIControlStateNormal];
    }
    
    if (self.collection == nil) {
        [self createDiscoveryCollectionView];
    }
    
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - tap profile
-(void)tapDetected{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *mystring;
    
    if ([self.imageName isEqualToString:@"boy"]) {
        mystring = @"girl";
        self.imageName = mystring;
        [userDefaults setObject:mystring forKey:@"profile"];
        self.profile.image = [UIImage imageNamed:self.imageName];
        [self.profile setNeedsDisplay];
    }
    else{
        mystring = @"boy";
        self.imageName = mystring;
        [userDefaults setObject:mystring forKey:@"profile"];
        self.profile.image = [UIImage imageNamed:self.imageName];
        [self.profile setNeedsDisplay];
    }
}

#pragma mark - login Button

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
    [Course MR_truncateAll];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    self.nameLabel.text = @"未登录";
    [self.loginLogoutBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.profileView setNeedsDisplay];
}

#pragma mark - collection

- (void)createDiscoveryCollectionView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
    flowLayout.minimumLineSpacing = 0;//纵向间距
    flowLayout.minimumInteritemSpacing = 0;//横向间距
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    self.collection.backgroundColor = [UIColor whiteColor];
    [self.collection registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.collection.delegate = self;
    self.collection.dataSource = self;
    
    [self.view addSubview:self.collection];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/3, self.view.frame.size.width/3);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor lightGrayColor];

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.logoTitle.text = [NSString stringWithFormat:@"图书馆查询"];
            cell.logoTitle.textAlignment = NSTextAlignmentCenter;
            cell.logoTitle.textColor = [UIColor blackColor];
            cell.logoTitle.font = [UIFont systemFontOfSize:14];
            cell.logoImage.image = [UIImage imageNamed:@"library"];
        }
        else if (indexPath.row == 1){
            cell.logoTitle.text = [NSString stringWithFormat:@"成绩查询"];
            cell.logoTitle.textAlignment = NSTextAlignmentCenter;
            cell.logoTitle.textColor = [UIColor blackColor];
            cell.logoTitle.font = [UIFont systemFontOfSize:14];
            cell.logoImage.image = [UIImage imageNamed:@"examination"];
        }
        else if (indexPath.row  == 2){
            cell.logoTitle.text = [NSString stringWithFormat:@"订餐查询"];
            cell.logoTitle.textAlignment = NSTextAlignmentCenter;
            cell.logoTitle.textColor = [UIColor blackColor];
            cell.logoTitle.font = [UIFont systemFontOfSize:14];
            cell.logoImage.image = [UIImage imageNamed:@"diningHall"];
        }
    }
    else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.logoTitle.text = [NSString stringWithFormat:@"关于"];
            cell.logoTitle.textAlignment = NSTextAlignmentCenter;
            cell.logoTitle.textColor = [UIColor blackColor];
            cell.logoTitle.font = [UIFont systemFontOfSize:14];
            cell.logoImage.image = [UIImage imageNamed:@"about"];
        }
        else if (indexPath.row == 1){
//            NSLog(@"并没有什么卵用");
        }
        else if (indexPath.row  == 2){
//            NSLog(@"并没有什么卵用");
        }
    }
    else{
//        NSLog(@"并没有什么卵用");
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LibraryViewController *library = [self.storyboard instantiateViewControllerWithIdentifier:@"library"];
            [self showViewController:library sender:nil];

        }
        else if (indexPath.row == 1){
            ExaminationViewController *examination = [self.storyboard instantiateViewControllerWithIdentifier:@"examination"];
            [self showViewController:examination sender:nil];
        }
        else if (indexPath.row  == 2){
//            cell.logoTitle.text = [NSString stringWithFormat:@"订餐查询"];
            DiningHallViewController *diningHall = [self.storyboard instantiateViewControllerWithIdentifier:@"diningHall"];
            [self showViewController:diningHall sender:nil];
        }
    }
    else if (indexPath.section == 1){
        if (indexPath.row == 0) {
//            cell.logoTitle.text = [NSString stringWithFormat:@"关于"];
            AboutTableViewController *about = [self.storyboard instantiateViewControllerWithIdentifier:@"about"];
            [self showViewController:about sender:nil];
        }
        else if (indexPath.row == 1){
            //            NSLog(@"并没有什么卵用");
        }
        else if (indexPath.row  == 2){
            //            NSLog(@"并没有什么卵用");
        }
    }
    else{
        //        NSLog(@"并没有什么卵用");
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //底部还能滚动，后续再写死
    if (scrollView.contentOffset.y < 0) {
        CGPoint offset = scrollView.contentOffset;
        offset.y = 0;
        scrollView.contentOffset = offset;
    }
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
