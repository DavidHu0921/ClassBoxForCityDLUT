//
//  analysisClassesJSON.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/17.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import "analysisClassesJSON.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "Course.h"
#import "ClassesFetcher.h"

@implementation analysisClassesJSON{
    NSString * classesName;
    NSString * classroom;
    NSString * howLong;
    NSString * startTime;
    NSString * teacherName;
    NSString * weekday;
    NSArray * weekNumber;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)analysisAndStore:(NSDictionary *)classesInfo{
    NSArray *classes = [classesInfo valueForKeyPath:INFO];

    
    for (int i = 0 ; i < 6; i++) {
        NSString *monday = [self cleanTheBlank:[classes[i] valueForKeyPath:MONDAY]];
        NSString *thursday = [self cleanTheBlank:[classes[i] valueForKeyPath:THURSDAY]];
        NSString *wednesday = [self cleanTheBlank:[classes[i] valueForKeyPath:WEDNESDAY]];
        NSString *tuesday = [self cleanTheBlank:[classes[i] valueForKeyPath:TUESDAY]];
        NSString *friday = [self cleanTheBlank:[classes[i] valueForKeyPath:FRIDAY]];
        NSString *saturday = [self cleanTheBlank:[classes[i] valueForKeyPath:SATURDAY]];
        NSString *sunday = [self cleanTheBlank:[classes[i] valueForKeyPath:SUNDAY]];
        
        
    }
}

- (NSString *)cleanTheBlank:(NSString *)weekday{
    NSString *withNoBlank;
    
    NSRegularExpression *regular;
    
    regular = [[NSRegularExpression alloc] initWithPattern:@"\\s{1,}"
                                                   options:NSRegularExpressionCaseInsensitive
                                                     error:nil];
    withNoBlank = [regular stringByReplacingMatchesInString:weekday options:NSRegularExpressionCaseInsensitive range:NSMakeRange(0, [weekday length]) withTemplate:@" "];
    
    NSLog(@"weekday with no blank:%@", withNoBlank);
    return withNoBlank;
}

@end   
