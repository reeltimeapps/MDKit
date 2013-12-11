//
//  NSFetchRequest+Helpers.m
//  BlackPlanet
//
//  Created by Matthew Dicembrino on 10/1/12.
//  Copyright (c) 2012 Blue Whale. All rights reserved.
//

#import "NSFetchRequest+Helpers.h"

@implementation NSFetchRequest (Helpers)

+ (NSFetchRequest *)requestForEntity:(NSString *)name inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:name inManagedObjectContext:context];
    [request setEntity:entity];
    return request;
}

@end