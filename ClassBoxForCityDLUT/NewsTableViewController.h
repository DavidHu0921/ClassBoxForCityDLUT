//
//  NewsTableViewController.h
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/4/3.
//  Copyright (c) 2015年 DavidHu All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewController : UITableViewController

@property (strong, nonatomic)NSArray *news;
@property (weak, nonatomic) IBOutlet UIRefreshControl *refresh;

@end
