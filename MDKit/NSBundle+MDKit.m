//
//  NSBundle+MDKit.m
//  MDKit
//
//  Created by Matthew Dicembrino on 12/11/13.
//  Copyright (c) 2013 Six Sided Studio. All rights reserved.
//

#import "NSBundle+MDKit.h"

@implementation NSBundle (MDKit)

+ (NSBundle *)mdkitResources {
    static dispatch_once_t onceToken;
    static NSBundle *mdkitResources = nil;
    dispatch_once(&onceToken, ^{
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"MDKit-Resources" withExtension:@"bundle"];
        if (url) {
            mdkitResources = [NSBundle bundleWithURL:url];
        } else {
            mdkitResources = [NSBundle mainBundle];
        }
    });
    return mdkitResources;

}

@end
