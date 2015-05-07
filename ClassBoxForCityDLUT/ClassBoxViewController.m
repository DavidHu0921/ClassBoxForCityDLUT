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
#import "ClassesDataSource.h"
#import "ClassesDelegateFlowLayout.h"

@interface ClassBoxViewController () <UICollectionViewDelegateFlowLayout>

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

- (void)createHeaderView{
    //添加navigation的title
    [self setNavigationBar];
    
    DateView *dateView = [[DateView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 20)];
    WeekView *weekView = [[WeekView alloc]initWithFrame:CGRectMake(0, 84, self.view.frame.size.width, 20)];
    
    [self.view addSubview:dateView];
    [self.view addSubview:weekView];
}

- (void)createCollectionView{
    //set layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing =0;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    //注册cell
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    ClassesDataSource *classesDataSource = [[ClassesDataSource alloc]init];
    ClassesDelegateFlowLayout *delegateLayout = [[ClassesDelegateFlowLayout alloc]init];
    
    collectionView.delegate = delegateLayout;
    collectionView.dataSource = classesDataSource;
    
    [self.view addSubview:collectionView];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
