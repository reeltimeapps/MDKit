//
//  UIBarButtonItem+Custom.m
//  MDKit
//
//  Created by Matthew Dicembrino on 8/20/13.
//  Copyright (c) 2014 Six Sided Studio. All rights reserved.
//

#import "UIBarButtonItem+Custom.h"

@implementation UIBarButtonItem (Custom)

+ (UIBarButtonItem *)backButton:(id)target action:(SEL)action {
    UIImage *backImage = [UIImage imageNamed:@"back.png"];
    return [[UIBarButtonItem alloc] initWithCustomView:[self buttonWithImage:backImage target:target action:action]];
}

+ (UIBarButtonItem *)hamburger:(id)target action:(SEL)action {
    UIImage *burgerking = [UIImage imageNamed:@"hamburger"];
    return [[UIBarButtonItem alloc] initWithCustomView:[self buttonWithImage:burgerking target:target action:action]];
}

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    return [[UIBarButtonItem alloc] initWithCustomView:[self buttonWithImage:image target:target action:action]];
}

+ (UIButton *)buttonWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setAdjustsImageWhenHighlighted:NO];
    return button;
}

@end
