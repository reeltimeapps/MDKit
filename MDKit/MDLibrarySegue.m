//
//  MDLibrarySegue.m
//  MDKit
//
//  Created by Matthew Dicembrino on 5/19/13.
//  Copyright (c) 2013 Six Sided Studio. All rights reserved.
//

#import "MDLibrarySegue.h"
#import <QuartzCore/QuartzCore.h>

@interface MDLibrarySegue ()

@property (strong, nonatomic) NSString *transitionType;
@property (strong, nonatomic) NSString *transitionSubtype;
@end

@implementation MDLibrarySegue

- (id)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination {
    self = [super initWithIdentifier:identifier source:source destination:destination];
    if (self) {
        
    }
    return self;
}

- (void)_landscapeRightTransitions {
    if ([self isUnwinding]) {
        self.transitionType = kCATransitionReveal;
        self.transitionSubtype = kCATransitionFromLeft;
    } else {
        self.transitionType = kCATransitionMoveIn;
        self.transitionSubtype = kCATransitionFromRight;
    }
}

- (void)_landscapeLeftTransitions {
    if ([self isUnwinding]) {
        self.transitionType = kCATransitionReveal;
        self.transitionSubtype = kCATransitionFromRight;
    } else {
        self.transitionType = kCATransitionMoveIn;
        self.transitionSubtype = kCATransitionFromLeft;
    }
}

- (void)_portraitTransitions {
    if ([self isUnwinding]) {
        self.transitionType = kCATransitionReveal;
        self.transitionSubtype = kCATransitionFromTop;
    } else {
        self.transitionType = kCATransitionMoveIn;
        self.transitionSubtype = kCATransitionFromBottom;
    }
}

- (void)perform {
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];

    if (orientation == UIInterfaceOrientationLandscapeRight) {
        [self _landscapeRightTransitions];
    }
    else if (orientation == UIInterfaceOrientationLandscapeLeft) {
        [self _landscapeLeftTransitions];
    }
    else {
        [self _portraitTransitions];
    }
    
    UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
    UIViewController *destinationController = (UIViewController*)[self destinationViewController];
    
    CATransition* transition = [CATransition animation];
    transition.duration = .5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = _transitionType; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = _transitionSubtype; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
        
    
    [sourceViewController.navigationController.view.layer addAnimation:transition
                                                                forKey:kCATransition];
    
    if ([self isUnwinding]) {
        [sourceViewController.navigationController popViewControllerAnimated:NO];
    } else {
        [sourceViewController.navigationController pushViewController:destinationController animated:NO];
    }
}

@end
