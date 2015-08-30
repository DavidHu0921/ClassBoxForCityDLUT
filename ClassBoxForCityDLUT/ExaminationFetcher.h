//
//  ExaminationFetcher.h
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/6/1.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "API.h"

#define STATUS @"status"
#define INFO @"info"

#define NAME @"name"
#define CATEGORY @"category"
#define EXAMINING_METHOD @"examining_method"
#define CREDIT_HOURS @"credit_hours"
#define CREDIT @"credit"
#define AVERAGE_GRADES @"average_grades"
#define FINAL_GRADES @"final_grades"
#define GENERAL_GRADES @"general_grades"

@interface ExaminationFetcher : NSObject

+ (NSURL *)URLforExamination: (NSString *) stuID password: (NSString *)password term:(NSInteger)term;

@end
