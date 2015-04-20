//
//  SharedContext+User.h
//  ClassBoxForCityDLUT
//
//  Created by Eli Lien on 4/21/15.
//  Copyright (c) 2015 com.DavidHu. All rights reserved.
//

#import "SharedContext.h"

extern NSString *const SharedContextUserLoginNotificationName;
extern NSString *const SharedContextUserLogoutNotificationName;

@interface SharedContext (User)

+ (void)postUserLoginNotification;
+ (void)postUserLogoutNotification;

@end
