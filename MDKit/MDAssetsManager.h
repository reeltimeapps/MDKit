//
//  MDAssetsManager.h
//   MDKit
//
//  Created by Matthew Dicembrino on 9/3/13.
//  Copyright (c) 2014 Six Sided Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface MDAssetsManager : NSObject


+ (MDAssetsManager *)sharedInstance;
- (ALAssetsLibrary *)defaultAssetsLibrary;


@end
