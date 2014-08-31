//
//  NSFetchRequest+Helpers.h
//  BlackPlanet
//
//  Created by Matthew Dicembrino on 10/1/12.
//  Copyright (c) 2012 Blue Whale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NSFetchRequest (Helpers)

+ (NSFetchRequest *)requestForEntity:(NSString *)name inContext:(NSManagedObjectContext *)context;

@end
