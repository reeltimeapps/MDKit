//
//  NSError+MDKit.h
//  MDKit
//
//  Created by Matthew Dicembrino on 8/23/13.
//  Copyright (c) 2013 Six Sided Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (MDKit)

+ (NSError *)descriptorErrorWithDomain:(NSString *)domain code:(NSInteger)code descriptor:(NSDictionary *)dict;

@end
