//
//  NSDate+Rails.h
//  Sliide
//
//  Created by Matthew Dicembrino on 8/26/13.
//  Copyright (c) 2013 Blue Whale Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Rails)

+ (NSDate *)convertRailsDateTime:(NSString *)dateTime;

+ (NSDate *)railsDateTimeNow;

+ (NSDate *)dateFromDate:(NSString *)dateString;

+ (NSString *)timeForDateTime:(NSString *)dateTime;

+ (NSString *)dateForDateTime:(NSString *)dateTime;

@end
