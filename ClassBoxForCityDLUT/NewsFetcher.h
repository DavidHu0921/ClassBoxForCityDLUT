//
//  DataFetcher.h
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/4/4.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "API.h"

// define some of the name needed in dictionary
#define NEWS_TYPE @"name"
#define NEWDATA_NUM @"newdata"
#define NEWS_COLLECTION @"results.collection1"

// version check
#define THISVERSIONRUN @"thisversionrun"
#define THISVERSIONSTATUS @"thisversionstatus"
#define LASTVERSIONRUN @"lastversionrun"
#define LASTVERSIONSTATUS @"lastversionstatus"
#define NEXTVERSIONRUN @"nextversionrun"

// news
#define NEWS_CONTENT @"content"
#define NEWS_TITLE @"title.text"
#define NEWS_HREF @"title.href"

@interface NewsFetcher : NSObject

+ (NSURL *)URLforNews;

+ (NSURL *)URLforReport;

@end
