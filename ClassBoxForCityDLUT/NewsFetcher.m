//
//  DataFetcher.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/4/4.
//  Copyright (c) 2015年 DavidHu All rights reserved.
//

#import "NewsFetcher.h"

@implementation NewsFetcher

+ (NSURL *)URLForQuery:(NSString *)query
{
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:query];
}

+ (NSURL *)URLforNews
{
    return [self URLForQuery:NewsAPI];
}

+ (NSURL *)URLforReport
{
    return [self URLForQuery:ReportsAPI];
}

@end
