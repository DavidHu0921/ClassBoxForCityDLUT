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

@implementation SharedContext (User)

+ (void)postUserLoginNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:SharedContextUserLoginNotificationName object:nil];
}

+ (void)postUserLogoutNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:SharedContextUserLogoutNotificationName object:nil];
}
@end
