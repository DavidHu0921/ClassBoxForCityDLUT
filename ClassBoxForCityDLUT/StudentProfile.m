//
//  StudentProfile.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/4/16.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "StudentProfile.h"

@implementation StudentProfile

+ (NSURL *)URLForQuery:(NSString *)query
{
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:query];
}

+ (NSURL *)URLforStudent: (NSString *) stuID password: (NSString *)password{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:VerifyAPI, stuID, password]];
    return url;
}

+ (NSURL *)URLforStuProfile: (NSString *) stuID password: (NSString *)password{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:VerifyAPI, stuID, password]];
    return url;
}

@end
