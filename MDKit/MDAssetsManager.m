//
//  MDAssetsManager.m
//  Slide
//
//  Created by Matthew Dicembrino on 9/3/13.
//  Copyright (c) 2013 Blue Whale Inc. All rights reserved.
//

#import "MDAssetsManager.h"

@implementation MDAssetsManager

+ (MDAssetsManager *)sharedInstance {
    static MDAssetsManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[MDAssetsManager alloc] init];
    });
    return _sharedInstance;
}

- (ALAssetsLibrary *)defaultAssetsLibrary {
    static ALAssetsLibrary *_defaultAssetsLibrary = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultAssetsLibrary = [[ALAssetsLibrary alloc] init];
    });
    return _defaultAssetsLibrary;
}

@end
