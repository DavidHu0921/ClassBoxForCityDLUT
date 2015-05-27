//
//  ClassBoxViewController.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/6.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "ClassBoxViewController.h"
#import "WeekView.h"
#import "DateView.h"
#import "ClassesNumCollectionViewCell.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "Student.h"
#import "Course.h"

static const CGFloat CellHieght = 70;

@interface ClassBoxViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UINavigationItem *ClassBoxNC;
@property (strong, nonatomic) UICollectionView *collection;

- (IBAction)addClassesButton:(UIBarButtonItem *)sender;

@end

@implementation ClassBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (self.collection == nil) {
        [self createHeaderView];
        //添加collectionView
        [self createCollectionView];
    }
    
    [self drawButton:self.collection];
    
    [self.view setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - createHeaderPart

- (void)createHeaderView{
    //添加navigation的title
    [self setNavigationBar];
    
    DateView *dateView = [[DateView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 20)];
    WeekView *weekView = [[WeekView alloc]initWithFrame:CGRectMake(0, 84, self.view.frame.size.width, 20)];
    
    [self.view addSubview:dateView];
    [self.view addSubview:weekView];
}

- (void)setNavigationBar{
    
    //赋值给NC
    NSInteger thisWeekNumber = [self countForThisWeek];
    if (thisWeekNumber > 18) {
        self.ClassBoxNC.title = [NSString stringWithFormat:@"放假"];
    }
    else{
        self.ClassBoxNC.title = [NSString stringWithFormat:@"第%ld周", thisWeekNumber];
    }
}

- (NSInteger)countForThisWeek{
    //获取当前周数
    NSDate *now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *openDay = [dateFormatter dateFromString:@"2015-03-09"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger weekNumberOfNow =  [[calendar components: NSCalendarUnitWeekOfYear fromDate:now] weekOfYear];
    NSInteger weekNumberOfOpenDay =  [[calendar components: NSCalendarUnitWeekOfYear fromDate:openDay] weekOfYear];
    
    NSInteger weekDayNow = [[calendar components:NSCalendarUnitWeekday fromDate:now] weekday];
    
    if (weekDayNow == 1) {
        return weekNumberOfNow - weekNumberOfOpenDay;
    }
    else{
        return weekNumberOfNow - weekNumberOfOpenDay + 1;
    }
}

#pragma mark - createCollectionPart

- (void)createCollectionView{
    //set layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
    flowLayout.minimumLineSpacing = 0;//纵向间距
    flowLayout.minimumInteritemSpacing = 0;//横向间距
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //154 = tabbar + navigation + week + date + state
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height-154) collectionViewLayout:flowLayout];
    self.collection.backgroundColor = [UIColor whiteColor];
    //注册cell
    [self.collection registerClass:[ClassesNumCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.collection.delegate = self;
    self.collection.dataSource = self;
    
//    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height-154) collectionViewLayout:flowLayout];
    
    [self.view addSubview:self.collection];
}

- (void)drawButton:(UIView *)classview{
    
    CGFloat redColor[] = {0.0, 159.0, 243.0, 243.0, 242.0};
    CGFloat greenColor[] = {146.0, 224.0, 229.0, 181.0, 156.0};
    CGFloat blueColor[] = {199.0, 246.0, 154.0, 155.0, 156.0};
    //add button
    NSArray *courses = [Course MR_findAll];
    
    if (courses.count != 0) {
        for (int i = 0; i < courses.count; i++) {
            NSMutableArray *weekArray = [NSKeyedUnarchiver unarchiveObjectWithData:[courses[i] valueForKeyPath:@"weekNumber"]];
            
            for (NSNumber *thisWeekNumber in weekArray){
                if ([thisWeekNumber isEqualToNumber:[NSNumber numberWithInteger:[self countForThisWeek]]]) {
                    NSString *cname = [courses[i] valueForKeyPath:@"classesName"];
                    NSString *rname = [courses[i] valueForKeyPath:@"classroom"];
                    NSInteger startNumber = [[courses[i] valueForKeyPath:@"startTime"] integerValue];
                    NSInteger longLast = [[courses[i] valueForKeyPath:@"howLong"] integerValue];
                    NSInteger weekDay = [[courses[i] valueForKeyPath:@"weekday"] integerValue];
                    NSInteger x = [[courses[i] valueForKey:@"backgroundColor"] integerValue];
                    
                    NSString *btnName = [NSString stringWithFormat:@"%@\n%@", cname, rname];
                    
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    button.frame = CGRectMake(25 + (self.view.frame.size.width-25)/7*(weekDay-1) + 1 , (CellHieght*startNumber)*2 + 1, (self.view.frame.size.width-25)/7 - 2 , CellHieght*longLast - 2);
                    
                    //set attribute for button
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
                    button.titleLabel.textAlignment = NSTextAlignmentCenter;
                    button.layer.cornerRadius = 6; // this value vary as per your desire
                    button.clipsToBounds = YES;
                    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
                    [button setTitle:btnName forState: UIControlStateNormal];
                    
                    //set button color
                    [button setBackgroundColor:[UIColor colorWithRed:redColor[x]/255.0 green:greenColor[x]/255.0 blue:blueColor[x]/255.0 alpha:1]];

                    [classview addSubview:button];
                }
            }
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return CGSizeMake(25, CellHieght);
    }
    else{
        return CGSizeMake((self.view.frame.size.width - 25)/7, CellHieght);
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 12;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassesNumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell.classedNum setFrame:CGRectMake(0, 0, 25, CellHieght)];
    
    if (indexPath.row == 0) {
        if (indexPath.section == 0) {
            cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"classNum1"]];
            cell.backgroundColor = nil;
            cell.classedNum.text = [NSString stringWithFormat:@"%ld", indexPath.section + 1];
            cell.classedNum.font = [UIFont systemFontOfSize:12];
            cell.classedNum.textAlignment = NSTextAlignmentCenter;
        }
        else{
            cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"classNum2"]];
            cell.classedNum.text = [NSString stringWithFormat:@"%ld", indexPath.section + 1];
            cell.classedNum.font = [UIFont systemFontOfSize:12];
            cell.classedNum.textAlignment = NSTextAlignmentCenter;
        }
    }
    else{
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                cell.classedNum.text = nil;
                cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellBG1"]];
                cell.backgroundColor = nil;
            }
            else if (indexPath.row == 7){
                cell.classedNum.text = nil;
                cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellBG3"]];
                cell.backgroundColor = nil;
            }
            else{
                cell.classedNum.text = nil;
                cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellBG2"]];
                cell.backgroundColor = nil;
            }
        }
        else if (indexPath.section == 11){
            if (indexPath.row == 1) {
                cell.classedNum.text = nil;
                cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellBG7"]];
                cell.backgroundColor = nil;
            }
            else if (indexPath.row == 7){
                cell.classedNum.text = nil;
                cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellBG9"]];
                cell.backgroundColor = nil;
            }
            else{
                cell.classedNum.text = nil;
                cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellBG8"]];
                cell.backgroundColor = nil;
            }
        }
        else{
            if (indexPath.row == 1) {
                cell.classedNum.text = nil;
                cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellBG4"]];
                cell.backgroundColor = nil;
            }
            else if (indexPath.row == 7){
                cell.classedNum.text = nil;
                cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellBG6"]];
                cell.backgroundColor = nil;
            }
            else{
                cell.classedNum.text = nil;
                cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellBG5"]];
                cell.backgroundColor = nil;
            }
        }
        
    }
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //底部还能滚动，后续再写死
    if (scrollView.contentOffset.y < 0) {
        CGPoint offset = scrollView.contentOffset;
        offset.y = 0;
        scrollView.contentOffset = offset;
    }
    else if (scrollView.contentOffset.y > CellHieght * 12){
        CGPoint offset = scrollView.contentOffset;
        offset.y = CellHieght * 12;
        scrollView.contentOffset = offset;
    }

}

#pragma mark - add Button

- (IBAction)addClassesButton:(UIBarButtonItem *)sender {
    NSArray *student = [Student MR_findAll];
    NSArray *courses = [Course MR_findAll];
    UIAlertView *alert;
    
    if (student.count == 0) {
        alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先登录"
                                          delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
    }
    else if (courses.count != 0){
        alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已有课表，请先删除再添加新课表"
                                          delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else{
        [self performSegueWithIdentifier:@"addClasses" sender:nil];
    }
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            break;
        case 1:
            [self deleteCourse];
            break;
        default:
            break;
    }
}

- (void)deleteCourse{
    [Course MR_truncateAll];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    NSMutableArray *buttonsToRemove = [NSMutableArray array];
    for (UIView *subview in self.collection.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            [buttonsToRemove addObject:subview];
        }
    }
    [buttonsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.collection setNeedsDisplay];
}

@end
