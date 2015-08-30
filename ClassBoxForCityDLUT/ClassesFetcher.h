//
//  ClassesFetcher.h
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/16.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "API.h"

#define ISEMPTY @"empty"
#define INFO @"info"
#define MONDAY @"monday"
#define TUESDAY @"tuesday"
#define FRIDAY @"friday"
#define WEDNESDAY @"wednesday"
#define THURSDAY @"thursday"
#define SUNDAY @"sunday"
#define SATURDAY @"saturday"

@interface ClassesFetcher : NSObject

+ (NSURL *)URLforClassesInfo: (NSString *) stuID password:(NSString *)password item:(NSInteger)item;

@end
