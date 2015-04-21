//
//  SharedContext+User.m
//  ClassBoxForCityDLUT
//
//  Created by Eli Lien on 4/21/15.
//  Copyright (c) 2015 com.DavidHu. All rights reserved.
//

#import "SharedContext+User.h"

NSString *const SharedContextUserLoginNotificationName = @"SharedContextUserLoginNotificationName";
NSString *const SharedContextUserLogoutNotificationName = @"SharedContextUserLogoutNotificationName";
NSString *const SharedContextUserLoginFailedNotificationName = @"SharedContextUserLoginFailedNotificationName";
NSString *const SharedContextUserIdentifierKeyName = @"SharedContextUserIdentifierKeyName";

@implementation SharedContext (User)

+ (void)postUserLoginNotification:(NSString *)userIdentifier {
    [self storeString:userIdentifier forKey:SharedContextUserIdentifierKeyName];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:SharedContextUserLoginNotificationName
     object:nil
     userInfo:[userIdentifier copy]];
}

+ (void)postUserLogoutNotification:(NSString *)userIdentifier {
    [self storeString:userIdentifier forKey:SharedContextUserIdentifierKeyName];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:SharedContextUserLogoutNotificationName
     object:nil
     userInfo:[userIdentifier copy]];
}

+ (void)postUserLoginFailedNotification {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:SharedContextUserLoginFailedNotificationName
     object:nil];
}

+ (NSString *)userIdentifier {
    return [self getStringValue:SharedContextUserIdentifierKeyName];
}

@end
