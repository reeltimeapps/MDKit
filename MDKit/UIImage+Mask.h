//
//  UIImage+Mask.h
//  Slide
//
//  Created by Matthew Dicembrino on 8/30/13.
//  Copyright (c) 2013 Blue Whale Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (Mask)

+ (UIImage *)maskImage:(UIImage *)image withMask:(UIImage *)mask;

@end
