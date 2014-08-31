//
//  MDAlertView.m
//  
//
//  Created by Matthew Dicembrino on 2012-07-31.
//  Copyright (c) 2012 Matthew Dicembrino. All rights reserved.
//

#import "MDAlertView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MDAlertView

+ (MDAlertView *)showAlertInView:(UIView *)view message:(NSString *)message autoHide:(BOOL)autoHide {

    MDAlertView *alert = [[MDAlertView alloc] init];
    
    //Set the frame to our minimum size dimensions
    alert.frame = CGRectMake(0, 0, 150, 50);
    alert.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.75];
    alert.layer.cornerRadius = 5.0;
    
    //Create a textLabel with the dimensions of the HudView, and add to the HudView.
    alert.textLabel = [[UILabel alloc] initWithFrame:alert.frame];
    alert.textLabel.text = message;
    alert.textLabel.backgroundColor = [UIColor clearColor];
    alert.textLabel.textAlignment = NSTextAlignmentCenter;
    alert.textLabel.textColor = [UIColor whiteColor];
    alert.textLabel.font = [UIFont systemFontOfSize:16.0];
    [alert addSubview:alert.textLabel];
    
    CGFloat width = [alert calculateLabelWidth:alert.textLabel];
    
    CGRect newFrame = alert.frame;
    newFrame.size.width = width + 20.0;
    alert.frame = newFrame;
    
    CGRect labelFrame = alert.textLabel.frame;
    labelFrame.size.width = width;
    alert.textLabel.frame = newFrame;
    alert.textLabel.center = alert.center;
    alert.center = view.superview.center;

    alert.alpha = 0.0;
    [view.window addSubview:alert];
    
    [alert fadeIn:alert autoHide:autoHide];
    return alert;

}

- (void)hide {
    [self hideAlert:self];
}

- (void)fadeIn:(MDAlertView *)alert autoHide:(BOOL)autoHide{
    [UIView animateWithDuration:0.10
                     animations:^ {
                         alert.alpha = 1.0;
                     } completion:^ (BOOL finished) {
                         if (autoHide) {
                             [alert performSelector:@selector(hideAlert:) withObject:alert afterDelay:2.5];
                         }
                     }];
}

- (void)hideAlert:(MDAlertView *)alert {
    [UIView animateWithDuration:0.10
                     animations:^ {
                         alert.alpha = 0.0;
                     } completion:^ (BOOL finished) {
                         [alert removeFromSuperview];
                     }];
}


- (CGFloat)calculateLabelWidth:(UILabel *)label {
    CGSize maximumLabelSize = CGSizeMake(300, 20000.0f);
    
    return [label sizeThatFits:maximumLabelSize].width;
}

@end
