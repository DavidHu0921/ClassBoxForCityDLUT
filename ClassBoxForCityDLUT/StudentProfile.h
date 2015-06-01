//
//  StudentProfile.h
//  ClassBoxForCityDLUT
//
//  Created by 胡啸晨 on 15/4/16.
//  Copyright (c) 2015年 DavidHu All rights reserved.
//

#import <Foundation/Foundation.h>
#import "API.h"

//验证是否正确
#define ISCORRECT @"status"

//个人信息
#define STU_NAME @"name"
#define STU_BIRTHDAY @"birth"
#define STU_FACUILTY @"facuilty"
#define STU_MAJOR @"major"
#define STU_CLASS @"class"

//{ "facuilty": "计算机工程学院", "major": "计算机科学与技术", "name": "康佳星", "birth": "1994-05-30", "class": "12计算机3班" }

@interface StudentProfile : NSObject

//+ (NSURL *)URLforStuVerify: (NSString *) stuID password: (NSString *)password;


@end
