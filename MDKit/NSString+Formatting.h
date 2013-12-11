//
//  NSString+Formatting.h
//  BlackPlanet
//
//  Created by Matthew Dicembrino on 11/1/12.
//  Copyright (c) 2012 Blue Whale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Formatting)

+ (NSString *)stringWithCommasForNumber:(NSNumber *)number;
- (NSString *)usernameForMention;
- (BOOL)stringContainsCharacters;

@end
