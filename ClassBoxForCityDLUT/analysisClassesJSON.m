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
        //去空格，并且把一个里面的课按“节\\s”的格式换成“节，”
        NSString *monday = [self cleanTheBlank:[classes[i] valueForKeyPath:MONDAY]];
        NSString *thursday = [self cleanTheBlank:[classes[i] valueForKeyPath:THURSDAY]];
        NSString *wednesday = [self cleanTheBlank:[classes[i] valueForKeyPath:WEDNESDAY]];
        NSString *tuesday = [self cleanTheBlank:[classes[i] valueForKeyPath:TUESDAY]];
        NSString *friday = [self cleanTheBlank:[classes[i] valueForKeyPath:FRIDAY]];
        NSString *saturday = [self cleanTheBlank:[classes[i] valueForKeyPath:SATURDAY]];
        NSString *sunday = [self cleanTheBlank:[classes[i] valueForKeyPath:SUNDAY]];
        
        //把所有课按“，”分开
        NSArray *mondayArray = [monday componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        NSArray *thursdayArray = [thursday componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        NSArray *wednesdayArray = [wednesday componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        NSArray *tuesdayArray = [tuesday componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        NSArray *fridayArray = [friday componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        NSArray *saturdayArray = [saturday componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        NSArray *sundayArray = [sunday componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];

//        for (int j = 0; j < mondayArray.count; j++) {
//            NSLog(@"%@", mondayArray[j]);
//        }
    }
}

- (NSString *)cleanTheBlank:(NSString *)weekday{
    NSString *withNoBlank;
    NSString *newString;
    
    NSRegularExpression *regular;
    regular = [[NSRegularExpression alloc] initWithPattern:@"\\s{1,}" options:NSRegularExpressionCaseInsensitive error:nil];
    withNoBlank = [regular stringByReplacingMatchesInString:weekday options:NSRegularExpressionCaseInsensitive range:NSMakeRange(0, [weekday length]) withTemplate:@" "];
    
    NSRegularExpression *newRegular;
    newRegular = [[NSRegularExpression alloc] initWithPattern:@"节\\s" options:NSRegularExpressionCaseInsensitive error:nil];
    newString = [newRegular stringByReplacingMatchesInString:withNoBlank options:NSRegularExpressionCaseInsensitive range:NSMakeRange(0, [withNoBlank length]) withTemplate:@"节,"];
    
    return newString;
}

@end   
