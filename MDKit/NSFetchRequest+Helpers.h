//
//  NSFetchRequest+Helpers.h
//   MDKit
//
//  Created by Matthew Dicembrino on 10/1/12.
//  Copyright (c) 2014 Six Sided Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NSFetchRequest (Helpers)

+ (NSFetchRequest *)requestForEntity:(NSString *)name inContext:(NSManagedObjectContext *)context;

@end
