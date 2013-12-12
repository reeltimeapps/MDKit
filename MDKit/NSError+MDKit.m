//
//  NSError+MDKit.m
//  MDKit
//
//  Created by Matthew Dicembrino on 8/23/13.
//  Copyright (c) 2013 Six Sided Studio. All rights reserved.
//

#import "NSError+MDKit.h"

@implementation NSError (MDKit)

+ (NSError *)descriptorErrorWithDomain:(NSString *)domain code:(NSInteger)code descriptor:(NSDictionary *)dict {
    NSDictionary *userInfo = nil;
    if (dict) {
        userInfo = @{NSLocalizedDescriptionKey: dict};
    }
    return [NSError errorWithDomain:domain code:code userInfo:userInfo];
}
@end
