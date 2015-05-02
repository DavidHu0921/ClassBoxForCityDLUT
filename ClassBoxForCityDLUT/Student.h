//
//  Student.h
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/4/23.
//  Copyright (c) 2015年 DavidHu All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Student : NSManagedObject

@property (nonatomic, retain) NSString * birth;
@property (nonatomic, retain) NSString * classNum;
@property (nonatomic, retain) NSString * facuilty;
@property (nonatomic, retain) NSString * major;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * studentname;
@property (nonatomic, retain) NSString * username;

@end
