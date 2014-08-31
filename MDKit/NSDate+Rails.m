//
//  NSDate+Rails.m
//  MDKit
//
//  Created by Matthew Dicembrino on 8/26/13.
//  Copyright (c) 2014 Six Sided Studio. All rights reserved.
//
#import "NSDate+Rails.h"

static NSString *RailsFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
static NSString *RailsTimeZoneFormat = @"yyyy-MM-dd'T'HH:mm.sssZZZZ";


@implementation NSDate (Rails)

+ (NSDate *)convertRailsDateTime:(NSString *)dateTime {    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:RailsFormat];
   // df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:-5];
    return [df dateFromString:dateTime];
}

+ (NSDate *)railsDateTimeNow {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:RailsFormat];
    NSString *str = [df stringFromDate:[NSDate date]];
    return [NSDate convertRailsDateTime:str];
}

+ (NSDate *)dateFromDate:(NSString *)dateString {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    return [df dateFromString:dateString];
}

+ (NSString *)timeForDateTime:(NSString *)dateTime {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:-5];
    [df setDateFormat:@"h:mm a"];
    return [df stringFromDate:[self convertRailsDateTime:dateTime]];
}

+ (NSString *)dateForDateTime:(NSString *)dateTime {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:-5];
    [df setDateFormat:@"E"];
    return [df stringFromDate:[self dateFromDate:dateTime]];
}


@end
