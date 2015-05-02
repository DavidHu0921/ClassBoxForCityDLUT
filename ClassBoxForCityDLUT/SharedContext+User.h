//
//  SharedContext+User.h
//  ClassBoxForCityDLUT
//
//  Created by Eli Lien on 4/21/15.
//  Copyright (c) 2015 DavidHu All rights reserved.
//

#import "SharedContext.h"

extern NSString *const SharedContextUserLoginNotificationName;
extern NSString *const SharedContextUserLogoutNotificationName;
extern NSString *const SharedContextUserLoginFailedNotificationName;
extern NSString *const SharedContextUserIdentifierKeyName;

@interface SharedContext (User)

+ (void)postUserLoginNotification:(NSString *)userIdentifier;
+ (void)postUserLogoutNotification:(NSString *)userIdentifier;
+ (void)postUserLoginFailedNotification;
+ (NSString *)userIdentifier;

@end
