//
//  User.h
//  ClassBoxForCityDLUT
//
//  Created by Eli Lien on 4/19/15.
//  Copyright (c) 2015 com.DavidHu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * passwd;

@end
