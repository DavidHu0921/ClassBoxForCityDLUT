//
//  ExaminationFetcher.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/6/1.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "ExaminationFetcher.h"

@implementation ExaminationFetcher

+ (NSURL *)URLForQuery:(NSString *)query
{
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:query];
}

+ (NSURL *)URLforExamination: (NSString *) stuID password: (NSString *)password term:(NSInteger)term{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:ExaminationAPI, stuID, password, (long)term]];
    return url;
}

@end
