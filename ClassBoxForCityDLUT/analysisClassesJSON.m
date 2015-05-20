//
//  analysisClassesJSON.m
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/17.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

//这个类如果看不懂联系这个邮箱：davidhu920921@gmail.com

#import "analysisClassesJSON.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "Course.h"
#import "ClassesFetcher.h"

static const NSString *NORMAL_REGEX=@"(.*)\\s(.*)\\s(.*)\\s(.*)\\s(.*)\\s(.*)";
static const NSString *SPORTS_REGEX=@"(.*)\\s(.*)\\s(.*)\\s(.*)\\s(.*)";
static const NSString *ENGLISH_REGEX=@"(.*)\\s(.*)\\s(.*)\\s(.*)\\s(.*)\\s(.*)\\s(.*)";

@implementation analysisClassesJSON{
    NSString * classesName;
    NSString * teacherName;
    NSString * classroom;
    NSNumber * startTime;
    NSNumber * weekday;
    NSNumber * howLong;
    NSArray *allweekNumber;
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

        [self storeTheWeekday:mondayArray weekday:1 numberOfClass:i];
        [self storeTheWeekday:thursdayArray weekday:2 numberOfClass:i];
        [self storeTheWeekday:wednesdayArray weekday:3 numberOfClass:i];
        [self storeTheWeekday:tuesdayArray weekday:4 numberOfClass:i];
        [self storeTheWeekday:fridayArray weekday:5 numberOfClass:i];
        [self storeTheWeekday:saturdayArray weekday:6 numberOfClass:i];
        [self storeTheWeekday:sundayArray weekday:7 numberOfClass:i];

    }
}

- (void)storeTheWeekday:(NSArray *)weekArray weekday:(NSInteger)dayInWeek numberOfClass:(NSInteger)numberOfClass{
    for (int i = 0; i < weekArray.count; i++) {
        NSPredicate *isEqualToNormal = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", NORMAL_REGEX];
        NSPredicate *isEqualToSport = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", SPORTS_REGEX];
        NSPredicate *isEqualToEnglish = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ENGLISH_REGEX];
        
        if ([isEqualToNormal evaluateWithObject: weekArray[i]]){

            //把所有内容按空格分开
            NSArray *classesDetail = [weekArray[i] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
            
            // handle with allWeekNum
            allweekNumber = [self handleWithWeekNumber:classesDetail[3] weekType:classesDetail[4]];
            //other value
            classesName = classesDetail[0];
            teacherName = classesDetail[1];
            classroom = classesDetail[2];
            startTime = [[NSNumber alloc]initWithInteger:numberOfClass];
            weekday = [[NSNumber alloc]initWithInteger:dayInWeek];
            howLong = [[NSNumber alloc]initWithInt:[[classesDetail[5] substringToIndex:1] intValue]];
            
            NSLog(@"classname:%@, teacherName:%@, classroom:%@, allweekNumber:%@, startTime:%@, weekday:%@, howLong:%@", classesName, teacherName, classroom, allweekNumber, startTime, weekday, howLong);
        }
        else if ([isEqualToSport evaluateWithObject: weekArray[i]]){
            NSArray *classesDetail = [weekArray[i] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
            
//            NSLog(@"%@是体育课程类型", classesDetail );
        }
        else if ([isEqualToEnglish evaluateWithObject: weekArray[i]]){
            NSArray *classesDetail = [weekArray[i] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
            
//            NSLog(@"%@是英语课程类型", classesDetail );
        }
        else{
//            NSLog(@"不是默认的课程类型");
        }
    }
}

#pragma mark - helper

- (NSArray *)handleWithWeekNumber:(NSString *)thisweeknumber weekType:(NSString *)weekType{
    
//    NSString *weekType = classesDetail[4];
    //去掉“周”
    NSRegularExpression *newRegular;
    newRegular = [[NSRegularExpression alloc] initWithPattern:@"周" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *newString = [newRegular stringByReplacingMatchesInString:thisweeknumber options:NSRegularExpressionCaseInsensitive range:NSMakeRange(0, [thisweeknumber length]) withTemplate:@""];
    
    //remove .
    NSArray *weekNumberDetail = [newString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    NSMutableArray *weekNumber = [[NSMutableArray alloc]init] ;//Store an array
    NSMutableArray *finalReturn = [[NSMutableArray alloc]init] ;
    
//    NSLog(@"type: %@ , array: %@", weekType, weekNumberDetail);
    for (int k = 0; k < weekNumberDetail.count; k++) {
        if ([weekNumberDetail[k] containsString:@"-"]) {
            NSArray *startAndEnd = [weekNumberDetail[k] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
            NSInteger start = [startAndEnd[0] integerValue];
            NSInteger end = [startAndEnd[1] integerValue];
            
//            NSLog(@"start: %ld, end: %ld", start, end);
            for (NSInteger m = start; m < end + 1; m++) {
                //                        [weekNumber addObject:m];
//                NSLog(@"number:%ld", m);
                [weekNumber addObject:[NSNumber numberWithInteger:m]];
            }
        }
        else{
//            NSLog(@"week Number is :%@", weekNumberDetail[k]);
            [weekNumber addObject:[NSNumber numberWithInt:[weekNumberDetail[k] intValue]]];
        }
    }
//    NSLog(@"weekArray: %@", weekNumber);
    //需要处理单双周
    if ([weekType isEqualToString:@"双周"]) {
        for (int x = 0; x < weekNumber.count; x++) {
            if ([weekNumber[x] integerValue]%2 == 0) {
                [finalReturn addObject:weekNumber[x]];
            }
        }
    }
    else if([weekType isEqualToString:@"单周"]){
        for (int y = 0; y < weekNumber.count; y++) {
            if ([weekNumber[y] integerValue]%2 == 0) {
                [finalReturn addObject:weekNumber[y]];
            }
        }
    }
    else{
        finalReturn = weekNumber;
    }
    
    return finalReturn;
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