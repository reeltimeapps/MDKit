//
//  PLNavigationController.m
//  MDKit
//
//  Created by Matthew Dicembrino on 5/20/13.
//  Copyright (c) 2013 Six Sided Studio. All rights reserved.
//

#import "MDNavigationController.h"
#import "MDCameraSegue.h"

@interface MDNavigationController ()

@end

@implementation MDNavigationController

- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier  {
    if ([identifier isEqualToString:@"UnwindToAssetsLibrary"]) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        MDCameraSegue *segue = [[MDCameraSegue alloc] initWithIdentifier:identifier source:fromViewController destination:toViewController];
        segue.unwind = YES;
        return segue;
    }
    return NULL;
}

@end
