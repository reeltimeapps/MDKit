//
//  UIBarButtonItem+Custom.h
//  MDKit
//
//  Created by Matthew Dicembrino on 8/20/13.
//  Copyright (c) 2013 Six Sided Sutdio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIBarButtonItem (Custom)

+ (UIBarButtonItem *)backButton:(id)target action:(SEL)action;
+ (UIBarButtonItem *)hamburger:(id)target action:(SEL)action;
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;
@end
