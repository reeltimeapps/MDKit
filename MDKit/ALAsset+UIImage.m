//
//  ALAsset+UIImage.m
//  MDKit
//
//  Created by Matthew Dicembrino on 9/5/13.
//  Copyright (c) 2014 Six Sided Studio. All rights reserved.
//

#import "ALAsset+UIImage.h"

@implementation ALAsset (UIImage)

- (UIImage *)originalImage {
   // UIImageOrientation orientation = UIImageOrientationUp;
   // NSNumber* orientationValue = [self valueForProperty:ALAssetPropertyOrientation];
    //if (orientationValue != nil) {
      //  orientation = [orientationValue intValue];
    //}
    ALAssetRepresentation *assetRepresentation = [self defaultRepresentation];
    
    UIImage *originalImage = [UIImage imageWithCGImage:assetRepresentation.fullScreenImage
                                                 scale:assetRepresentation.scale
                                           orientation:UIImageOrientationUp];
    return originalImage;
}

@end
