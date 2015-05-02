//
//  SharedContext.h
//  ClassBoxForCityDLUT
//
//  Created by Eli Lien on 4/21/15.
//  Copyright (c) 2015 DavidHu All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedContext : NSObject

+ (void)storeString:(NSString *)stringValue forKey:(NSString *)keyName;
+ (NSString *)getStringValue:(NSString *)keyName;

@end
