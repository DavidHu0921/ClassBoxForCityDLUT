//
//  Course.h
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/5/9.
//  Copyright (c) 2015年 com.DavidHu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Course : NSManagedObject

@property (nonatomic, retain) NSString * classesName;
@property (nonatomic, retain) NSString * teacherName;
@property (nonatomic, retain) NSString * classroom;
@property (nonatomic, retain) NSString * weekday;
@property (nonatomic, retain) NSString * startTime;
@property (nonatomic, retain) NSString * howLong;
@property (nonatomic, retain) NSString * weekNumber;

@end
