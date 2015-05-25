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

- (IBAction)addClassesButton:(UIBarButtonItem *)sender;

@end

@implementation ClassBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self createHeaderView];
    //添加collectionView
    [self createCollectionView];
    
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
    self.ClassBoxNC.title = [NSString stringWithFormat:@"第%ld周", thisWeekNumber];
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
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height-154) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    //注册cell
    [collectionView registerClass:[ClassesNumCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [self drawButton:collectionView];
    
    [self.view addSubview:collectionView];
}

- (void)drawButton:(UIView *)classview{
    //add button
    NSArray *courses = [Course MR_findAll];

    if (courses.count != 0) {

        for (int i = 0; i < courses.count; i++) {
            
            NSMutableArray *weekArray = [NSKeyedUnarchiver unarchiveObjectWithData:[courses[i] valueForKeyPath:@"weekNumber"]];
//            NSLog(@"weeknumber: %@", weekArray);
            
            for (NSNumber *thisWeekNumber in weekArray){
                if ([thisWeekNumber isEqualToNumber:[NSNumber numberWithInteger:[self countForThisWeek]]]) {
                    NSString *cname = [courses[i] valueForKeyPath:@"classesName"];
                    NSString *rname = [courses[i] valueForKeyPath:@"classroom"];
                    NSInteger startNumber = [[courses[i] valueForKeyPath:@"startTime"] integerValue];
                    NSInteger longLast = [[courses[i] valueForKeyPath:@"howLong"] integerValue];
                    NSInteger weekDay = [[courses[i] valueForKeyPath:@"weekday"] integerValue];
                    
                    NSString *btnName = [NSString stringWithFormat:@"%@\n%@", cname, rname];
                    
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    button.frame = CGRectMake(25 + (self.view.frame.size.width-25)/7*(weekDay-1) , (CellHieght*startNumber)*2 , (self.view.frame.size.width-25)/7 , CellHieght*longLast);
                    [button setBackgroundColor:[UIColor lightGrayColor]];
                    
                    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
                    button.titleLabel.textAlignment = NSTextAlignmentCenter;
                    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
                    [button setTitle:btnName forState: UIControlStateNormal];
                    
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
                cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"topLeft"]];
                cell.backgroundColor = nil;
            }
            else if (indexPath.row == 7){
                cell.classedNum.text = nil;
                cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"topRight"]];
                cell.backgroundColor = nil;
            }
            else{
                cell.classedNum.text = nil;
                cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"top"]];
                cell.backgroundColor = nil;
            }
        }
        else if (indexPath.section == 11){
            if (indexPath.row == 1) {
                cell.classedNum.text = nil;
                cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bottomLeft"]];
                cell.backgroundColor = nil;
            }
            else if (indexPath.row == 7){
                cell.classedNum.text = nil;
                cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bottomRight"]];
                cell.backgroundColor = nil;
            }
            else{
                cell.classedNum.text = nil;
                cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bottom"]];
                cell.backgroundColor = nil;
            }
        }
        else{
            if (indexPath.row == 1) {
                cell.classedNum.text = nil;
                cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"left"]];
                cell.backgroundColor = nil;
            }
            else if (indexPath.row == 7){
                cell.classedNum.text = nil;
                cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right"]];
                cell.backgroundColor = nil;
            }
            else{
                cell.classedNum.text = nil;
                cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cellBody"]];
                cell.backgroundColor = nil;
            }
        }
        
    }
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //底部还能滚动，后续再写死
    if (scrollView.contentOffset.y <= 0 || scrollView.contentOffset.y >= CellHieght * 12) {
        CGPoint offset = scrollView.contentOffset;
        offset.y = 0;
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
            [Course MR_truncateAll];
            break;
        default:
            break;
    }
}

@end
