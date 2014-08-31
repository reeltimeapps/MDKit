//
//  UIImage+Mask.h
//  MDKit
//
//  Created by Matthew Dicembrino on 8/30/13.
//  Copyright (c) 2014 Six Sided Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (Mask)

+ (UIImage *)maskImage:(UIImage *)image withMask:(UIImage *)mask;

@end
