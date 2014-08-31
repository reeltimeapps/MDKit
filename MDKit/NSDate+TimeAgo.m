//
//  NSDate+TimeAgo.m
//   MDKit
//
//  Created by Matthew Dicembrino on 10/9/12.
//  Copyright (c) 2014 Six Sided Studio. All rights reserved.
//

#import "NSDate+TimeAgo.h"
#import "NSDate+Rails.h"

@implementation NSDate (TimeAgo)

#ifndef NSDateTimeAgoLocalizedStrings
#define NSDateTimeAgoLocalizedStrings(key) \
NSLocalizedStringFromTable(key, @"NSDateTimeAgo", nil)
#endif



+ (NSString *)timeAgoFromDate:(NSDate *)date {
    
    double deltaSeconds = fabs([[NSDate railsDateTimeNow] timeIntervalSinceDate:date]);
    double deltaMinutes = deltaSeconds / 60.0f;
    
    if(deltaSeconds < 5) {
        return NSDateTimeAgoLocalizedStrings(@"now");
    } else if(deltaSeconds < 60) {
        return [NSString stringWithFormat:NSDateTimeAgoLocalizedStrings(@"%ds"), (int)deltaSeconds];
    } else if(deltaSeconds < 120) {
        return NSDateTimeAgoLocalizedStrings(@"1m");
    } else if (deltaMinutes < 60) {
        return [NSString stringWithFormat:NSDateTimeAgoLocalizedStrings(@"%dm"), (int)deltaMinutes];
    } else if (deltaMinutes < 120) {
        return NSDateTimeAgoLocalizedStrings(@"1h");
    } else if (deltaMinutes < (24 * 60)) {
        return [NSString stringWithFormat:NSDateTimeAgoLocalizedStrings(@"%dh"), (int)floor(deltaMinutes/60)];
    } else if (deltaMinutes < (24 * 60 * 2)) {
        return NSDateTimeAgoLocalizedStrings(@"1d");
    } else if (deltaMinutes < (24 * 60 * 7)) {
        return [NSString stringWithFormat:NSDateTimeAgoLocalizedStrings(@"%dd"), (int)floor(deltaMinutes/(60 * 24))];
    } else if (deltaMinutes < (24 * 60 * 14)) {
        return NSDateTimeAgoLocalizedStrings(@"1w");
    } else if (deltaMinutes < (24 * 60 * 31)) {
        return [NSString stringWithFormat:NSDateTimeAgoLocalizedStrings(@"%dw"), (int)floor(deltaMinutes/(60 * 24 * 7))];
    } else if (deltaMinutes < (24 * 60 * 61)) {
        return NSDateTimeAgoLocalizedStrings(@"1mo");
    } else if (deltaMinutes < (24 * 60 * 365.25)) {
        return [NSString stringWithFormat:NSDateTimeAgoLocalizedStrings(@"%dmo"), (int)floor(deltaMinutes/(60 * 24 * 30))];
    } else if (deltaMinutes < (24 * 60 * 731)) {
        return NSDateTimeAgoLocalizedStrings(@"1y");
    }
    
    return [NSString stringWithFormat:NSDateTimeAgoLocalizedStrings(@"%dy"), (int)floor(deltaMinutes/(60 * 24 * 365))];
}

@end