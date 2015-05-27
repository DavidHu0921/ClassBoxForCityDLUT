//
//  Course.h
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/27.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Course : NSManagedObject

@property (nonatomic, retain) NSString * classesName;
@property (nonatomic, retain) NSString * classroom;
@property (nonatomic, retain) NSNumber * howLong;
@property (nonatomic, retain) NSNumber * startTime;
@property (nonatomic, retain) NSString * teacherName;
@property (nonatomic, retain) NSNumber * weekday;
@property (nonatomic, retain) NSData * weekNumber;
@property (nonatomic, retain) NSNumber * backgroundColor;

@end
