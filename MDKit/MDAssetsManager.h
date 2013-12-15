//
//  MDAssetsManager.h
//  Slide
//
//  Created by Matthew Dicembrino on 9/3/13.
//  Copyright (c) 2013 Blue Whale Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface MDAssetsManager : NSObject


+ (MDAssetsManager *)sharedInstance;
- (ALAssetsLibrary *)defaultAssetsLibrary;


@end
