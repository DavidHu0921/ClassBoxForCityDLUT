//
//  SharedContext.m
//  ClassBoxForCityDLUT
//
//  Created by Eli Lien on 4/21/15.
//  Copyright (c) 2015 com.DavidHu. All rights reserved.
//

#import "SharedContext.h"

@implementation SharedContext

+ (void)storeString:(NSString *)stringValue forKey:(NSString *)keyName {
    [[NSUserDefaults standardUserDefaults] setObject:stringValue forKey:keyName];
}

+ (NSString *)getStringValue:(NSString *)keyName {
    return [[NSUserDefaults standardUserDefaults] valueForKeyPath:keyName];
}

@end
