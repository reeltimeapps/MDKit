//
//  NSDate+TimeAgo.h
//  BlackPlanet
//
//  Created by Matthew Dicembrino on 10/9/12.
//  Copyright (c) 2012 Blue Whale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TimeAgo)

+ (NSString *)timeAgoFromDate:(NSDate *)date;

@end
