//
//  MDHudView.m
//  HMY
//
//  Created by Matthew Dicembrino on 9/14/12.
//  Copyright (c) 2012 Six Sided Studio. All rights reserved.
//

#import "MDHudView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MDHudView

+ (MDHudView *)showHudInView:(UIView *)view title:(NSString *)title {
    
    MDHudView *hud = [[MDHudView alloc] init];
    
    hud.frame = CGRectMake(0, 0, 150, 50);
    hud.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.75];
    hud.layer.cornerRadius = 5.0;
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    CGRect newFrame = activity.frame;
    newFrame.origin.x = 15;
    newFrame.origin.y = (hud.frame.size.height - activity.frame.size.height) / 2;
    activity.frame = newFrame;
    [activity startAnimating];
    [hud addSubview:activity];
    
    int x = activity.frame.origin.x + activity.frame.size.width;
    
    hud.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, hud.frame.size.width - x, 50)];
    hud.textLabel.text = title;
    hud.textLabel.backgroundColor = [UIColor clearColor];
    hud.textLabel.textAlignment = NSTextAlignmentCenter;
    hud.textLabel.textColor = [UIColor whiteColor];
    hud.textLabel.font = [UIFont systemFontOfSize:16.0];
    [hud addSubview:hud.textLabel];
    hud.center = view.center;
    hud.alpha = 0.0;
    [view addSubview:hud];
    
    [hud fadeIn:hud];
    
    return hud;
    
}

/*
 Animate the Hud onscreen
 @param hud The HudView to be animated
 */
- (void)fadeIn:(MDHudView *)hud {
    [UIView animateWithDuration:0.10
                     animations:^ {
                         hud.alpha = 1.0;
                     } completion:^ (BOOL finished) {
                     }];
}

/*
 Animate the Hud offscreen
 @param hud The HudView to be animated
 */
- (void)hide {
    [UIView animateWithDuration:0.10
                     animations:^ {
                         self.alpha = 0.0;
                     } completion:^ (BOOL finished) {
                         //Remove the HudView from the view hierarchy
                         [self removeFromSuperview];
                     }];
}


@end
