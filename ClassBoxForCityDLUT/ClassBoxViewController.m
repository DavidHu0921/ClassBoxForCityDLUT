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

static const CGFloat CellHieght = 50;

@interface ClassBoxViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UINavigationItem *ClassBoxNC;

@end

@implementation ClassBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createHeaderView];
    //添加collectionView
    [self createCollectionView];
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
    //获取当前周数
    NSDate *now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *openDay = [dateFormatter dateFromString:@"2015-03-09"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger weekNumberOfNow =  [[calendar components: NSCalendarUnitWeekOfYear fromDate:now] weekOfYear];
    NSInteger weekNumberOfOpenDay =  [[calendar components: NSCalendarUnitWeekOfYear fromDate:openDay] weekOfYear];
    
    //赋值给NC
    self.ClassBoxNC.title = [NSString stringWithFormat:@"第%ld周", weekNumberOfNow - weekNumberOfOpenDay + 1];
}

#pragma mark - createCollectionPart

- (void)createCollectionView{
    //set layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
    flowLayout.minimumLineSpacing = 0;//纵向间距
    flowLayout.minimumInteritemSpacing = 0;//横向间距
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height-104) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    //注册cell
    [collectionView registerClass:[ClassesNumCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
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
        else{
            cell.classedNum.text = nil;
            cell.backgroundView = nil;
            cell.backgroundColor = [UIColor lightGrayColor];
        }
        
    }
    
    return cell;
}


@end
