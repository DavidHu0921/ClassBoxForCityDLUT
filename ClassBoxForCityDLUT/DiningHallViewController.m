//
//  DiningHallViewController.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/6/1.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "DiningHallViewController.h"
#import "CustomTableViewCell.h"

@interface DiningHallViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation DiningHallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;

    [self createTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    if (section == 0) {
        return 8;
    }
    else if (section == 1){
        return 13;
    }
    else{
        return 13;
    }
    //    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"徐阿姨川菜馆"];
            cell.textView.text = @"18523175523";
        }
        else if (indexPath.row == 1){
            cell.textLabel.text = [NSString stringWithFormat:@"齐品达烤肉饭"];
            cell.textView.text = @"18940869078";
        }
        else if (indexPath.row == 2){
            cell.textLabel.text = [NSString stringWithFormat:@"营养锅仔套餐"];
            cell.textView.text = @"13029448892";
        }
        else if (indexPath.row == 3){
            cell.textLabel.text = [NSString stringWithFormat:@"成都小冒菜"];
            cell.textView.text = @"14741243366";
        }
        else if (indexPath.row == 4){
            cell.textLabel.text = [NSString stringWithFormat:@"山东杂粮煎饼"];
            cell.textView.text = @"18704280241";
        }
        else if (indexPath.row == 5){
            cell.textLabel.text = [NSString stringWithFormat:@"RGK"];
            cell.textView.text = @"13050508828";
        }
        else if (indexPath.row == 6){
            cell.textLabel.text = [NSString stringWithFormat:@"尚品手擀面"];
            cell.textView.text = @"15140360722";
        }
        else{
            cell.textLabel.text = [NSString stringWithFormat:@"芳馨佳厨"];
            cell.textView.text = @"4001013591";
        }
    }
    else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"朝鲜味盖饭"];
            cell.textView.text = @"13889570389";
        }
        else if (indexPath.row == 1){
            cell.textLabel.text = [NSString stringWithFormat:@"好滋味米线坊"];
            cell.textView.text = @"13998486265";
        }
        else if (indexPath.row == 2){
            cell.textLabel.text = [NSString stringWithFormat:@"排骨米饭·特色炒饼·照烧饭"];
            cell.textView.text = @"15948866552";
        }
        else if (indexPath.row == 3){
            cell.textLabel.text = [NSString stringWithFormat:@"乓乓公"];
            cell.textView.text = @"15640848133";
        }
        else if (indexPath.row == 4){
            cell.textLabel.text = [NSString stringWithFormat:@"川外川水煮坊/章姐烤肉拌饭"];
            cell.textView.text = @"13124114411";
        }
        else if (indexPath.row == 5){
            cell.textLabel.text = [NSString stringWithFormat:@"阿刚面食面面俱到"];
            cell.textView.text = @"18940990258";
        }
        else if (indexPath.row == 6){
            cell.textLabel.text = [NSString stringWithFormat:@"美食美客"];
            cell.textView.text = @"15141171839";
        }
        else if (indexPath.row == 7){
            cell.textLabel.text = [NSString stringWithFormat:@"香包包包子铺"];
            cell.textView.text = @"15309825733";
        }
        else if (indexPath.row == 8){
            cell.textLabel.text = [NSString stringWithFormat:@"闽南风味"];
            cell.textView.text = @"13604254836";
        }
        else if (indexPath.row == 9){
            cell.textLabel.text = [NSString stringWithFormat:@"吉祥馄饨·面"];
            cell.textView.text = @"13354058930";
        }
        else if (indexPath.row == 10){
            cell.textLabel.text = [NSString stringWithFormat:@"喜多屋鸡肉饭"];
            cell.textView.text = @"18641184959";
        }
        else if (indexPath.row == 11){
            cell.textLabel.text = [NSString stringWithFormat:@"黄焖鸡米饭"];
            cell.textView.text = @"13390511307";
        }
        else{
            cell.textLabel.text = [NSString stringWithFormat:@"食香来"];
            cell.textView.text = @"13322289240";
        }
    }
    else{
        if (indexPath.row == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"天津鸡汁包"];
            cell.textView.text = @"13644115729";
        }
        else if (indexPath.row == 1){
            cell.textLabel.text = [NSString stringWithFormat:@"福建沙县特色小吃"];
            cell.textView.text = @"15184032180";
        }
        else if (indexPath.row == 2){
            cell.textLabel.text = [NSString stringWithFormat:@"阿刚水饺"];
            cell.textView.text = @"13624949860";
        }
        else if (indexPath.row == 3){
            cell.textLabel.text = [NSString stringWithFormat:@"吉祥之家"];
            cell.textView.text = @"13654982868";
        }
        else if (indexPath.row == 4){
            cell.textLabel.text = [NSString stringWithFormat:@"新时尚便当"];
            cell.textView.text = @"13591103589";
        }
        else if (indexPath.row == 5){
            cell.textLabel.text = [NSString stringWithFormat:@"依思客专门店"];
            cell.textView.text = @"18042651019";
        }
        else if (indexPath.row == 6){
            cell.textLabel.text = [NSString stringWithFormat:@"阿刚盖饭"];
            cell.textView.text = @"13940831759";
        }
        else if (indexPath.row == 7){
            cell.textLabel.text = [NSString stringWithFormat:@"排骨米饭/紫菜包饭"];
            cell.textView.text = @"18042651018";
        }
        else if (indexPath.row == 8){
            cell.textLabel.text = [NSString stringWithFormat:@"杨国福"];
            cell.textView.text = @"18609593939";
        }
        else if (indexPath.row == 9){
            cell.textLabel.text = [NSString stringWithFormat:@"麦子香苦面"];
            cell.textView.text = @"15640942790";
        }
        else if (indexPath.row == 10){
            cell.textLabel.text = [NSString stringWithFormat:@"和香源"];
            cell.textView.text = @"18042650977";
        }
        else if (indexPath.row == 11){
            cell.textLabel.text = [NSString stringWithFormat:@"陕西凉皮/牛板筋/炸串"];
            cell.textView.text = @"13214287332";
        }
        else{
            cell.textLabel.text = @"(目前只提供有送餐服务的商家)";
            cell.textView.text = @"";
        }
    }
    cell.textView.textAlignment = NSTextAlignmentCenter;
    [cell.textView setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    cell.textView.editable = NO;
    cell.textView.scrollEnabled = NO;
    cell.textView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [NSString stringWithFormat:@"一食堂"];
    }
    else if (section == 1){
        return [NSString stringWithFormat:@"二食堂"];
    }
    else{
        return [NSString stringWithFormat:@"三食堂"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
