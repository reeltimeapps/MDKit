//
//  NSString+Formatting.m
//   MDKit
//
//  Created by Matthew Dicembrino on 11/1/12.
//  Copyright (c) 2014 Six Sided Studio. All rights reserved.
//

#import "NSString+Formatting.h"

@implementation NSString (Formatting)

+ (NSString *)stringWithCommasForNumber:(NSNumber *)number {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
    [formatter setGroupingSeparator:groupingSeparator];
    [formatter setGroupingSize:3];
    [formatter setAlwaysShowsDecimalSeparator:NO];
    [formatter setUsesGroupingSeparator:YES];
    return [formatter stringFromNumber:number];
}

- (NSString *)usernameForMention {
    NSArray *comps = [self componentsSeparatedByString:@"@"];
    if (comps.count > 1) {
        return comps[1];
    }
    return comps[0];
}

- (BOOL)stringContainsCharacters {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    if ([[self stringByTrimmingCharactersInSet: set] length] == 0) {
        return NO;
    }
    return YES;
}

@end
