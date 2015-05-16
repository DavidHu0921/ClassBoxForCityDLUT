//
//  ClassesFetcher.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/16.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "ClassesFetcher.h"

@implementation ClassesFetcher

+ (NSURL *)URLforClassesInfo: (NSString *) stuID password:(NSString *)password item:(NSInteger)item{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:ClassesAPI, stuID, password, item]];
    return url;
}

@end
