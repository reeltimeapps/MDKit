//
//  UIScreen+Retina.m
//  MDKit
//
//  Created by Matthew Dicembrino on 2/11/13.
//
//

#import "UIScreen+Retina.h"

@implementation UIScreen (Retina)

+ (BOOL)isRetina {
    CGFloat scale = [UIScreen mainScreen].scale;
    if (scale == 1.0) {
        return NO;
    }
    return YES;
}

@end
